+++
draft = true
date = "2019-12-15T10:19:05+02:00"
publishdate = "2019-12-15T10:19:05+02:00"

title = "Metablog #8 - Preparando Amperage para el dominio público"

description = "La publicación de mi tema **Amperage** está cerca. Preparo funcionalidades que la gente probablemente necesite como paginación, poder sobreescribir estilos y más"

summary = "La publicación de mi tema Amperage está cada vez más cerca. Me dedico a preparar funcionalidades que la gente probablemente necesite como mejoras en las **traducciones**, **paginación** de las listas, poder **sobreescribir estilos** y muchas otras."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'amperage', 'publicación', 'tema']

[amp]
    elements = []

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = ""

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Preparando Amperage para el dominio público

{{% under-title %}}

La fecha de publicación de **Amperage** cada vez está más cerca. Ha llegado un punto es el que estoy satisfecho con el proyecto para crear una versión inicial `1.0.0`.

> ¿Pero a qué te refieres con publicar? Ya das la chapa todas las semanas por Twitter... 🤨

Pues resulta que GoHugo tiene una [página con sus temas oficiales](https://themes.gohugo.io/). **Mi objetivo es que Amperage llegue a estar listado en esa página.**

Existe un [procedimiento a seguir](github.com/gohugoio/hugoThemes/blob/master/README.md#adding-a-theme-to-the-list) para conseguirlo, hay que hacer un *Pull Request* al repositorio de esa página, pero antes hay que cumplir una serie de requisitos básicos y por supuesto tener unas features que atraigan a la gente a usar tu tema.

De esto voy a hablar en este metablog, de los toques finales antes de mandar mi solicitud! A por ello!!

{{% toc %}}

## Paginación de listados 📖

De momento la cantidad de posts que tengo en el blog no es descomunal, por lo que puedo ir tirando sin paginación, además mi homepage pesa 6Kb así que tampoco es que se vaya a sobrecargar el DOM.

Pero esto no es escalable y tampoco significa que alguien que vaya a usar el tema no necesite esta funcionalidad, así que toca implementarla.

Este es otro ejemplo de funcionalidad con soporte nativo por parte de Hugo. Lo único que he tenido que hacer es darle unos estilos para que sea consecuente con el resto de la web.

La plantilla de paginación queda así:

{{< highlight go-html-template "linenos=table" >}}

{{ if gt .Paginator.TotalPages 1 }}
  <nav class="pagination">
    {{ if .Paginator.HasPrev }}
      <a href="{{ .Paginator.Prev.URL | absLangURL }}"><< {{ i18n "previous" }} </a>
    {{ else }} <span></span> {{ end }}
    {{ if .Paginator.HasNext }}
      <a href="{{ .Paginator.Next.URL | absLangURL }}"> {{ i18n "next" }} >></a>
    {{ else }} <span></span> {{ end }}
  </nav>
{{ end }}

{{< / highlight >}}

Y con estos estilos básicos quedaría presentable:

{{< highlight scss "linenos=table" >}}

.pagination {
  margin: 2em auto;
  display: flex;
  justify-content: space-between;
  a {
    border-bottom: none;
    &:hover {
      color: $main-color;
    }
  }
}

{{< / highlight >}}

Por supuesto también he añadido las metatags con `rel="next"` y `rel="prev"` de la siguiente manera:

{{< highlight go-html-template "linenos=table" >}}

{{ with .Paginator }}
  {{ if gt .TotalPages 1 }}
    {{ if .HasPrev }}
      <link rel="prev" href="{{ .Prev.URL | absLangURL }}">
    {{ end }}
    {{ if .HasNext }}
      <link rel="next" href="{{ .Next.URL | absLangURL }}">
    {{ end }}
  {{ end }}
{{ end }}

{{< / highlight >}}

Para verlo me temo que vas a tener que esperar al siguiente post porque he puesto la paginación a 10 y es justo la cantidad que llevo! 😁

## Traducción de fechas 📅

Quedaba un poco raro en los posts que la fecha saliese con el formato `5-9-1994`. Además en otros paises como EEUU el mes va delante del día, así que me ha tocado cambiarlo.

He decidido además escribir el mes en letra, en vez de en cifra, creo que queda mejor en general.

Para esto he tenido que hacer un *workaround* algo raro:

{{< highlight go-html-template "linenos=table" >}}

<time datetime="{{ .Page.PublishDate.Format "2006-01-02T15:04:05" | safeHTMLAttr }}">
  {{ $months := index .Site.Data (i18n "months") }}
  {{ $month := index $months (printf "%d" .Page.PublishDate.Month) }}
  {{ i18n "published" (dict
    "Day" .Page.PublishDate.Day
    "Month" $month
    "Year" .Page.PublishDate.Year) }}
</time>

{{< / highlight >}}

La idea es que con esta línea `{{ $months := index .Site.Data (i18n "months") }}` puedo mirar un fichero en la carpeta data del tenga el nombre de `meses` en el idioma correspondiente, por ejemplo si la página está en inglés buscará `months.yml`.

Con esto si creo ese fichero con los meses y como clave su número en el año los puedo imprimir. Así quedaría por ejemplo el `months.yml`:

```
1: "January"
2: "February"
3: "March"
4: "April"
5: "May"
6: "June"
7: "July"
8: "August"
9: "September"
10: "October"
11: "November"
12: "December"
```

## Poder sobreescribir estilos 💅

Pues claro! La gente es poco probable que tenga el mismo gusto que yo, así que he metido la posibilidad de sobreescribir los estilos por default.

Por defecto el CSS minificado solo pesa 5Kb así que deja otros 45Kb extra de margen para que la gente lo deje a su gusto!

Lo único que tienen que hacer es añadirlos en `assets/custom.scss` y ya se transpila, minifica e inserta automáticamente. 👍

Lo he conseguido jugando un poco con el *lookup order* de Hugo:

{{< highlight go-html-template "linenos=table" >}}

<style amp-custom>
  {{ with resources.Get "styles.scss" | resources.ToCSS | resources.Minify }}
    {{ .Content | safeCSS }}
  {{ end }}
  {{ if resources.Get "custom.scss" }}
    {{ with resources.Get "custom.scss" | resources.ToCSS | resources.Minify }}
      {{ .Content | safeCSS }}
    {{ end }}
  {{ end }}
</style>

{{< / highlight >}}


## Soportar menús 🍔

Si has visitado la lista de requisitos que he linkeado arriba, puedes ver que un tema tiene que soportar el [ejemplo básico de site de Hugo](https://github.com/gohugoio/hugoBasicExample). Pues adivina, este ejemplo tiene menús, así que otra cosa más para la lista.

Los menús en Hugo se configuran en el `config.toml` y es algo custom de cada site. Queda así:

{{< highlight toml "linenos=table" >}}

[[menu.main]]
  identifier = "linkedin"
  name = "LinkedIn"
  url = "https://www.linkedin.com/in/asur-bernardo/"
  weight = 10
[[menu.main]]
  identifier = "twitter"
  name = "Twitter"
  url = "https://twitter.com/asurbernardo"
  weight = 10

[...]

{{< / highlight >}}

Esta configuración se bindea a la variable `.Site` en *build time* y podemos acceder a ella para imprimirla:

{{< highlight go-html-template "linenos=table" >}}

<ul class="header__menu__list">
  {{ $internal := in .URL .Site.BaseURL }}
  {{ range .Site.Menus.main }}
    <li>
      <a href="{{ .URL }}"
        {{ if not $internal }} target="_blank" rel="nofollow noopener noreferrer" {{ end }}>
        {{ .Pre }}
        <span>{{ .Name }}</span>
      </a>
    </li>
  {{ end }}
</ul>

{{< / highlight >}}

## Links entre idiomas 🌏

Esto ha sido preferencia personal. Para mejorar el interlinking entre idiomas y que hereden el pagerank de la página padre he decidido añadir en el footer una lista de todas las homepages de los distintos idiomas.

El snippet:

{{< highlight go-html-template "linenos=table" >}}

<div class="footer__languages">
  {{ if .Site.IsMultiLingual }}
    {{ range .Site.Languages }}
      {{ if eq .LanguageName $.Site.Language.LanguageName }}
        <b>{{ .LanguageName }}</b>
      {{ else }}
        <a href="{{ . | absURL }}">{{ .LanguageName }}</a>
      {{ end }}
    {{ end }}
  {{ end }}
</div>

{{< / highlight >}}

También para mejorar un poco el SEO y el reconocimiento multi-idioma he añadido las tags de *hreflang* a la web, pero **solo en las homepages**.

{{< highlight go-html-template "linenos=table" >}}

{{ if and .Site.IsMultiLingual .IsHome }}
  {{- range .Site.Languages -}}
    <link rel="alternate" hreflang="{{.}}" href="{{ . | absURL }}" />
  {{- end -}}
{{ end }}

{{< / highlight >}}

## Navegación instantanea ⚡

Una de las features que no estaba aprovechando de los service workers es el *link prefetch*. Esta feature permite que un link se cargue de manera proactiva (*eager loading*). De esta manera al navegar la página se recupera de cache en vez de hacer una petición, lo que da la impresión de navegación instantanea.

Para que el sw detecte los links tengo que añadir `data-rel="prefetch"`.

## Shortcodes para usabilidad 💻

A la hora de escribir no es muy cómodo tener que utilizar HTML directamente para añadir componentes de AMP así que he creado *shortcodes* para los más comunes.

Los shortcodes son una funcionalidad de Hugo, son plantillas que luego puedes usar al escribir en markdown.

He creado los shortcodes:

 - toc.html
 - under-title.html
 - amp-image
 - amp-gif
 - amp-video
 - amp-iframe.html

Algunos de estos shortcodes los he sacado del tema [gohugo-amp toolbox](https://gohugo-amp.gohugohq.com/) y los he modificado un poco.

## Parcialización del tema 🍱

Cuando te instalas un tema es muy útil que esté parcializado. ¿Por qué? Pues por el [lookup order de Hugo](https://gohugo.io/templates/lookup-order/).

El *lookup order* es una especie de sistema de herencia y puedes usarlo sobreescribir elementos concretos de tu tema.

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

## Próximo destino 🛣️

Pues creo que ha quedado claro lo que me queda por hacer, voy a preparar el *Pull Request* y el resto de requisitos que no he mencionado en este *metablog* para que mi tema sea oficializado! *Stay tuned!* 😎

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").

Ver la [versión original de la homepage](# "Versión original de la homepage").