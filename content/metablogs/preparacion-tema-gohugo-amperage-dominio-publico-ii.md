+++
draft = false
date = "2019-12-13T12:39:05+02:00"
publishdate = "2019-12-13T12:39:05+02:00"

title = "Metablog #9 - Preparando Amperage para el dominio público (II)"

description = "Segunda tanta de funcionalidades antes de publicar Amperage, hay que reorganizar el código, hacer un proyecto de ejemplo y una demo para mostrar los componentes"

summary = "Segunda tanda de funcionalidades preparando la publicación de Amperage, toca **reorganizar el código**, crear un **proyecto de ejemplo** para que los usuarios puedan empezar rápido con su propia web y un **kitchen sink** para mostrar todos los componentes del tema en el mismo sitio!"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'amperage', 'publicación', 'tema']

[amp]
    elements = []

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

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

{{< under-title >}}

Un solo post se me quedó corto la semana pasada así que aquí está la segunda remesa de cambios para el tema!

Estos cambios son bastante menos interesantes (*IMHO*) pero son necesarios para poder llegar a publicar Amperage y he querido documentarlos igualmente.

{{< toc >}}

## Shortcodes para usabilidad 💻

A la hora de escribir no es muy cómodo tener que utilizar HTML directamente para añadir componentes de AMP así que he creado *shortcodes* para los más comunes.

Los shortcodes son una funcionalidad de Hugo, son plantillas que luego puedes usar al escribir en markdown. A la hora de escribir un post se ven así:

{{< highlight md "linenos=table" >}}

{{</* toc */>}}

{{</* amp-image
    alt="El texto alternativo para la imagen"
    src="/images/imagen.jpg"
    width="1280"
    height="720"
    layout="responsive" */>}}

{{< / highlight >}}

He creado los shortcodes:

 - **toc**: Permite añadir la tabla de contenidos dentro del propio cuerpo del post.
 - **under-title**: Imprime el *bajotítulo*, que incluye la fecha, las tags y los botones para compartir.
 - **amp-image**: Facilita el uso de imagenes de AMP dentro del post.
 - **amp-gif**: Idem pero para `amp-anim`.
 - **amp-video**: Idem pero para `amp-video`.
 - **amp-iframe**:  Idem pero para `amp-iframe`.

Algunos shortcodes son muy similares al HTML que imprimen (como el de `amp-image`), pero usarlos me permite añadirles lógica en sus respectivas plantillas, como convertir las URLs de `src` en absolutas o validar algunos atributos.

Iré añadiendo más a medida que los vaya necesitando. Algunos de estos shortcodes los he sacado del tema [gohugo-amp toolbox](https://gohugo-amp.gohugohq.com/) y los he modificado un poco.

## Parcialización del tema 🍱

Cuando te instalas un tema es muy útil que esté bien parcializado. ¿Por qué? Pues por cómo funciona el [lookup order de Hugo](https://gohugo.io/templates/lookup-order/).

El *lookup order* es una especie de sistema de herencia y puedes usarlo sobreescribir elementos concretos de tu tema. La idea es que cuanto más atómicos sean estos elementos menos hay que sobreescribir y más fácil es personalizar el tema a tu gusto.

He convertido en *partials* mucho código y reorganizado todo de nuevo para mejorar la *dev experience*. La nueva estructura es esta:

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

Para registrar tu tema necesitas una demo funcional que se buildea automáticamente al publicarlo. Para esto necesitas que sea compatible con el proyecto `hugo-basic-example` o proporcionar tú mismo la demo en el directorio `/exampleSite`.

He optado por la segunda opción para que ya tuviese funcionalidad de PWA y datos estructurados *out of the box*.

Este es el paso que con diferencia más tiempo me ha llevado porque a medido que iba avanzando me he ido dando cuenta de todas las cosas que me faltaban, que eran bastantes!

Una vez acabé el site de ejemplo se puede probar a buildear en la página de [hugoThemes](https://github.com/gohugoio/hugoThemes). Al ser *open source* se puede descargar e introducir tu propio tema a mano para ver si en tu local esta todo bien! El resultado:

{{< amp-image
    alt="Inspiración inicial para el estilo del blog"
    src="/images/preparacion-tema-gohugo-amperage-dominio-publico/amperage-en-hugo-themes.jpg"
    width="1887"
    height="714"
    layout="responsive" >}}

Tiene buena pinta! 👍

## Kitchen sink ⏲️

No conocía este término hasta que empecé a investigar cómo crear un tema y resulta que existe algo llamado *kitchen sink*. Por lo visto viene de un dicho en inglés:

> Everything but the kitchen sink

Significa literalmente *"todo lo que te puedas imaginar"* y se utiliza en el contexto de programación para demos que incluyen todos los componentes de un proyecto.

Pues a eso me he dedicado. De momento no es muy extenso pero espero ir actualizándolo a medida que el tema vaya creciendo! ([Kitchen sink de Amperage](https://asur.dev/en/amperage/theme-kitchen-sink))

## Navegación instantanea ⚡

Una de las features que no estaba aprovechando de los service workers es el *link prefetch*.

Esta feature permite que un enlace se cargue de manera proactiva (*eager loading*). De esta manera al navegar la página se recupera de cache en vez de hacer una petición, lo que da la sensación de navegación instantanea.

Para que la librería de `amp-sw` detecte los links tengo que añadir `data-rel="prefetch"` a los *anchors*, el resto es automático.

## Próximo destino 🛣️

Pues creo que ha quedado claro lo que me queda por hacer, voy a preparar el issue para que mi tema sea oficializado! *Stay tuned!* 😎

**UPDATE:** Puedes seguir el [issue en el proyecto de hugoThemes](https://github.com/gohugoio/hugoThemes/issues/782#issuecomment-566133671) que he creado para solicitar que incluyan Amperage.

## Wayback Machine ⏰

Ver la [versión original de este post](https://web.archive.org/web/20191214175550/https://asur.dev/metablogs/preparacion-tema-gohugo-amperage-dominio-publico-ii/ "Versión original del post").

Ver la [versión original de la homepage](https://web.archive.org/web/20191214175520/https://asur.dev/ "Versión original de la homepage").