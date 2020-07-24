+++
draft = false
date = "2019-12-11T10:40:13+02:00"
publishdate = "2019-12-11T10:40:13+02:00"

title = "Metablog #8 - Preparando Amperage para el dominio público (I)"

description = "La publicación de mi tema **Amperage** está cerca. Preparo funcionalidades que la gente probablemente necesite como paginación, poder sobreescribir estilos y más"

summary = "La publicación de mi tema Amperage está cada vez más cerca. Me dedico a preparar funcionalidades que la gente probablemente necesite como mejoras en las **traducciones**, **paginación** de las listas, poder **sobreescribir estilos** y muchas otras."

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

# Preparando Amperage para el dominio público (I)

{{< under-title >}}

La fecha de publicación de **Amperage** cada vez está más cerca. Ha llegado un punto es el que estoy satisfecho con el proyecto para crear una versión inicial `1.0.0`.

> ¿Pero a qué te refieres con publicar? Ya das la chapa todas las semanas por Twitter... 🤨

Pues resulta que GoHugo tiene una [página con sus temas oficiales](https://themes.gohugo.io/). **Mi objetivo es que Amperage llegue a estar listado en esa página.**

Existe un [procedimiento a seguir](https://github.com/gohugoio/hugoThemes/blob/master/README.md#adding-a-theme-to-the-list) para conseguirlo, hay que crear un *Issue* en el repositorio de esa página, pero antes hay que cumplir una serie de requisitos básicos y por supuesto tener unas features que atraigan a la gente a usar tu tema.

De esto voy a hablar en este metablog, de los toques finales antes de mandar mi solicitud! A por ello!!

{{% toc %}}

## Paginación de listados 📖

De momento la cantidad de posts que tengo en el blog no es descomunal, por lo que puedo ir tirando sin paginación, además mi homepage pesa 6Kb así que tampoco es que se vaya a sobrecargar el DOM.

Aún así carecer de paginación no es escalable y tampoco significa que alguien que vaya a usar el tema no necesite esta funcionalidad, así que toca implementarla.

Este es otro ejemplo de funcionalidad con soporte nativo por parte de Hugo. Lo único que he tenido que hacer es una plantilla de paginación simple (*anterior/siguiente*) y darle unos estilos para que sea consecuente con el resto de la web.

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

Por supuesto para que los robots detecten esta paginación también he añadido las metatags con `rel="next"` y `rel="prev"` en el head de la siguiente manera:

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

Para verlo me temo que vas a tener que esperar al siguiente post porque he puesto la paginación a 10 y es justo la cantidad que llevo, así que todavía no se ve nada! 😁

## Traducción de fechas 📅

Quedaba un poco raro en los posts que la fecha saliese con el formato numérico (`05-09-1994`). Además en otros paises como EEUU el mes va delante del día, así que me ha tocado echar un ojo a esto también.

Al final he decidido escribir el mes en letra, en vez de en cifra, creo que queda mejor en general. Para esto he tenido que hacer un *workaround* algo raro:

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

Ahora si creo ese fichero con los meses y como clave su número en el año los puedo imprimir. Así quedaría por ejemplo el `months.yml`:

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

Pues claro! La gente es poco probable que tenga el mismo gusto que yo, así que he implementado la posibilidad de sobreescribir los estilos por defecto.

El CSS original minificado solo pesa 5Kb así que deja otros 45Kb extra de margen para que la gente lo deje a su gusto!

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

Si has visitado la lista de requisitos que he linkeado arriba, puedes ver que una de las condiciones es soportar el [ejemplo básico de site de Hugo](https://github.com/gohugoio/hugoBasicExample). Pues adivina, este ejemplo tiene menús, así que otra cosa más para la lista.

Los menús en Hugo se configuran en el `config.toml` y es algo *custom* de cada site. Queda así:

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
  {{ range .Site.Menus.main }}
    {{ $url := .URL | absURL }}
    {{ $isInternal := hasPrefix $url $.Site.BaseURL }}
    <li>
      <a href="{{ $url }}"
        {{ if not $isInternal }} target="_blank" rel="nofollow noopener noreferrer"
        {{ else }} data-rel="prefetch" {{ end }}>
        {{ .Pre }}<span>{{ .Name }}</span>
      </a>
    </li>
  {{ end }}
</ul>

{{< / highlight >}}

## Links entre idiomas 🌏

Esto ha sido preferencia personal. Para mejorar el interlinking entre idiomas y que hereden el *pagerank* de la página padre he decidido añadir en el footer una lista de todas las homepages en los distintos idiomas.

El snippet:

{{< highlight go-html-template "linenos=table" >}}

<div class="footer__languages">
  {{ if .Site.IsMultiLingual }}
    {{ range .Site.Languages }}
      {{ if eq .LanguageName $.Site.Language.LanguageName }}
        <strong>{{ .LanguageName }}</strong>
      {{ else }}
        <a href="{{ . | absURL }}">{{ .LanguageName }}</a>
      {{ end }}
    {{ end }}
  {{ end }}
</div>

{{< / highlight >}}

También para mejorar el reconocimiento multi-idioma por los bots he añadido las tags de *hreflang* a la web, pero **solo en las homepages**.

{{< highlight go-html-template "linenos=table" >}}

{{ if and .Site.IsMultiLingual .IsHome }}
  {{- range .Site.Languages -}}
    <link rel="alternate" hreflang="{{.}}" href="{{ . | absURL }}" />
  {{- end -}}
{{ end }}

{{< / highlight >}}

## Próximo destino 🛣️

Voy a hacer una segunda parte para este post, parece que tenía más cosas que preparar de las que esperaba. Ya no queda nada! *Stay tuned!* 😎

[Seguir leyendo la segunda parte de este post!]({{< ref "/metablogs/preparacion-tema-gohugo-amperage-dominio-publico-ii.md" >}})