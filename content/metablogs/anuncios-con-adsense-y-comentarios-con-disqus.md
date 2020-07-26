+++
draft = false
date = "2019-12-23T12:09:32+02:00"
publishdate = "2019-12-23T12:09:32+02:00"

title = "Metablog #10 - Comentarios con Disqus y anuncios con Adsense"

description = "He probado varios sistemas de comentarios y me he decantado por meter Disqus en Amperage. Para monetizar también he integrado anuncios de Adsense compatibles con AMP"

summary = "Después de probar **sistemas de comentarios** como Commento o Remark lo he descartado en favor de una opción más accesible a todos los usuarios de Amperage: **Disqus**. Para dar una opción de monetización también he dado soporte a **Google Adsense** en forma de shortcodes."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'anuncios', 'adsense', 'amp', 'comentarios', 'disqus']

[amp]
    elements = ['amp-twitter', 'amp-ad']

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

[image]
    src = "/images/anuncios-con-adsense-y-comentarios-con-disqus/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Comentarios con Disqus y anuncios con Adsense

{{< under-title >}}

Pues parece que sí que había tareas en la recámara al final, ¿no? Una nueva revisión de Amperage ya está aquí y trae novedades muy top con historias de superación incluidas! 😬

{{< toc >}}

## Comentarios con Disqus 💬

Después de probar varios sistemas de comentarios independientes como Commento y Remark le he estado dando vueltas y me he dado cuenta de que no es viable.

El hecho de que todo el mundo que quiera utilizar este tema tenga que montarse su propia infraestructura y desplegar una imagen de Docker no es realista.

Por esto he decidido que, para llegar a la mayor cantidad de gente posible la mejor opción es **Disqus**.

### Integración con AMP

El mayor problema de crear cualquier sistema de comentarios en Amperage es la integración con AMP y Disqus no es ninguna excepción.

Por suerte el equipo de Disqus ha creado [una guía de integración](https://github.com/disqus/disqus-install-examples/tree/master/google-amp) para hacerle la vida más fácil a los desarrolladores.

Aún así he estado a punto de tirar la toalla con esta feature debido a un comportamiento inesperado del componente `amp-iframe` que casi me vuelve loco.

Todo empieza con la necesidad por parte de AMP de asignar un espacio inicial a todos los componentes para evitar el [content jumping](https://css-tricks.com/content-jumping-avoid/).

> Todo bien, ¿no? ¡Esto mejora la experiencia de usuario! ¿no? ¿NO? 🤩

Si por supuesto, ¡a tope con UX! **El problema viene cuando tienes que asignar un tamaño fijo a un contenido de tamaño variable**, como una caja de comentarios. El resultado es que o bien aparece un espacio en blanco o bien el contenido está cortado.

El equipo de AMP ya había pensado en esto y hay una [manera oficial de hacer resize de un iframe](https://amp.dev/es/documentation/components/amp-iframe/#cambio-de-tama%C3%B1o-del-iframe) una vez este se ha cargado. El contenido embebido debe postear un mensaje del tipo `embed-size` al centinela `amp`. Algo así:

{{< highlight javascript "linenos=table" >}}

window.parent.postMessage({
  sentinel: 'amp',
  type: 'embed-size',
  height: document.body.scrollHeight
}, '*');

{{< / highlight >}}

Pero la cosa no queda ahí, tu iframe tiene que venir **obligatoriamente** de un dominio distinto, tener el atributo `sandbox="allow-same-origin"` y contener un elemento `overflow`. Este es el mío:

{{< highlight go-html-template "linenos=table" >}}

{{ if isset .Site.Params "commentsembedurl" }}
    <amp-iframe width=600 height=180
        layout="responsive"
        sandbox="allow-scripts allow-same-origin allow-modals allow-popups allow-forms"
        resizable
        src="{{ .Site.Params.CommentsEmbedUrl }}#{{ .Page.URL }}">
        <div overflow
            tabindex=0
            role=button
            aria-label="Load more"
            style="display:block;font-size:12px; [...]">
            Load more
        </div>
    </amp-iframe>
{{ end }}

{{< / highlight >}}

Leí por ahí que con hacer un subdominio con una redirección a mi dominio principal valdría, es decir, crear un `disqus.asur.dev` que redireccionase a `asur.dev/disqus.html`.

Efectivamente el iframe funcionaba sin problemas y no daba ningún fallo, pero no hacía el resize!

Me pasé horas debugueando, pero no había ningún error, el `postMessage` se enviaba bien, con la altura correcta pero el componente parecía ignorarlo.

Si trabajas en `localhost` tu iframe no puede venir de `localhost` también porque casca, así que un rato después me dió por montar un túnel a mi local para poder probarlo sin tener que hacer ningún despliegue y el resize funcionaba! WTF?

Parece que **el truco de la redirección funciona genial a no ser que quieras hacer un resize** por alguna razón interna de AMP...

Tras este descubrimiento lo que hice fué deshacer los registros en el DNS y alojar un [nuevo proyecto en Github Pages](https://github.com/asurbernardo/blog-comments) con el fichero de la guía de instalación de Disqus y el dominio `disqus.asur.dev`, en esta ocasión 100% independiente del principal (`asur.dev`).

**¡Y FUNCIONÓ! ¡POR FIN!** 😭

La verdad es que no es la manera más fácil de añadir comentarios a un blog, pero es lo que hay, seguiré iterando y probando otros sistemas de comentarios nuevos, pero **lo que de verdad me gustaría es hacer el tema agnóstico** a estos!

## Anuncios con Adsense 🛒

Hay mucha gente que busca el poder monetizar su presencia online. Para habilitar esto he creado unos nuevos shortcodes que imprimer automáticamente un anuncio.

He utilizado **Adsense** por la misma razón que Disqus, por el alto grado de adopción que tiene para que el tema le sirva a la mayor cantidad de gente posible *out of the box*.

El principal problema que me he encontrado es la validación de mi web, resulta que Adsense requiere que insertes un script en tu web, pero al tener AMP al hacerlo deja de ser válido.

Les twitee al respecto:

<amp-twitter
  width="390"
  height="330"
  layout="fixed"
  data-tweetid="1204358886112804864"></amp-twitter>

No sé si ha tenido que ver, lo dudo la verdad, pero **a las 24 horas tenía la web validada, sin script ni nada!** 🥳

Con la web ya habilitada en Adsense me puedo poner a hacer pruebas, porque déjame decirte que esto de los anuncios tiene más miga de lo que parece.

Empecé probando un tipo de anuncio que es responsive, es decir, cambia su contenido dependiendo del viewport. Esta opción suena muy bien sobre el papel pero requiere darle todo el ancho de la web (`width="100vw"`), lo que no queda bien con el estilo de columna de Amperage.

Al final he optado por dar todo el poder al usuario y crear un *shortcode* en el que puedas especificar tanto el tipo de anuncio como el tamaño.

Una versión simplificada del código del shortcode:

{{< highlight go-html-template "linenos=table" >}}

{{ if isset $.Site.Params "adsensepublisher" }}
    {{ with .Params }}
        <fieldset class="ad">
            <legend><strong>#ad</strong></legend>
            <amp-ad type="adsense"
                {{ with .class }} class="{{ . }}"{{ end }}
                {{ with .alt }} alt="{{ . }}"{{ end }}
                {{ with .width }} width="{{ . }}"{{ end }}
                {{ with .height }} height="{{ . }}"{{ end }}
                {{ with .layout }} layout="{{ . }}"{{ end }}
                {{ with .slot }} data-ad-slot="{{ . }}" {{ end }}
                data-ad-client="{{ $.Site.Params.adsensePublisher }}">
                <div class="ad__fallback" fallback><p>No ad for you! :(</p></div>
            </amp-ad>
        </fieldset>
    {{ end }}
{{ end }}

{{< / highlight >}}

Un ejemplo de uso:

```
{{</* amp-adsense
    width="320"
    height="320"
    layout="fixed"
    slot="9425131909" */>}}
```

Lo único que hay que hacer para empezar a utilizarlo es añadir tu código de *publisher* en la configuración del site.

Por supuesto todo esto genera un código de anuncio válido para AMP. El resultado final:

{{< amp-adsense
    width="320"
    height="320"
    layout="fixed"
    slot="9425131909" >}}

Ahora ya sabes, a refrescar la página para darme dinero! 💸

## Próximo destino 🛣️

Voy a crear nuevos componentes visuales para los artículos, como nuevos bloques para hacer comparativas, bloques para linkear productos de Amazon, leyendas para las imágenes y más... Todo para darle un poco más de flexibilidad al blog y mejorar la experiencia de lectura evitando los *wall of text*. *Stay tuned!* 😎

## Wayback machine ⏰

Ver la [versión original de este post](# "Versión original del post").
