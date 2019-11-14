+++
draft = false
date = "2019-10-15T11:12:32+02:00"
publishdate = "2019-10-19T14:09:32+02:00"

title = "Metablog #1 - AMP, estilos y otras miscelaneas"

description = "La primera iteración del blog ya ha llegado, hablaré de AMP, diseño y estilos junto con otras miscelaneas como vulnerabilidades en los links de HTML, BEM y el position sticky"

summary = "Bueno, bueno, bueno, parece que la primera iteración del blog ya está aquí! Hay bastantes novedades como una mejora de **layout**, la implementación inicial de **AMP** y más, así que vamos a echarles un ojo, explicarlas y hablar sobre lo que he trasteado y que he aprendido."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'html', 'sass', 'amp', 'web safe fonts', 'grid', 'flexbox']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = ""

[image]
    src = "/images/la-primera-iteracion-amp-estilos-y-miscelanea.jpg"
    title = ""
    author = ""
    link = ""
    license = ""
    licenseLink = ""

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# La primera iteración! AMP, estilos y otras miscelaneas

{{% under-title %}}

Bueno, bueno, bueno, parece que la primera iteración del blog ya está aquí! La verdad que antes de lo que me esperaba, he empezado este proyecto con muchas ganas. Hay bastantes novedades así que vamos a echarles un ojo, explicarlas y hablar sobre las cosas nuevas con las que he trasteado y que he aprendido.

{{% toc %}}

## Los estilos 💅🏻

Para bien o para mal este site siempre va a estar diseñado por mí, puedo pedir feedback o tomar inspiración de otros sites, pero estoy orgulloso de poder decir que todo lo que veis es **100% original**. 

Ya os habréis dado cuenta de que esto ya tiene otra pinta, atrás han quedado los días de estilos por defecto de navegadores y con tan solo **\~100 lineas de Sass** le he dado un rollo más minimalista con un toque de imprenta con el que estoy bastante contento.

Como guía de estilo inicial tomé esta web:

{{< amp-image
    class="post__image"
    alt="Inspiración inicial para el estilo del blog"
    src="/images/design-inspiration.jpg"
    width="1199"
    height="742"
    layout="responsive" >}}

Pero me parecía algo sobrecargado y decidí no implementar algunas características, aún así se puede ver que la elección de fuentes y el estilo de los links son muy similares.

### El layout

Aquí me he decidido a experimentar, el front no es mi especialidad y últimamente he tenido la impresión que con solo Bootstrap y nociones básicas de CSS me estaba quedando un poco atrás, así que he estado explorando las nuevas opciones de maquetación, que tienen nombre propio, **grid** y **flexbox**.

Por lo que he estado investigando, ambos son intercambiables en muchos casos, con algunas limitaciones aquí y allá, pero la convención que más me ha gustado es el utilizar grid para el layout general y flexbox para colocar los elementos dentro de sus contenedores. Lo que he acabo haciendo sería algo así:

{{< highlight scss "linenos=table" >}}

/* Configuramos el padre como grid con 5 columnas y un margen entre ellas de 1em */

body {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    grid-gap: 1em 1em;
}

/* Damos un ancho completo al footer y al header */

header,
footer {
    grid-column: 1 / span 5;
    display: flex;
    justify-content: flex-end;
}

/* Al main le damos 3/5 y al aside 2/5 a continuación del main, por lo que quedará a su derecha */

main {
    grid-column: 1 / span 3;
}
aside {
    grid-column: span 2;
}

/* Como responsive, si la pantalla es pequeña poner el main y el aside a 100% de ancho */

@media (max-width: 1200px) {
    main,
    aside {
        grid-column: 1 / span 5;
    }
    header,
    footer {
        overflow: auto;
        justify-content: flex-start;
    }
}

{{< / highlight >}}

Una distribución clásica pero efectiva, aunque estoy seguro de que la voy a ir cambiando y extendiendo con el tiempo.

**TIP**: Para ver como queda la grid puedes poner el ratón sobre un elemento con `display: grid;` en el inspector de tu navegador y te pinta una representación del estado actual en tiempo real, muy útil para debuguear.

### Style reset

Hace poco en una newsletter semanal de la empresa que trabajo compartieron un [reset de css](https://hankchizljaw.com/wrote/a-modern-css-reset/) que que me ha parecido muy interesante, en el post descompone paso a paso la hoja de estilos y explica porque otras librerías como `normalize.css` ya no son tan necesarias como hace unos años, cuando los navegadores no estaban tan alineados. Total, que después de pegarle una lectura y personalizarlo un poco lo he decidido añadir al tema.

### Web safe fonts

Este es un concepto al que he sido introducido hace poco, resulta que, sorpresa, cada vez las webs dependen más de fuentes externas alojadas en servicios como Google Fonts y similares. No me vais a ver echar culpas, que claramente son de la gente de UI (😜), pero ha habido que ponerle solución, y esta viene en forma de *[fuentes seguras](https://www.w3schools.com/cssref/css_websafe_fonts.asp)*, las fuentes que **siempre** vamos a tener disponibles en el navegador.

En mi humilde opinión se les da poco crédito a estas pobres fuentes, que si son feas, anticuadas, siendo relegadas a meros fallbacks... pues yo he decidido utilizarlas como fuentes principales del tema y no hacer uso de ninguno de los servicios de fuentes mencionados anteriormente.

Las fuentes que he utilizado son:

 - **Helvetica**: Para los títulos.
 - **Courier New**: Para el texto general y contenido.
 - **Lucida Console**: Para el código, tanto en bloque como inline.
 - **Times New Roman**: Para las citas y menciones.

Creo que el resultado es sublime, al menos desde mi limitado gusto estético, y es que además tiene otra ventaja, no tenemos que descargarnos fuentes, por lo que no vamos a tener que lidiar con el [FOUT](https://css-tricks.com/fout-foit-foft/), lo que mejorará tanto la experiencia de usuario como la velocidad de la web. *WIN WIN*.

### Position sticky

Principalmente gracias a las limitaciones de AMP para incluir javascript he descubierto este nuevo atributo de CSS, y como me parece que mucha gente no lo conoce y sigue usando librerías de terceros para conseguir este mismo efecto he decidido incluirlo en el post.

Pues sí, al contrario de lo que pensaba, `position: relative|absolute|fixed;` no son las únicas opciones de posición, resulta que `position: sticky` existe y de hecho tiene buen [soporte en navegadores](https://caniuse.com/#feat=css-sticky) (*fuck you ie11*). Lo podéis ver en acción en la tabla de contenidos de la derecha si haceis scroll.

La mejor explicación que he encontrado por los internetes de como funciona esto es la siguiente:

 > *Funciona como un position relative hasta que llega a un breakpoint en el que se convierte en un position fixed*

Han dado en el clavo, lo único que nos tenemos que asegurar es que el elemento tiene *espacio donde moverse*, me explico, el principal problema que suele haber con esta instrucción es que la gente (yo) asigna el mismo tamaño al elemento sticky y al container, como resultado, nuestro elemento se vuelve sticky un gran total de 0px!! ENHORABUENA!! Me tiré un rato con esto, sí.

La implemetación pinta algo así:

{{< highlight go-html-template "linenos=table" >}}

<aside>
    <div class="aside__wrapper">
        <!-- Table of contents -->
        <h3>Tabla de contenidos</h3>
        {{ .TableOfContents }}
        [...]
    </div>
</aside>

{{< / highlight >}}

Como os comentaba, el elemento `aside__wrapper` se ajusta al contenido y se puede *deslizar* por toda la altura del `aside`.

En el CSS solo tenemos que especificar el tipo de posición y el breakpoint (que dirá en que momento el elemento se vuelve sticky):

{{< highlight scss "linenos=table" >}}

.aside__wrapper {
    position: sticky;
    position: -webkit-sticky;
    top: 1em; /* required breakpoint */
}

{{< / highlight >}}

## El AMP ⚡

La primera persona con la que compartí en primicia la web para que me diese su feedback, en cuanto le echó un vistazo lo primero que me dijo fué:

 > *¿Por qué AMP?* 🤔

Igual se piensa que soy masoquista, pero no, la razón principal es por el **SEO** aunque tampoco voy a negar que me parece un desafío interesante y es una tecnología con la que ya estoy familiariazado, así que he dado los primeros pasos para que esta web sea válida ante Google como una *[Accelerated Mobile Page](https://amp.dev/)*.

No me he roto mucho la cabeza con esto al principio, mi objetivo era que pasase la válidación (yo utilizo [AMP Validator](https://chrome.google.com/webstore/detail/amp-validator/nmoffdblmcmgeicmolmhobpoocbbmknc) para las comprobaciones) y como pretendo que sea **AMP nativo** no he tenido que añadir links ni referencias, y así solo desarrollo una versión, que estamos hablando de un blog, no es una web de la NASA.

Para empezar el primer problema que me encontré es el tener que incrustar los estilos en la cabecera. Me da la impresión de que Hugo, en un principio no esperaba contemplar esta posibilidad, en especial con la llegada de *http/2*, el *package multiplexing* y las *push directives*, pero esto no quiere decir que no sea posible, solo que hay que darle una vuelta extra:

{{< highlight go-html-template "linenos=table" >}}

<style amp-custom>
    {{ with resources.Get "styles.scss" | resources.ToCSS | resources.Minify }}
        {{ .Content | safeCSS }}
    {{ end }}
</style>

{{< / highlight >}}

Lo que tenemos que hacer en vez de compilar en resource en un archivo directamente, es leer el contenido de ese archivo, meterlo en un bloque y transformarlo en CSS, puede parecer una tontería visto así, pero la información sobre este procedimiento es escasa o deprecada, así que a lo tonto me ha llevado un buen rato hacerlo funcionar.

Para acabar, como no tengo ningún elemento especial de momento solo he tenido que añadir la tag de HTML el emoji del rayo (⚡) y el script raíz de AMP (la primera vez que le dije a alguien que se podía sustituir el `<html amp lang="es">` por un emoji pensó que le estaba tomando el pelo, pero os juro que es verdad!)

```
<!DOCTYPE html>
<html ⚡ lang="es">
    <head>
        [...]
        <script async src="https://cdn.ampproject.org/v0.js"></script>
```

Después de asegurarnos de que los posts tienen la etiqueta title y un par de validaciones menores más, listo, ya tenemos una página AMP super básica, pero funcional! 🥳

## La TOC y posts relacionados 🔗

Para empezar a meter el pie en las aguas del *SEO on-page* he implementado las opciones más básicas de interlinking, una tabla de contenidos y una sección de posts relacionados.

Ambos son implementaciones muy directas, ya que están soportados por Hugo de manera nativa (*god bless*).

{{< highlight go-html-template "linenos=table" >}}

<!-- Table of contents -->

<h3>Tabla de contenidos</h3>
{{ .TableOfContents }}

<!-- Related content -->

{{ $related := .Site.RegularPages.Related . | first 3 }}
{{ with $related }}
<h3>Posts relacionados</h3>
<ul>
    {{ range . }}
    <li>
        <div><a href="{{.Permalink }}">{{ .Title }}</a></div>
    </li>
    {{ end }}
</ul>
{{ end }}

{{< / highlight >}}

Como podéis ver, esto de programar está mitificado, para añadir la tabla de contenidos solo hay que incluir en la plantilla `{{ .TableOfContents }}`, Hugo ya detecta por su cuenta los títulos en tu contenido y genera los links.

En cuanto a los contenidos relacionados tenemos que acceder a los elementos related de la página actual `$related := .Site.RegularPages.Related .` e imprimir lo que nos interese, en nuestro caso el título y la url.

 > *¿Pero cómo sabe Hugo cuales son los elementos relacionados?* 😐

Muy buena pregunta, y la respuesta la verdad es que me ha volado la cabeza... Seguramente pensaseis, como yo, que lo podemos introducir en los metadatos del post al crear el contenido, pero no! Hugo lo detecta automágicamente, y te digo más, puedes [ajustar el algoritmo](https://gohugo.io/content-management/related/#configure-related-content) a tu gusto! Brutal!

## Miscelanea 🧪

Como miscelanea ha habido un par de cosas que creo que merece la pena comentar.

### La vulnerabilidad del target blank

Un detalle interesante sobre los links del header, a primera vista inofensivos, pueden ser explotados por una vulnerabilidad. Todo esto se debe al atributo `target="_blank"`.

Así para resumirlo mucho, si abrimos un link cualquiera que tenga `target="_blank"` la web de destino tiene disponible la referencia del origen a través de javascript. Si la web destino fuese maliciosa, podría ejecutar código para, por ejemplo, cambiar la web de origen sin que nos diesemos cuenta:

```
opener.location = 'kinda.facebok.com'; // phishing rico rico
```

Todo esto se puede solucionar muy facilmente añadiendo el atributo `rel="noopener noreferrer"` al anchor, de esta manera no pasaremos ninguna referencia a la pestaña de destino. De nada!

### BEM

Otra de las cosas que nunca he tenido la oportunidad de practicar, la convención de nombres *[Block Element Modifier](http://getbem.com/)*, ya habéis podido ver en algunos ejemplos de código más arriba que las clases se llaman `.aside__wrapper` y cosas así.

Pues por lo visto esto es algo que les encanta a la gente de frontend, cosa que no entiendo, me parece una nomenclatura bastante verbosa y simplemente **fea de ver**, por no hablar de que ya van 2 veces que hago un push con los identificadores de elemento y modificador intercambiados (la dislexia...), pero lo que si me gusta son las convenciones, y como esto aspira a ser un proyecto que use más gente y resulta estar absurdamente extendido pues me he tenido que subir al carro.

## Siguientes pasos 👣

Estoy bastatante contento con la vida que le han dado estos cambios a la web, dicho esto, este viaje no ha hecho más que empezar.

Para la próxima iteración espero poder tener las taxonomías de tags ya hechas con sus listas y todo, Google Analytics y Search Console ya en funcionamiento para ver algunas estadísticas y quizás el highlight de código, así que *stay tuned!* 😎

## Wayback machine ⏰

Ver la [versión original de este post](https://web.archive.org/web/20191019121743/https://asurbernardo.com/posts/la-primera-iteracion-amp-estilos-y-miscelanea/ "Versión original del post").

Ver la [versión original de la homepage](https://web.archive.org/web/20191019121816/https://asurbernardo.com/ "Versión original de la homepage").
