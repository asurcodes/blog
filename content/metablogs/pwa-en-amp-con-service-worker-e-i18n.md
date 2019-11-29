+++
draft = false
date = "2019-11-29T10:19:05+02:00"
publishdate = "2019-11-29T10:19:05+02:00"

title = "Metablog #6 - PWA y soporte multi-idioma"

description = "Creo una PWA en AMP utilizando service workers para poder instalarla en tu móvil y accder offline, además añado i18n con una nueva sección en inglés!"

summary = "Añado al tema de Amperage integración con **service workers** para convertir esta web en una **PWA** y poder instalarla en tu móvil y acceder offline, además de soporte para **internacionalización** (i18n) y multi-idioma con una nueva sección en inglés incluida!"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'amperage', 'i18n', 'amp', 'service workers', 'pwa']

[amp]
    elements = ['amp-twitter']

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = "/images/pwa-en-amp-con-service-worker-e-i18n.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# PWA y soporte multi-idioma

{{% under-title %}}

Una nueva semana, una nueva mejora! No os voy a engañar, van quedando pocas cosas que hacer además de seguir iterando en estilos y cambios pequeños, pero estos dos son muy top.

Para empezar he transformado mi web en una **PWA** (Progressive Web App) utilizando una librería de **service workers** para AMP, además he añadido soporte a mi tema Amperage para **multi-idioma**, traducciones y con una nueva sección en inglés incluida! 🎉

{{% toc %}}

## Convirtiendo una web con AMP en PWA 🤖

Hace poco puse un tweet que incluía un spoiler:

<amp-twitter
  width="390"
  height="330"
  layout="fixed"
  data-tweetid="1197989534484619264"></amp-twitter>

Después de ir a la [CommitConf 2019](https://2019.commit-conf.com/) este fin de semana pasado, la noche del Viernes llegué a casa con las pilas creativas recargadas y contra toda lógica me puse a hacer unas pruebas de rendimiento. Sin querer acabé posteando que mi blog ya era oficialmente una PWA! 😬

Tras investigar el tema, parece que los propios creadores de AMP son fanáticos del concepto de webs progresivas, porque han creado una [librería maravillosa](https://github.com/ampproject/amp-sw) facilita muchísimo la parte de programar el service worker.

### Registrar el service worker

Bien, para empezar hay que dejar claro que por lo especialito que es AMP para con el javascript hay que hacer las cosas de una manera particular.

Por supuesto hay un componente específico para esta tarea llamado `amp-install-serviceworker`. La forma que tiene es la siguiente:

{{< highlight html "linenos=table" >}}

<amp-install-serviceworker
  src="https://asur.dev/sw.js"
  data-iframe-src="https://asur.dev/install-sw.html"
  layout="nodisplay">
</amp-install-serviceworker>

{{< / highlight >}}

Tiene tres atributos, el último es autoexplicativo y el primero es donde se encuentra el javascript que instala el service worker...

> ¿Entonces para que narices sirve el segundo? 😐

Exactamente lo mismo que me pregunté yo. Pues parece que cuando se accede desde el cache de Google a una página AMP el service worker debe de ser instalado desde un iframe. De la documentación oficial:

>When the document is accessed via the Google AMP Cache, the HTML document noted in the data-iframe-src attribute is used to install the service worker. We recommend using both attributes.

El porqué es la seguridad, **los navegadores no pueden instalar service workers de dominios que no son el actual**. Para más detalles os recomiendo una lectura rápida a las [especificaciones de w3.org sobre service workers](https://www.w3.org/TR/service-workers/#origin-restriction).

Lo más gracioso es la url del `data-iframe-source` hay que tener exactamente el mismo código que el `<amp-install-serviceworker>` de origen, como en *Inception*.

Para instalar el service worker he usado la librería que mencioné al principio, lo único que hay que hacer es inicializarla con la configuración que mejor se adapte a nuestro caso:

{{< highlight javascript "linenos=table" >}}

importScripts('https://cdn.ampproject.org/sw/amp-sw.js');

AMP_SW.init({
  assetCachingOptions: [{
    regexp: /\.(png|jpg|woff2|woff|css|js)/,
    cachingStrategy: 'CACHE_FIRST',
  }],
  offlinePageOptions: {
    url: '/offline.html',
    assets: [],
  },
  linkPrefetchOptions: {}
});

{{< / highlight >}}

En mi caso la única configuración que he puesto es el cacheo de assets estáticos como imágenes, fuentes, javascript y css.

Además he especificado el fichero que se mostrará cuando un usuario intente acceder offline a la aplicación y no tenga cacheada esa url en concreto. Aquí puedes ver [qué se mostraría cuando no tienes internet](https://asur.dev/offline.html).

Con esto el service worker ya se registra correctamente. Lo podemos confirmar con *Google DevTools*:

{{< amp-image
    class="post__image"
    alt="Éxito instalación service worker en DevTools"
    src="/images/exito-instalacion-service-worker-dev-tools.jpg"
    width="1048"
    height="525"
    layout="responsive" >}}

Para probarlo definitivamente puedes desconectarte de internet y recargar la página, debería seguir apareciendo el contenido. 😄

Pero todavía el blog no es una Progressive Web App, faltan un par de cosas para que Google de su bendición, aunque lo más difícil ya está hecho!

### Convertir en PWA instalable

El service worker ya está funcionando pero aún quedan un par de cosas por hacer para validar nuestra PWA.

La más importante es un `manifest.json` un fichero donde se almacena la información necesaria para instalar la app.

{{< highlight json "linenos=table" >}}

{
  "name": "Blog de Asur",
  "short_name": "asur.dev",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#fff",
  "theme_color": "#ef8b80",
  "description": "Bienvenid@ a mi blog, si te gusta el desarrollo web, el SEO, el open source
    y la tecnología en general echa un vistazo, seguro que encuentras algo interesante.",
  "icons":[{
      "src":"/icons/android-chrome-192x192.png",
      "sizes":"192x192",
      "type":"image/png"
    },{
      "src":"/icons/android-chrome-512x512.png",
      "sizes":"512x512",
      "type":"image/png"
  }]
}

{{< / highlight >}}

Algunas caracteristicas a destacar son:

 - **name**: El nombre de tu aplicación, esto aparecerá en la splash screen cuando abras la app.
 - **start_url**: La url que es la home desde la que se inicia la app, suele ser `/` el 99% de las veces aunque también le podrías configurar un subdirectorio o parámetros extra para analítica.
 - **display**: Como se muestra la app en el dispositivo, standalone significa que la barra de url se oculta, justo como una app nativa!
 - **background_color**: El color de fondo de la splash screen.
 - **theme_color**: El color de la barra de tareas de tu móvil cuando estás en la app.
 - **icons**: Las imágenes centrales que aparecen en la splash screen. Se recomiendan varias resoluciones, para adaptarlas a la resolución de pantalla de cada teléfono.

Ya casi estamos ahora con linkearlo en nuestras metatags junto con los iconos de aplicación que aparecerán en android e ios estaría listo:

{{< highlight html "linenos=table" >}}

<link rel="manifest" href="https://asur.dev/manifest.json">
<link rel="icon" type="image/png" sizes="32x32" href="https://asur.dev/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="https://asur.dev/icons/favicon-16x16.png">
<link rel="apple-touch-icon" sizes="180x180" href="https://asur.dev/icons/apple-touch-icon.png">

{{< / highlight >}}

Listo, al comprobar de nuevo en *DevTools Lighthouse* se puede ver que la página es una PWA válida:

{{< amp-image
    class="post__image"
    alt="Éxito validación de PWA en DevTools Lighthouse"
    src="/images/exito-validacion-dev-tools-lighthouse.jpg"
    width="924"
    height="845"
    layout="responsive" >}}

Ahora cada persona que visite mi web desde un móvil puede disfrutar del maravilloso formulario de instalación.

**AVISO:** Por supuesto, he omitido los pasos que ya tenía hechos como utilizar https, que la web sea responsive, etc.

## Internacionalización 🌍

Siempre me ha estado rondando la idea de escribir algo en inglés, no solo por el mero hecho de practicar algo que tengo un poco oxidado, también porque para que un artículo técnico tenga una buena difusión, *IMHO*, lo ideal es que esté escrito en inglés.

### Soporte para traducciones

Para no empezar la casa por el tejado he hecho traducibles los literales del tema que antes estaban *hardcodeados*.

GoHugo soporta traducciones de manera nativa así que ha sido rápido de implementar.

Sustituyendo las cadenas con una función como `{{ i18n "goBackHome" }}` hace que al procesar el contenido Hugo busque en la ruta `/i18n/{laguange_code}.toml` por esa clave y aplique su valor.

{{< highlight toml "linenos=table" >}}

[home]
  other = "Home"
[notFound]
  other = "Page not found"
[search]
  other = "Search"
[goBackHome]
  other = "Go back to the homepage"
[by]
  other = "By"
[...]

{{< / highlight >}}

De momento solo tengo español e inglés, porque hasta ahí llego, pero por el poder del *open source* esto es fácilmente mejorable, así que si alguien se anima, ya sabéis, PR al canto en el [repositorio de Amperage](https://github.com/asurbernardo/amperage)!

### Nueva sección en inglés

Ahora que ya hay soporte para traducciones puedo crear una nueva sección en mi web y que esta use un idioma distinto a la de por defecto.

Para eso hay que especificarla en la configuración del site:

{{< highlight toml "linenos=table" >}}

theme = "amperage"
DefaultContentLanguage = "es"
[languages]
    [languages.es]
        contentDir = "content"
        languageName = "Español"
        languageCode = "es"
        title = "Bienvenid@ a mi blog | By Asur 🧐"
        description = "Bienvenid@ a mi blog, si te gusta el desarrollo web, el SEO, el open source
          y la tecnología en general echa un vistazo, seguro que encuentras algo interesante."
        weight = 1
    [languages.en]
        contentDir = "content/english"
        languageName = "English"
        languageCode = "en"
        title = "Welcome to my blog | By Asur 🧐"
        description = "This is the English section of my site. It's still a 
          work in progress but news are coming! Stay tuned!"
        weight = 2

{{< / highlight >}}

Ahora cada idioma tiene una sección separada con sus propios parámetros, y a su vez estos hacen fallback a los genéricos con la misma clave.

Sé que algún amigo del SEO que lea esto va a entrar en parada diciendo:

> Pe-pe-pero no tienes la etiqueta hreflang! 😵

Si, lo sé, es que las etiquetas como `<link rel="alternate" href="https://example.com/es" hreflang="es" />` se utilizan para especificar páginas que son una **alternativa directa** en otro idioma, no se puede usar para páginas con contenidos distintos.

Quizás el único punto en el que esto tendría sentido es en ambas homepages pero de momento lo he dejado correr, me conformo con el `<html ⚡ lang="en">`.

Ah si! El link? [Aquí podéis ver la sección en inglés](https://asur.dev/en).

## Siguientes pasos 👣

Aprovechando la nueva sección en inglés creo que la voy a escribir mi primer post en otro idioma, ya tengo una idea bastante aterrizada de que puede tratar y es la leche, pero vais a tener que esperar para verlo, *stay tuned!* 😜

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").

Ver la [versión original de la sección en inglés](# "Versión original de la sección en inglés").
