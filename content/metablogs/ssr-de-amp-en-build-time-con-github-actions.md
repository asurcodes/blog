+++
draft = false
date = "2019-12-05T09:52:05+02:00"
publishdate = "2019-12-05T09:52:05+02:00"

title = "Metablog #7 - SSR de AMP en build time con GH actions"

description = "La idea de AMP es ofrecer una web más rápida y segura, ¿pero sabías que aún se puede optimizar más con Server Side Rendering?"

summary = "Toda la idea sobre el proyecto de AMP es ofrecer una web más **rápida y segura**, ¿pero sabías que aún se puede optimizar más con **Server Side Rendering**? Pues si, y adivina qué, lo he implementado en mi propia **GitHub Action**!"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'github actions', 'ssr', 'amp', 'optimizacion']

[amp]
    elements = []

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

[image]
    src = "/images/amp-ssr-en-build-time-con-github-actions/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# SSR de AMP en build time con GH actions

{{% under-title %}}

Toda la idea sobre el proyecto de **AMP** es ofrecer una web más rápida y segura, ¿pero sabías que se puede optimizar aún más con **Server Side Rendering**? Pues si, y adivina qué, lo he implementado en mi propia **GitHub Action**!

{{% toc %}}

## ¿Para qué sirve el SSR en AMP? 🤔

Esa es la pregunta del millón, AMP se supone que ya proporciona un rendimiento excelente, pero nada es perfecto y hay algunos puntos de mejora.

El cambio más destacable se ve en el tiempo de FCP (*First Contentful Paint*), que **puede reducirse hasta un 50%**!!

Esta mejora se debe a que el script de preprocesado elimina el código de `<style amp-boilerplate>`.

El kit de la cuestión es que ese estilo de **AMP boilerplate oculta el contenido mientras se calcula la distribución del layout**, si eliminamos la necesidad de ese cálculo haciéndolo de antemano nuestra página se muestra directamente, sin esperas.

> ¿Y por qué no aplicamos estas mejoras a mano?

En efecto, estas mejoras se podrían picar a mano, pero no es viable por la mera cantidad de propiedades y variaciones. Un ejemplo de HTML antes y después:

{{< amp-image
    alt="Comparación de página AMP normal contra procesada"
    src="/images/amp-ssr-en-build-time-con-github-actions/comparacion-amp-normal-vs-ssr.png"
    width="1600"
    height="480"
    layout="responsive" >}}

La única opción es automatizarlo con un script que busque los elementos en el DOM y les aplique los cambios necesarios.

Para esto ya existen dos librerías open source:

 - [AMP Optimizer](https://www.npmjs.com/package/amp-toolbox-optimizer): Escrita en JavaScript, se puede descargar e instalar por NPM. También cuenta con un middleware para Express.
 - [AMP Packager](https://github.com/ampproject/amppackager/tree/releases/transformer/): Escrita en Golang, algo más rápida. Requiere de *Signed exchages* para que los cambios sean válidos.

Estas librerías no solo eliminan el boilerplate de AMP, hacen más cosas, como **dns-prefetchs automáticos**, elimina comentarios y muchas más ([Lista completa de cambios](https://github.com/ampproject/amphtml/blob/master/spec/amp-cache-modifications.md)).

Si te interesa puedes ver una [comparativa de rendimiento detallada](https://blog.amp.dev/2018/10/08/how-to-make-amp-even-faster/) en el blog oficial de AMP, en el que comparan cifras antes y después en distintos escenarios.

**DATO CURIOSO**: Este mismo procesado lo realiza Google sobre tu AMP antes de guardarlo en su cache, lo que le da esa sensación de carga instantanea.

## Creación y despliegue en GitHub Actions 😺

Vale, una vez ya me he informado y leído sobre el tema tengo claro que **lo quiero en mi blog**.

Según ponen en la documentación, **la manera ideal de aplicar las tranformaciones en en build time**, dejando como alternativa menos recomendable tranformar y cachear los request *on the fly*.

Como algunos ya sabréis, para buildear y desplegar mi blog utilizo GitHub Actions, pero no había ninguna en el Marketplace que hiciese esto, así que decidí hacer la mía propia y publicarla! 🤓

### Script de bash

La primera decisión es cual de las dos librerías utilizo. Cloudflare ya da la opción de habilitar *signed exchages* para AMP, así que elijo la librería de Go ya que no tengo esa limitación y soy un poco *fanboy*, no te voy a engañar.

Al empezar a probar la librería me encuentro con dos problemas:

 - El contenido formateado se escribe en *stdout* y no hay una opción en el comando para que modificase el fichero directamente.
 - No solo cuento con un fichero, si no con N y encima en un directorio sin una estructura concreta, así que necesito algún tipo de recursividad.

Esta es a la solución a la que he llegado utilizando un script de bash:

{{< highlight bash "linenos=table" >}}

#!/bin/bash

for file in $(find ${INPUT_ROOT} -name "*.html"); do
    [ -f "$file" ] || break
    echo "Optimizing $file"
    ! $GOPATH/bin/transform $file > /tmp/optimized.txt
    [ -s /tmp/optimized.txt ] && cat /tmp/optimized.txt > $file \
      || echo "Not a valid AMP page. Omitting..."
done

{{< / highlight >}}

Con el comando `find` puedo buscar recursivamente todos los ficheros con la extensión `html`.

Ejecuto el transformador y pongo el contenido en un fichero intermedio. Puede parecer un paso innecesario, pero resulta que `$GOPATH/bin/transform $file | > $file` no funciona, necesito un buffer!

Una vez guardado el contenido en el fichero temporal ya se puede sobreescribir el fichero original!

Con esta base ya puedo empezar a pensar en como integrarlo en una Action de verdad.

### Dockerización

Hay dos opciones para crear una GitHub Actions, que se base en una imagen de docker o que ejecute javascript.

He elegido la primera porque al utilizar solo bash me es más cómodo y el build time de mi contenedor es mínimo, pero si que normalmente **la opción de javascript se ejecuta más rápido**  al no necesitar construir una imagen.

Para el *Dockerfile* me he limitado a instalar el paquete del tranformadora y empaquetar el script anterior de bash en un `entrypoint.sh`. Así queda mi extensísimo fichero:

{{< highlight dockerfile "linenos=table" >}}

FROM golang:latest

RUN go get -u github.com/ampproject/amppackager/cmd/transform

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

{{< / highlight >}}

### Publicación en el marketplace

A la hora de publicar el proyecto en el marketplace de GitHub necesitas pasar ciertas validaciones. Lo más importante es tener tu action documentada en el `README.md` al menos con los parámetros aceptados y un ejemplo de uso.

También necesitas un fichero de configuración:

{{< highlight yml "linenos=table" >}}

name: 'AMP optimizer action'
description: 'GitHub Action to optimize AMP HTML files :zap:
  It uses AMP Transformer library. Designed for static web generator pipelines.'
author: 'asurbernardo'
runs:
  using: 'docker'
  image: 'Dockerfile'
branding:
  icon: 'battery-charging'
  color: 'yellow'
inputs:
  root:
    description: 'The root directory to start the search from'
    required: false
    default: '.'

{{< / highlight >}}

Con esto ya está todo listo! Podemos crear una versión de nuestro proyecto en GitHub y [publicarla en el marketplace](https://github.com/marketplace/actions/amp-optimizer-action)!

Ahora cualquier persona que quiera utilizarla en su proceso de despliegue lo único que tiene que añadir es un *step* a su fichero `yml` como este:

{{< highlight bash "linenos=table" >}}

- name: Optimize AMP
  uses: asurbernardo/amp-optimizer-action@1.0.2
  with:
    root: './public'

{{< / highlight >}}

CLAP! CLAP! CLAP! 👏

## Próximo destino 🛣️

Ahora si que si, he tardado un poco más de lo que pensaba en preparar el siguiente post pero confirmo que voy a estrenar la sección en inglés con un post piloto sobre monetización online. *Stay tuned!* 😎 🇬🇧