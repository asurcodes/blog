+++
draft = false
date = "2019-11-10T11:39:32+02:00"
publishdate = "2019-11-10T11:39:32+02:00"

title = "Metablog #4 - Nuevo dominio, nuevo layout y más AMP!"

description = "Cambio de dominio, añado botones para compartir en redes sociales, mejoro la integración del tema con AMP y simplifico el layout para facilitar la lectura"

summary = "Cambio el **dominio** del blog, sigo desarrollando el tema **Amperage**, añadiendo botones para compartir en redes sociales, mejorando la integración del tema con **AMP** y haciendo más sencillo el **layout** para mejorar la legibilidad y la UX."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'amp', 'compartir', 'redes sociales', 'dominio', 'tablas', 'UX', 'legibilidad']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = "/"

[image]
    src = "/images/nuevo-dominio-legibilidad-integracion-amp-scripts.jpg"
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

# Nuevo dominio, nuevo layout y más AMP!

{{% under-title %}}

Un nuevo lavado de cara del blog, no solo visual, sino que **he cambiado el dominio!** Atrás quedan los días de **asurbernardo.com**, un dominio largo y dificil de recordar, el nuevo dominio es **asur.dev**, algo mejor eh? Ah, y también he mejorado algunas cosas de **AMP** y alguna miscelanea, pero que bonito mi nuevo dominio...

{{% toc %}}

## Nuevo dominio! 🌍

Este proceso ha sido un poco tedioso, he tenido que ser cuidadoso y seguir varios pasos en un orden estricto para evitar que se desindexasen páginas!

 > Tampoco es que haya mucho que desindexar! 😬

Bueno, pero nunca viene mal investigar el proceso y las mejores prácticas por si este blog llegase a tener millones de usuarios algún día y tengo que volver hacerlo, no?!

La secuencia que he seguido es la siguiente:

**1.- DNS**

Lo primero es lo primero, hay que configurar el DNS del nuevo dominio para apuntar a los servidores de Github, de esta manera cuando ejecutemos los siguientes pasos el cambio va a tener *zero downtime*. Los registros son estos:

| Type     | Name          | Content         | TTL     |
|:--------:|:-------------:|:---------------:|:-------:|
| A        | asur.dev      | 185.199.108.153 | Auto    |
| A        | asur.dev      | 185.199.109.153 | Auto    |
| A        | asur.dev      | 185.199.110.153 | Auto    |
| A        | asur.dev      | 185.199.111.153 | Auto    |

Yo como DNS utilizo Cloudflare, pero la configuración es la misma para cualquier provider, lo único que puede cambiar es la GUI en la que introduces los datos.

**OJO:** Los cambios en los DNS es posible que tarden en propagarse, dale un momento antes de pegarte cabezazos contra el teclado. 😉

**2.- Github Pages**

Una vez el dominio es funcional hay que cambiar la configuración de Github pages para que apunte a la nueva dirección. Esto se podría hacer en la pestaña de ajustes de tu repositorio, pero esto lo único que hace es crear un fichero llamado `CNAME` en la raíz de tu proyecto que contiene el dominio personalizado:

```
asur.dev
```

Pues para eso creo yo el mío en el directorio `static`, lo pusheo y así de paso se despliega automáticamente con mi pipeline de Github Actions y puedo tomar un *code oriented approach* que mola más. 😎

**3.- Redirect**

Para este paso también he usado Cloudflare, en concreto sus *Page Rules*. Al estar migrando un dominio completo se puede utilizar un redirect con *wildcards* como este:

| Type     | From                 | To                           |
|:--------:|:--------------------:|:----------------------------:|
| 301      | asurbernardo.com/\*  | https\://asur.dev/$1         |

El símbolo `$1` simboliza la selección del wildcard, así que concatenará el slug en la url origen en la de destino. Un redirect para dominarlos a todos.

**4.- Google Search Console**

Como paso extra y para mejorar la indexación de la nueva dirección de la web se puede notificar a Google a través de Search Console del cambio en una **propiedad de dominio**. Para hacerlo hay que ir a `Configuración > Cambio de dirección`. Se comprobará que tu nuevo dominio esté operativo y registrado como propiedad y que existe una redirección de tipo 301 ya configurada. Listo, el proceso lleva un tiempo (como todo en Search Console) pero al menos ya tengo confirmación:

{{< amp-image
    class="post__image"
    alt="Confirmación de la migración del dominio en Google Search Console"
    src="/images/mensaje-confirmación-cambio-dominio-search-console.jpg"
    width="916"
    height="305"
    layout="responsive" >}}

## Mejora del layout 🧩

Con el objetivo de mejorar la lectura en todas las plataformas y aplicar un poco el paradigma de *mobile first* he simplificado la distribución.

El primer cambio y el más evidente es la eliminación de la columna sticky derecha en desktop (RIP `display:sticky` 😔). Esto hace que en mobile, que es un \~25% del tráfico, no se mueva la tabla de contenidos al final de la página, donde pierde su función. La tabla de contenidos se ha movido dentro del propio contenido, debajo de la introducción y los posts relacionados al final, por si se quiere seguir leyendo, mejor UX en general en mi opinión!

El segundo es mover el autor y las tags debajo del título. Para conseguir meter estos datos y tabla de contenidos dentro del cuerpo del artículo hay que hacer un workaround en Hugo, ya que no es HTML, es markdown, por lo que hay que crear un shortcode como `{{%/* toc */%}}` en tu carpeta `layouts > shortcodes > toc.html` y usarlo donde lo veas preciso dentro del post. Esto conyeva que hay que meter estos shortcodes manualmente cuando se redacta el post pero también puedes elegir si incluirlos o no, lo que da flexibilidad.

### Nuevo logo

El último cambio es la creación de un logo. No tengo ni idea de diseño entonces lo único que he hecho es abrir [InkScape](https://inkscape.org/es/) y hacer pruebas con fuentes, finalmente me he decantado por `<asurbernardo/>` con la fuente [Fira Code](https://github.com/tonsky/FiraCode) que permite ligaduras y creo que le da algo más de personalidad.

Lamentablemente se ha quedado ya anticuado tras el cambio de dominio pero aún cumple su función, que es tener un link a la homepage y algo extra de lo que hablaré en futuros metablogs.

Lo he creado en formato **svg** por tres razones: Escala infinitamente al ser vectorial, es super ligero (2Kb aprox.) y en AMP no tienes el flicker del *lazy loading* de una imagen normal al ir directamente incrustado en el DOM.

Para que cualquier usuario del tema pueda introducir su propio logo se incluye a través de un partial en la ruta `layouts > partials > logo.html` que contenga el `<svg></svg>` directamente:

{{< highlight go-html-template "linenos=table" >}}

<div class="header__logo">
  <a href="/">
    {{- partial "logo.html" -}}
  </a>
</div>

{{< / highlight >}}

**TIP:** En InkScape cuando creas un svg para una web hay que tener cuidado porque por defecto se crean como un texto con estilos y fuentes aplicadas. Esto no es un problema si esa fuente ya está descargada, pero si usas una fuente que está exclusivamente en el logo no funciona y merece más la pena convertir el texto a vectores aunque pese un poco más, lo compensas al no tener que descargar la fuente.

## Mejorar integración de AMP con Hugo ⚡

Ahora llega la parte de AMP, con un par de cambios en Amperage para mejorar aún más la integración.

### Scripts configurables

Los scripts ahora son configurables por cada post, así solo se añaden los necesarios para cada caso, si quieres poner un video en el post pues añades el script pertinente, pero no a toda la web. ¿Parece lógico no? Pues lleva más trabajo de lo que parece! Lo he hecho de la siguiente forma:

Para empezar he tenido que crear un fichero json con todos los scripts disponibles de AMP, no os creáis que lo he hecho yo desde cero, lo he sacado de el [boilerplate gohugo-amp](https://github.com/wildhaber/gohugo-amp/blob/develop/data/amp-modules.json) y he actualizado un par de scripts que faltaban.

{{< highlight json "linenos=table" >}}

{
  "amp-core": "https://cdn.ampproject.org/v0.js",
  "amp-access": "https://cdn.ampproject.org/v0/amp-access-0.1.js",
  "amp-analytics": "https://cdn.ampproject.org/v0/amp-analytics-0.1.js",
  "amp-accordion" : "https://cdn.ampproject.org/v0/amp-accordion-0.1.js",
  "amp-ad" : "https://cdn.ampproject.org/v0/amp-ad-0.1.js",
  "amp-anim" : "https://cdn.ampproject.org/v0/amp-anim-0.1.js",
  [...]
}

{{< / highlight >}}

Esto me permite tener una relación clave-valor más *friendly* de escribir y recordar que una url completa, que de otra manera tendría que andar consultando todo el rato.

Para añadir en cada entrada los scripts le he añadido a la metadata del fichero un array de módulos:

```
[amp]
    elements = ['amp-video', 'amp-anim']
```

También he aprovechado y he hecho lo mismo para la configuración global de la web, de esta manera se pueden añadir scripts globales también sin tocar código. ¿Ya véis por donde van los tiros? 

Ahora al transpilar cada post puedo mirar los scripts especificados en estas dos configuraciones, matchearlos con el fichero json e insertarlos en el HTML!!

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
|:---------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |
```

se ve así:

| Tables   |      Are      |  Cool |
|:---------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |

Los estilos han quedado bastante comedidos, que siempre viene bien para mantenerse por debajo de los 50Kb de máximo permitido por AMP (aunque nunca vaya a llegar pero bueno...):

{{< highlight scss "linenos=table" >}}

table {
    display: block;
    overflow-x: auto;
    border-collapse: collapse;
    td, th {
        border: 1px solid #ddd;
    }
    td {
        padding: .5em 1em;
    }
    th {
        padding: 1em 2em;
        background-color: $main-color;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #F1F1F1;
    }
    tr:hover {
        background-color: #ddd;
    }
}

{{< / highlight >}}

**TIP:** Si tenéis que escribir muchas tablas en markdown por cualquier razón, os recomiendo [TablesGenerator](https://www.tablesgenerator.com/markdown_tables), puedes elegir la cantidad de filas y columnas y el alineamiento, todo con sus tabulados y espacios bien puestos, súper útil si el TOC no os deja dormir pensando en la distribución de las tablas como a mí.

### Nuevas imágenes para compartir

Ahora que ya tengo botones de compartir creo que al menos hay que hacer que se vea decente la tarjeta, así que he añadido unas imágenes, de momento son solo representaciones de la tabla de contenidos generadas con [carbon.sh.now](https://carbon.sh.now).

{{< amp-image
    class="post__image"
    alt="Ejemplo de imagen generada por carbon.sh.now"
    src="/images/nuevo-dominio-legibilidad-integracion-amp-scripts-share.png"
    width="1760"
    height="852"
    layout="responsive" >}}

Las etiquetas de [Open Graph Protocol](https://ogp.me/) y Twitter Cards ya las tenía añadidas así que me bastó con meter la url en la configuración de cada post.

La verdad es que es difícil elegir una imágen para un post técnico, así que esta es mi manera de salir del paso... No está mal pero es mejorable, seguro que iteraré sobre esto en el futuro cercano.

## Siguientes pasos 👣

Para la próxima iteración, como comenté en el anterior post, no solo voy a integrar los datos estructurados de artículo, voy a añadir artículo, migas de pan, website y organización. A tope con el SEO técnico! Stay tuned! 😎

## Wayback Machine ⏰

Ver la [versión original de este post](https://web.archive.org/web/20191110172247/https://asur.dev/metablogs/nuevo-dominio-legibilidad-integracion-amp-scripts/ "Versión original del post").

Ver la [versión original de la homepage](https://web.archive.org/web/20191110172347/https://asur.dev/ "Versión original de la homepage").
