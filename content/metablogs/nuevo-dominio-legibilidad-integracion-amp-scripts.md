+++
draft = true
date = "2019-11-09T11:27:32+02:00"
publishdate = "2019-11-09T11:27:32+02:00"

title = "Metablog #4 - Nuevo dominio, nuevo layout y más AMP!"

description = "Sigo desarrollando el tema amperage, añadiendo botones para compartir en redes sociales, mejorando la integración del tema con AMP y haciendo más sencillo el layout para facilitar la lectura y mejorar la UX."

summary = "Sigo desarrollando el tema amperage, añadiendo datos estructurados de artículo para los posts y botones para compartir en redes sociales, mejorando la integración del tema con AMP y haciendo más sencillo el layout para facilitar la lectura y mejorar la UX."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'amp', 'compartir', 'redes sociales', 'datos estructurados', 'artículo', 'UX', 'legibilidad']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = ""

[image]
    src = "https://asur.dev/images/nuevo-dominio-legibilidad-integracion-amp-scripts-share.png"
    title = ""
    author = ""
    link = ""
    license = ""
    licenseLink = ""

[ogp]
    title = ""
    url = ""
    description = ""
    image = ""
    site = ""

[twitter]
    title = ""
    url = ""
    description = ""
    image = ""
    site = ""

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Nuevo dominio, nuevo layout y más AMP!

{{% under-title %}}

Un nuevo lavado de cara del blog, no solo visual, sino que **he cambiado el dominio!** Atrás quedan los días de `asurbernardo.com`, un dominio largo y dificil de recordar, el nuevo dominio es **asur.dev**, algo mejor eh? Ah, y también he mejorado algunas cosas de AMP, pero que bonito mi nuevo dominio...

{{% toc %}}

## Nuevo dominio! 🌍

Este proceso ha sido un poco tedioso, con varios pasos para evitar que se desindexase alguna página...

 - DNS

 - Redirects

 - GH Pages

 - Analítica

## Mejora del layout 🧩

Con el objetivo de mejorar la lectura en todas las plataformas y aplicar un poco el paradigma de *mobile first* he simplificado la distribución.

El primer cambio y el más evidente es la eliminación de la columna sticky derecha en desktop (RIP `display:sticky` 😔). Esto hace que en mobile, que es un \~25% del tráfico, no se mueva la tabla de contenidos al final de la página, donde pierde su función. La tabla de contenidos se ha movido dentro del propio contenido, debajo de la introducción y los posts relacionados al final, por si se quiere seguir leyendo, mejor UX en general!

El segundo es mover el autor y las tags debajo del título.

### Nuevo logo!

El último cambio es la creación de un logo. No tengo ni idea de diseño entonces lo único que he hecho es abrir InkScape y hacer pruebas con fuentes y colores.

## Mejorar integración de AMP con Hugo ⚡

Ahora llega la parte de AMP, con un par de cambios en Amperage para mejorar aun más la integración.

### Scripts configurables

Los scripts ahora son configurables por cada post, así solo se añaden los necesarios para cada caso, si quieres poner un video en el post pues añades el script pertinente, pero no a toda la web. ¿Parece lógico no? Pues lleva más trabajo de lo que parece!

Lo he hecho de la siguiente forma:

Para empezar he tenido que crear un fichero json con todos los scripts disponibles de AMP, no os creáis que lo he hecho yo desde cero, lo he sacado de el [boilerplate gohugo-amp](https://github.com/wildhaber/gohugo-amp/blob/develop/data/amp-modules.json) y he actualizado un par de scripts que faltaban. Es algo así:

{{< highlight json "linenos=table" >}}

{
  "amp-core": "https://cdn.ampproject.org/v0.js",
  "amp-access": "https://cdn.ampproject.org/v0/amp-access-0.1.js",
  "amp-analytics": "https://cdn.ampproject.org/v0/amp-analytics-0.1.js",
  "amp-accordion" : "https://cdn.ampproject.org/v0/amp-accordion-0.1.js",
  "amp-ad" : "https://cdn.ampproject.org/v0/amp-ad-0.1.js",
  "amp-anim" : "https://cdn.ampproject.org/v0/amp-anim-0.1.js",
  "amp-animation" : "https://cdn.ampproject.org/v0/amp-animation-0.1.js",
  "amp-apester-media" : "https://cdn.ampproject.org/v0/amp-apester-media-0.1.js",
  "amp-app-banner" : "https://cdn.ampproject.org/v0/amp-app-banner-0.1.js",
  "amp-audio" : "https://cdn.ampproject.org/v0/amp-audio-0.1.js",
  "amp-bind" : "https://cdn.ampproject.org/v0/amp-bind-0.1.js",
  "amp-brid-player" : "https://cdn.ampproject.org/v0/amp-brid-player-0.1.js",
  "amp-brightcove" : "https://cdn.ampproject.org/v0/amp-brightcove-0.1.js",
  "amp-carousel" : "https://cdn.ampproject.org/v0/amp-carousel-0.1.js",
  [...]
}

{{< / highlight >}}

Esto me permite tener una relación clave-valor más *friendly* de añadir, que una url completa que tendría que andar consultando cada vez.

Para añadir en cada entrada los scripts le he añadido a la metadata del fichero un array de módulos:

```
[amp]
    elements = ['amp-video', 'amp-anim']
```

También he aprovechado y he hecho lo mismo para la configuración global de la web, de esta manera se pueden añadir scripts globales también desde la configuración sin tocar código. ¿Ya véis por donde van los tiros? Ahora al transpilar cada post puedo mirar los scripts especificados en estas dos configuraciones, matchearlos con el fichero json e insertarlos en el HTML!!

{{< highlight go-html-template "linenos=table" >}}

<!-- Añadir siempre el script raíz de AMP -->
{{- $ampCorePath := index (index $.Site.Data "amp-modules") "amp-core" -}}
<script async src="{{ $ampCorePath }}"></script>

<!-- Incluir los scripts globales de la web -->
{{- range $.Site.Params.ampElements -}}
    {{- if (index (index $.Site.Data "amp-modules") .) -}}
        <script async custom-element="{{ . }}" src="{{ (index (index $.Site.Data "amp-modules") .) }}"></script>
    {{- end }}
{{- end }}

<!-- Incluir los scripts del post en concreto -->
{{ with .Params.amp.elements }}
    {{ range . }}
        {{ if in $.Site.Params.ampElements . }}
        {{ else }}
            {{- if (index (index $.Site.Data "amp-modules") .) -}}
                <script async custom-element="{{ . }}" src="{{ (index (index $.Site.Data "amp-modules") .) }}"></script>
            {{- end }}
        {{ end }}
    {{ end }}
{{ end }}

{{< / highlight >}}

### Botones de compartir en AMP

Al poner los metadatos del post debajo del título quedaba algo vacío, y como AMP hace muy sencillo el añadir botones para compartir, lo he hecho:

{{< highlight go-html-template "linenos=table" >}}

<div class="under-title__right social-share">
    <amp-social-share class="social-share__button"
        aria-label="Compartir contenido" type="system" width="50" height="50"></amp-social-share>
    <amp-social-share class="social-share__button"
        aria-label="Compartir en Facebook" type="facebook" width="50" height="50"></amp-social-share>
    <amp-social-share class="social-share__button"
        aria-label="Compartir en Twitter" type="twitter" width="50" height="50"></amp-social-share>
    <amp-social-share class="social-share__button"
        aria-label="Compartir en Linkedin" type="linkedin" width="50" height="50"></amp-social-share>
    <amp-social-share class="social-share__button"
        aria-label="Compartir en pinterest" type="pinterest" width="50" height="50"></amp-social-share>
</div>

{{< / highlight >}}

Junto con unos pequeños estilos, porque los botones por defectos son **feos AF**, aunque con hacerlos un poco más pequeños y redondos la cosa mejora mucho:

{{< highlight scss "linenos=table" >}}

.social-share {
    amp-social-share {
        margin: 0 .5em;
        border-radius: 50%;
        background-size: 60%;
    }
}

{{< / highlight >}}

## Miscelanea 🧪

Un par de cosas extras que comentar.

### Estilos de tablas en markdown

Algunos temas de GoHugo se olvidan de que en markdown se pueden crear tablas y no les aplican ningún estilo, una auténtica lástima porque puede aportar mucho dinamismo al contenido. Por lo pronto he hecho algo muy sencillo pero para salir del paso llega:

```
| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |
```

se ve así:

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |

Los estilos han quedado bastante comedidos, que siempre viene bien para mantenerse por debajo de los 50Kb de máximo (aunque nunca vaya a llegar pero son buenas prácticas):

{{< highlight scss "linenos=table" >}}

table {
    overflow: auto;
    border-collapse: collapse;
    width: 100%;
    td, th {
        border: 1px solid #ddd;
        padding: 8px;
    }
    tr:nth-child(even) {
        background-color: #F1F1F1;
    }
    tr:hover {
        background-color: #ddd;
    }
    th {
        padding: 1em 0.5em;
        background-color: $main-color;
        color: white;
    }
}

{{< / highlight >}}

**TIP:** Si tenéis que escribir muchas tablas en markdown por cualquier razón, os recomiendo [TablesGenerator](https://www.tablesgenerator.com/markdown_tables), puedes elegir la cantidad de filas y columnas y el alineamiento, todo con sus tabulados y espacios bien puestos, súper útil si el TOC no os deja dormir pensando en la distribución de las tablas de markdown como a mí.

### Nuevas imágenes para compartir

Ahora que ya tengo botones de compartir creo que al menos hacer que se vea decente la tarjeta, así que he añadido unas imágenes, de momento son solo imágenes de la tabla de contenidos generadas con [carbon.sh.now](https://carbon.sh.now). Se ven así:

<amp-img class="post__image"
    alt="Inspiración inicial para el estilo del blog"
    src="/images/nuevo-dominio-legibilidad-integracion-amp-scripts-share.png"
    width="1760"
    height="852"
    layout="responsive">
</amp-img>

La verdad es que es difícil elegir una imágen para un post técnico, así que esta es mi manera de salir del paso... No está mal pero es mejorable, así que iteraré sobre esto en el futuro cercano.

## Siguientes pasos 👣

Para la próxima iteración, como comenté en el anterior post, no solo voy a integrar los datos estructurados de artículo, voy a añadir artículo, migas de pan, website y organización. A tope con el SEO técnico! Stay tuned! 😎

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").