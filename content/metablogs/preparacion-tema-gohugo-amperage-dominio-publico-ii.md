+++
draft = false
date = "2019-12-15T10:19:05+02:00"
publishdate = "2019-12-15T10:19:05+02:00"

title = "Metablog #9 - Preparando Amperage para el dominio público (II)"

description = "Segunda tanta de funcionalidades antes de publicar Amperage, hay que reorganizar el código, hacer un proyecto de ejemplo y una demo para mostrar los componentes"

summary = "Segunda tanda de funcionalidades preparando la publicación de Amperage, toca **reorganizar el código**, crear un **proyecto de ejemplo** para que los usuarios puedan empezar rápido con su propia web y un **kitchen sink** para demostrar todos los componentes del tema en el mismo sitio!"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'amperage', 'publicación', 'tema']

[amp]
    elements = []

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = "/images/preparacion-tema-gohugo-amperage-dominio-publico/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Preparando Amperage para el dominio público (II)

{{% under-title %}}

Un solo post se me quedó corto la semana pasada así que aquí está la segunda remesa de cambios para el tema!

{{% toc %}}

## Shortcodes para usabilidad 💻

A la hora de escribir no es muy cómodo tener que utilizar HTML directamente para añadir componentes de AMP así que he creado *shortcodes* para los más comunes.

Los shortcodes son una funcionalidad de Hugo, son plantillas que luego puedes usar al escribir en markdown.

He creado los shortcodes:

 - toc
 - under-title
 - amp-image
 - amp-gif
 - amp-video
 - amp-iframe

Algunos shortcodes son muy similares al HTML que imprimen, pero usarlos me permite añadir lógica, como convertir las URLs de `src` en absolutas.

Iré añadiendo más a medida que los vaya necesitando. Algunos de estos shortcodes los he sacado del tema [gohugo-amp toolbox](https://gohugo-amp.gohugohq.com/) y los he modificado un poco.

## Parcialización del tema 🍱

Cuando te instalas un tema es muy útil que esté parcializado. ¿Por qué? Pues por el [lookup order de Hugo](https://gohugo.io/templates/lookup-order/).

El *lookup order* es una especie de sistema de herencia y puedes usarlo sobreescribir elementos concretos de tu tema. La idea es que cuanto más atómicos sean estos elementos menos hay que sobreescribir y más fácil es personalizar el tema a tu gusto.

He convertido en *partials* mucho código y reorganizado todo de nuevo para mejor *dev experience*. La nueva estructura es esta:

 - page/
   - install-sw.html
   - analytics.html
   - pagination.html
 - head/
   - base.html
   - pagination-metatags.html
   - language-metatags.html
   - og-metatags.html
   - twitter-cards-metatags.html
   - pwa-metatags.html
   - styles.html
   - amp-components.html
 - structured-data/
   - base.html
   - article.html
   - breadcrumbs.html
   - carousel.html
   - website.html
 - header/
   - base.html
   - logo.html
   - menu.html
 - footer/
   - base.html
   - language-menu.html
 - post/
   - base.html
   - related-content.html
 - shortcodes/
   - under-title.html
   - toc.html
   - amp-image.html
   - amp-gif.html
   - amp-video.html
   - amp-iframe.html

## Example site 🦆

Para registrar tu tema necesitas una demo funcional que se buildea automáticamente al publicar tu tema. Para esto necesitas que tu tema sea compatible con el proyecto `hugo-basic-example` o proporcionar tú mismo la demo en el directorio `/exampleSite`.

He optado por la segunda opción para poder proporcionar ya funcionalidad de PWA y datos estructurados *out of the box*.

Este es el paso que con diferencia más me ha llevado porque me he ido dando cuenta de todas las cosas que me faltaban!

## Kitchen sink ⏲️

No conocía este término hasta que empecé a investigar cómo crear un tema y resulta que hay un término llamado *kitchen sink*. Por lo visto hay un dicho en inglés:

> Everything but the kitchen sink

Significa literalmente *"todo lo que te puedas imaginar"* y se utiliza en el contexto de programación para demos con todos los componentes de un proyecto.

Pues a eso me he dedicado. De momento no es muy extenso pero espero ir actualizándolo a medida que el tema vaya creciendo! ([Kitchen sink de Amperage](https://asur.dev/en/amperage/theme-kitchen-sink))

## Próximo destino 🛣️

Pues creo que ha quedado claro lo que me queda por hacer, voy a preparar el issue para que mi tema sea oficializado! *Stay tuned!* 😎

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").

Ver la [versión original de la homepage](# "Versión original de la homepage").