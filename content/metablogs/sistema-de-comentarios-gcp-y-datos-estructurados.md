+++
draft = false
date = "2019-11-22T10:17:32+02:00"
publishdate = "2019-11-22T10:17:32+02:00"

title = "Metablog #5 - Sistema de comentarios y datos estructurados"

description = "Despliego un sistema de comentarios con remark en GCP Compute engine y añado datos estructurados a mi blog de tipo artículo, carrusel, migas de pan y website"

summary = "He estado cacharreando con Google Cloud Platform y he desplegado un **sistema de comentarios** dockerizado en Compute engine utilizando la capa gratuita, también le doy otro empujon al SEO técnico añadiendo **datos estructurados** en toda la web del tipo website, carousel, migas de pan y blog posting."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'comentarios', 'remark', 'GPC', 'Compute engine', 'SEO', 'datos estructurados', 'breadcrumbs', 'website', 'carousel']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = "/"

[image]
    src = "/images/sistema-de-comentarios-gcp-y-datos-estructurados.jpg"
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

# Sistema de comentarios y datos estructurados

{{% under-title %}}

Vuelvo una semana más al formato metablog, creo que hay novedades que merece la pena comentar!

He estado cacharreando con Google Cloud Platform y he desplegado un **sistema de comentarios** dockerizado en Compute engine utilizando la capa gratuita. 

También he avanzado otro poco con el SEO técnico añadiendo **datos estructurados** en toda la web del tipo website, carousel, migas de pan y blog posting.

{{% toc %}}

## Sistema de comentarios 🦜

Estaba claro que este blog necesita un buen sistema de comentarios para que la gente se queje de mi contenido.

Por supuesto tampoco voy a ser menos que el resto de la blogosfera así que me he puesto con ello.

Pero no he usado Disqus, no, no, no, esa sería la opción fácil que me permitiría conservar la cordura. He decidido no utilizar un Saas si no que me lo he montado todo yo solito en GCP.

Me he decantado por Compute engine por pura familiaridad, es un servidor virtualizado (VPS) y con estos ya me he peleado, si eso a futuro probaré cosas más chulas, si te estoy mirando a tí, Cloud Run.

Al principio pensé en empezar a usar [Commento](https://commento.io/), que no solo es un servicio, si no que es open source así que le di una oportunidad... mala idea!

Parece que la última versión tiene un bug, que si lo configuras para usar `https` la página padre si que se pide por el protocolo correcto pero sus subrequest son todos `http`, generando un montón de errores por *mixed content* en el navegador.

Tras pegarme cabezazos contra el muro de commento más horas de las que me gustaría admitir decidí pasarme a [Remark](https://remark42.com/), otro sistema de comentarios, también escrito en Go y con unas prioridades parecidas, como la velocidad, la privacidad y por supuesto también de código abierto.

Acabé montando un fichero `docker-compose` siguiendo la guía de dockerización oficial y en nada lo tenía funcionando. Mucha mejor experiencia que con el otro sistema. El fichero quedó así:

{{< highlight yaml "linenos=table" >}}

version: '2'

services:
    remark:
        build: .
        image: umputun/remark42:latest
        container_name: "remark42"
        hostname: "remark42"
        restart: always
        logging:
          driver: json-file
          options:
              max-size: "10m"
              max-file: "5"
        ports:
          - "80:8080"
        environment:
            - REMARK_URL=https://remark.asur.dev
            - SECRET=???
            - AUTH_ANON=true
            - EMOJI=true
            - SITE=asur.dev
            - STORE_BOLT_PATH=/srv/var/db
            - BACKUP_PATH=/srv/var/backup
            - DEBUG=true
            - AUTH_GITHUB_CID=71e8bdd80db99d4ee55e
            - AUTH_GITHUB_CSEC=???
            - ADMIN_PASSWD=???
        volumes:
            - ./var:/srv/var

{{< / highlight >}}

Tiene muchísima configuración como notificaciones en Telegram y autenticación Oauth con muchos proveedores, pero de momento lo he dejado como login anónimo y con Github, creo que es suficiente de momento.

La segunda odisea empezó al querer añadirlo en los posts, porque claro, el código HTML no soporta AMP, así que toca meterlo embebido como un iframe.

AMP es un poco especial en este sentido, no debes añadir un iframe desde tu propio dominio, si lo haces da todo tipo de problemas, así que lo que hice fué crear un subdominio con una redirección, un workaround bastante útil porque AMP no comprueba los redirects.

El flujo de requests quedaría:

```
https://asur.dev -> https://comments.asur.dev -> https://asur.dev/comments.html -> https://remark.asur.dev
```

Con esto ya validaría el dominio del iframe, pero también hay que permitir **explicitamente** las cosas que ese iframe puede y no puede hacer.

En mi caso puede generar pop-ups para el tema de la autenticación Oauth, tiene formularios, scripts, etc.

{{< highlight go-html-template "linenos=table" >}}

<amp-iframe width="200" height="100" resizable
    sandbox="allow-scripts allow-same-origin allow-forms allow-popups"
    layout="responsive"
    frameborder="0"
    src="https://comments.asur.dev">
<div overflow tabindex="0"></div>
</amp-iframe>

{{< / highlight >}}

Como nota extra, el atributo `resizable` y el elemento overflow dentro del iframe es para que AMP deje que el iframe se ajuste en altura dependiendo del contenido *at runtime*. Luego solo hay que añadir un observer en el javascript del contenido embebido:

{{< highlight javascript "linenos=table" >}}

window.parent.postMessage({
    sentinel: 'amp',
    type: 'embed-size',
    height: document.body.scrollHeight
  }, '*');

{{< / highlight >}}

Y eso es todo, no te lo pienses y cuando acabes de leer deja un comentario para probarlo! 😄

## Datos estructurados 🧱

Los datos estructurados son una de las cosas más comunes que se suelen implementar para mejorar el SEO desde la parte técnica.

No dejan de ser una serie de *json scripts* que se añaden a tu página para facilitar el crawleo al bot de Google. Puedes ver los ejemplos más comunes en [jsonld.com](https://jsonld.com).

La gracia de esto es que **Google y otros motores de búsqueda favorecen a las páginas que los tienen**, no solo en posicionamiento directo, si no que tienes la posibilidad de que tu resultado se muestre como enriquecido, algo que aumenta significativamente el CTR.

Para validarlos suelo utilizar el [*structured data testing tool*](https://search.google.com/structured-data/testing-tool?hl=es#url=https%3A%2F%2Fasur.dev) de Google aunque también hay [extensiones para Chrome](https://chrome.google.com/webstore/detail/structured-data-testing-t/kfdjeigpgagildmolfanniafmplnplpl).

Hay algún dato estructurado más que podría añadir pero creo que en esfuerzo/beneficio estos son los mejores:

### Dato estructurado de Website

Los datos estructurados de Website se añaden en la **solo** en homepage de tu web. Veo que es un error muy habitual el añadir este rich snippet en otros sitios de la web.

Una de las features más chulas de este snippet es que puedes añadir una search action y que en el SERP aparezca directamente un input para buscar en tu web.

Lametablemente este site es estático e implementar una búsqueda requiere algún workaround que aún estoy preparando, así que de momento me quedo sin search action. 😔

El resultado se podría ver algo así:

{{< amp-image
    class="post__image"
    alt="Datos estructurados de Website en SERP"
    src="/images/datos-estructurados-website-serp.jpg"
    width="945"
    height="624"
    layout="responsive" >}}

El json queda así:

{{< highlight javascript "linenos=table" >}}

{
    "@context": "http://schema.org",
    "@type": "WebSite",
    "name": "Bienvenid@ a mi blog | By Asur 🧐",
    "alternateName": "Blog de Asur",
    "url": "https://asur.dev/"
}

{{< / highlight >}}

### Dato estructurado de Breadcrumbs

Los datos estructurados de Breadcrumb, también llamados de navegación son unas migas de pan que ordenan jerárquicamente el path de una página.

En Google Search Console ya aparece como que se han validado, pero aún no los muestra en los resultados de búsqueda, toca esperar...

El json queda así:

{{< highlight javascript "linenos=table" >}}

{
    "@context": "http://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position":  1 ,
            "item": {
                "@id": "https://asur.dev/",
                "name": "Inicio"
            }
        },
        {
            "@type": "ListItem",
            "position":  2 ,
            "item": {
                "@id": "https://asur.dev/metablogs/",
                "name": "Metablogs"
            }
        },
        {
            "@type": "ListItem",
            "position":  3 ,
            "item": {
                "@id": "https://asur.dev/metablogs/sistema-de-comentarios-gcp-y-datos-estructurados/",
                "name": "Sistema de comentarios gcp y datos estructurados"
            }
        }
    ]
}

{{< / highlight >}}

### Dato estructurado de BlogPost

Los datos estructurados de BlogPost son un subtipo de Artículo que, como su nombre indica se usan en un blog y tiene algunos datos extra como categoría padre, keywords, etc.

Este tipo está aplicado en esta misma página, pero parece que aún no ha sido reconocido por Google o al menos no lo he encontrado.

Aún así se puede comprabar si está validado e incluso hacer una preview, solo tienes que acceder al *structured data test tool* que mencioné arriba en un navegador **Chrome**, si lo haces te aparecerá un botón que pone *OBTENER VISTA PREVIA*.

{{< amp-image
    class="post__image"
    alt="Vista previa de artículo en Structured Data Testing Tool"
    src="/images/obtener-vista-previa-datos-estructurados-google.jpg"
    width="1183"
    height="500"
    layout="responsive" >}}

El json para el resultado anterior sería como este:

{{< highlight javascript "linenos=table" >}}

{
    "@context":"http://schema.org",
    "@type": "BlogPosting",
    "image": "https://asur.dev/images/sistema-de-comentarios-gcp-y-datos-estructurados.jpg",
    "url": "https://asur.dev/metablogs/sistema-de-comentarios-gcp-y-datos-estructurados/",
    "headline": "Metablog #5 - Sistema de comentarios y datos estructurados",
    "alternativeHeadline": "Metablog #5 - Sistema de comentarios y datos estructurados",
    "dateCreated": "2019-11-24T11:27:32",
    "datePublished": "2019-11-24T11:27:32",
    "dateModified": "2019-11-24T11:27:32",
    "inLanguage": "es",
    "isFamilyFriendly": "true",
    "copyrightYear": "2019",
    "copyrightHolder": "Asur",
    "accountablePerson": {
        "@type": "Person",
        "name": "Asur",
        "url": "https://asur.dev/"
    },
    "author": {
        "@type": "Person",
        "name": "Asur",
        "url": "https://asur.dev/"
    },
    "creator": {
        "@type": "Person",
        "name": "Asur",
        "url": "https://asur.dev/"
    },
    "publisher": {
        "@type": "Organization",
        "name": "Asur Bernardo",
        "url": "https://asur.dev/",
        "logo": {
            "@type": "ImageObject",
            "url": "https://asur.dev/logo-amp-article.png",
            "width":"600",
            "height":"60"
        }
    },
    "mainEntityOfPage": "https://asur.dev/metablogs/sistema-de-comentarios-gcp-y-datos-estructurados/",
    "keywords": "["blog","desarrollo","comentarios","remark","GPC","Compute engine","SEO",
        "datos estructurados","breadcrumbs","website","carousel"]",
    "genre": "["Evolutivo"]",
    "articleSection": "Los metablogs | By Asur 🧐"
}

{{< / highlight >}}

No sé si habéis leido el [metablog #4](https://asur.dev/metablogs/nuevo-dominio-legibilidad-integracion-amp-scripts/), de ser así os acordaréis que mencioné que el logo de `<asurbernardo/>` era para linkear a la home y para algo más que diría más adelante.

Pues aquí está, resulta que para mostrar un artículo necesitas un logo de organización con [unas medidas bastante concretas](https://developers.google.com/search/docs/data-types/article#logo-guidelines) y es **obligatorio**, así que no me quedaba otra para probar este tipo de dato estructurado que tener uno.

### Dato estructurado de Carousel

Los datos estructurados de Carousel se utilizan para en páginas de listado de artículos, productos, cursos...

Este es uno de mis favoritos, porque si tu página es reconocida como carrusel en el SERP aparece un slider entero dedicado a tu site, eso es un WIN como una casa!

Es uno de los más efectivos pero también es de los más difíciles de ser reconocidos, aun así el resultado es espectacular:

{{< amp-image
    class="post__image"
    alt="Datos estructurados de Carousel en SERP"
    src="/images/datos-estructurados-carousel-serp.jpg"
    width="1167"
    height="539"
    layout="responsive" >}}

El json que necesitariamos, teniendo en cuenta que las urls de los links tengas datos estructurados de tipo artículo sería así:

{{< highlight javascript "linenos=table" >}}

{
    "@context": "https://schema.org",
    "@type": "ItemList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position": "1",
            "url": "https://asur.dev/metablogs/sistema-de-comentarios-gcp-y-datos-estructurados/",
            "name": "Metablog #5 - Sistema de comentarios y datos estructurados"
        },
        {
            "@type": "ListItem",
            "position": "2",
            "url": "https://asur.dev/metablogs/nuevo-dominio-legibilidad-integracion-amp-scripts/",
            "name": "Metablog #4 - Nuevo dominio, nuevo layout y más AMP!"
        },
        {
            "@type": "ListItem",
            "position": "3",
            "url": "https://asur.dev/metablogs/mejorando-workflow-docker-makefile-github-actions/",
            "name": "Metablog #3 - Workflow con docker, makefile y Github actions"
        },
        {
            "@type": "ListItem",
            "position": "4",
            "url": "https://asur.dev/metablogs/taxonomia-de-tags-highlight-codigo-analitica/",
            "name": "Metablog #2 - Tags, highlighting de código y analítica"
        },
        {
            "@type": "ListItem",
            "position": "5",
            "url": "https://asur.dev/metablogs/la-primera-iteracion-amp-estilos-y-miscelanea/",
            "name": "Metablog #1 - AMP, estilos y otras miscelaneas"
        },
        {
            "@type": "ListItem",
            "position": "6",
            "url": "https://asur.dev/metablogs/el-primer-post-en-mi-nuevo-blog/",
            "name": "Metablog #0 - El primer post en mi nuevo blog!"
        }
    ]
}

{{< / highlight >}}

## Siguientes pasos 👣

Tengo un proyecto en proceso muy muy chulo del que voy a hacer un post en detalle, quizás no un tutorial pero algo más documental describiendo lo que he hecho, creo que los voy a llamar *megaposts*. Stay tuned! 😎

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").