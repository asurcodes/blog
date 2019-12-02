+++
draft = true
date = "2019-12-06T16:52:05+02:00"
publishdate = "2019-12-06T16:52:05+02:00"

title = "Metablog #7 - SSR de AMP en build time con GH actions"

description = "La idea de AMP es ofrecer una web más rápida y segura, ¿pero sabías que aún se puede optimizar más con Server Side Rendering?"

summary = "Toda la idea sobre el proyecto de AMP es ofrecer una web más **rápida y segura**, ¿pero sabías que aún se puede optimizar más con **Server Side Rendering**? Pues si, y adivina qué, lo he implementado en mi propia **GitHub Action**!"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'github actions', 'ssr', 'amp', 'optimizacion']

[amp]
    elements = []

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = "/images/amp-ssr-en-build-time-con-github-actions.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# SSR de AMP en build time con GH actions

{{% under-title %}}

Toda la idea sobre el proyecto de **AMP** es ofrecer una web más rápida y segura, ¿pero sabías que aún se puede optimizar más con **Server Side Rendering**? Pues si, y adivina qué, lo he implementado en mi propia **GitHub Action**!

{{% toc %}}

## ¿Para qué sirve el SSR en AMP? 🤔

Esa es la pregunta del millón, AMP se supone que ya proporciona un rendimiento excelente, pero nada es perfecto y hay algunos puntos de mejora.

El cambio más destacable se ve en el tiempo de FCP (First Contentful Paint), que **puede reducirse hasta un 50%**!!

Todo esto es gracias a que el script de preprocesado elimina el código de `<style amp-boilerplate>` y creando el layout en el servidor, para evitar recálculos en el cliente.

El kit de la cuestión es que ese estilo de **AMP boilerplate oculta el contenido mientras se calcula la distribución de la página**, si eliminamos la necesidad de ese cálculo nuestra página se muestra directamente, sin esperas.

> ¿Y por qué no aplicamos estas mejoras a mano?

Ese es el problema, estas mejoras se podrían implementar a mano, pero es surrealista por la mera cantidad de propiedades y variaciones que hay que aplicar. Un ejemplo:

{{< amp-image
    class="post__image"
    alt="Comparación de página AMP normal contra procesada"
    src="/images/comparacion-amp-normal-vs-ssr.png"
    width="1600"
    height="480"
    layout="responsive" >}}

La única opción viable es automatizarlo con un script que busque los elementos en el DOM y les aplique los cambios necesarios.

Para esto ya existen dos librerías opensource:

 - [AMP Optimizer](https://www.npmjs.com/package/amp-toolbox-optimizer): Escrita en JavaScript, se puede descargar e instalar por NPM. También cuenta con un middleware para Express.
 - [AMP Packager](https://github.com/ampproject/amppackager/tree/releases/transformer/): Escrita en Golang, algo más rápido. Requiere de *Signed exchages* para que los cambios sean válidos.

Estas librerías no solo eliminan el boilerplate de AMP, hacen muchas más cosas, como dns-prefetchs automáticos, elimina comentarios y mucho más ([Lista completa de cambios](https://github.com/ampproject/amphtml/blob/master/spec/amp-cache-modifications.md)).

Si te interesa puedes ver una [comparativa de rendimiento detallada](https://blog.amp.dev/2018/10/08/how-to-make-amp-even-faster/) en el blog oficial de AMP, en el que hacen un antes y después en distintos escenarios.

**DATO**: Este mismo procesado lo realiza Google sobre tu AMP antes de guardarlo en la cache, lo que le da esa sensación de carga instantanea.

## Creación y despliegue en GitHub Actions 😺

Vale, una vez ya me he informado y leído sobre el tema tengo claro que **lo quiero en mi blog**, así que me descargo las librerías y empiezo a probar.

Según ponen en la documentación, **la manera ideal de aplicar las tranformaciones en en build time**, dejando como alternativa tranformar y cachear los request on the fly.

Como algunos ya sabréis, para buildear y desplegar este site utilizo GitHub Actions, pero no había nada en el Marketplace, así que decidí hacer la mía propia.

### Script de bash

La primera decisión es cual de las dos librerías utilizo. Cloudflare ya da la opción de habilitar *signed exchages* para AMP, así que elijo la librería de Go ya que no tengo esa limitación.

Ahora me encuentro con dos problemas:

 - El contenido formateado se escribe en *stdout* y no hay una opción en el comando para que modificase el fichero directamente.
 - No solo cuento con un fichero, si no con N y encima en un directorio sin una estructura concreta, así que necesito algún tipo de recursividad.

Esta es a la solución que he llegado utilizando un script de bash:

{{< highlight bash "linenos=table" >}}

#!/bin/bash

for file in $(find ${INPUT_ROOT} -name "*.html"); do
    [ -f "$file" ] || break
    echo "Optimizing $file" 
    ! $GOPATH/bin/transform $file > /tmp/optimized.txt
    [ -s /tmp/optimized.txt ] && cat /tmp/optimized.txt > $file || echo "Not a valid AMP page. Omitting..."
done

{{< / highlight >}}

Con el comando `find` puedo buscar recursivamente todos los ficheros con la extensión `html`.

Ejecuto el transformador y pongo el contenido en un fichero intermedio. Puede parecer un paso innecesario, pero resulta que `$GOPATH/bin/transform $file > $file` no funciona, necesito un buffer!

Una vez guardado el contenido en el fichero buffer ya se puede sobreescribir el contenido del fichero original.

### Dockerización

Hay dos opciones para crear una GitHub Actions, que se base en una imagen de docker o que ejecute javascript.

He elegido la primera porque al utilizar solo bash me es más cómodo y el build time de mi contenedor es mínimo, pero si que normalmente **la opción de javascript se ejecuta más rápido**  al no necesitar construir la imagen.

Me he limitado a instalar el paquete del tranformadora y empaquetar el script anterior de bash en un `entrypoint.sh`. Así queda mi extensísimo Dockerfile:

{{< highlight dockerfile "linenos=table" >}}

FROM golang:latest

RUN go get -u github.com/ampproject/amppackager/cmd/transform

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

{{< / highlight >}}

### Publicación en el marketplace

A la hora de publicar el proyecto en el marketplace de GitHub necesitas pasar ciertas validaciones. Lo más importante es tener tu action documentada en el `README.md`.

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

Con esto ya está todo listo! Podemos crear una versión y [publicarla en el marketplace](https://github.com/marketplace/actions/amp-optimizer-action)!

Ahora cualquier persona que quiera utilizarla en su proceso lo único que tiene que añadir es un *step* a su fichero `yml` como este:

{{< highlight bash "linenos=table" >}}

- name: Optimize AMP
  uses: asurbernardo/amp-optimizer-action@1.0.2
  with:
    root: './public'

{{< / highlight >}}

CLAP! CLAP! CLAP! 👏

## Próximo destino 🛣️

He publicado hace poco un *side project* para probar el soporte de h3 en un solo paso online: [http3.support](https://http3.support), estoy preparando un post para la nueva sección en inglés sobre el proceso. *Stay tuned!* 😎 🇬🇧