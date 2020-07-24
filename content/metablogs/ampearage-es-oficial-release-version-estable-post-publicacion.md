+++
draft = false
date = "2020-01-30T17:50:13+02:00"
publishdate = "2020-01-30T17:50:13+02:00"

title = "Metablog #11 - Amperage es gold! Release de la primera versión estable"

description = "Amperage ya es oficialmente un tema de GoHugo. Tras la primera revisión y el release de la versión 1.0 recopilo las mejoras más relevantes, nuevos componentes, etiquetas hreflang y más"

summary = "No sé si te has enterado pero **Amperage es oficialmente un tema de Hugo!** Tras la primera revisión y el release de la versión estable 1.0 he recopilado las mejoras más relevantes como algunos **nuevos componentes**, etiquetas **hreflang configurables** y más!"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'amperage', 'comento', 'gohugo', 'open source', 'revisión']

[amp]
    elements = ['amp-twitter']

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

[image]
    src = "/images/amperage-es-oficial-release-version-estable-post-publicacion/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Amperage es gold! Release de la primera versión estable

{{< under-title >}}

No sé si te has enterado pero Amperage es oficialmente un tema de Hugo! La semana pasada fué añadido a la web the themes.hugo.io e incluso me han mencionado en su cuenta de twitter:

<amp-twitter
  width="380"
  height="550"
  layout="fixed"
  data-tweetid="1214969181155794946"></amp-twitter>

Como puedes imaginar me hace muchísima ilusión, ya que **este ha sido mi primer proyecto Open Source que ha llegado a su fase final!**

{{% toc %}}

## Primera versión estable

Hace nada me han abierto [mi primer issue](https://github.com/asurbernardo/amperage/issues/23) debido a un bug en las tags debido a un cambio que había hecho recientemente.

Esto me hizo pensar en que esto de desarrollar en `master` tenía que acabar, ahora este tema lo usa más gente y debería tener una rama estable que se pudiese usar sin exponerse a bugs causados por *rolling changes*.

He movido la actividad de desarrollo a la rama `development` como medida para preparar un futuro setup de git-flow si el tema coge impulso y más gente decide aportar PRs.

Pero antes de que todo esto ocurriese me dió tiempo a meter alguna funcionalidad extra en la versión 1.0, aquí están:

**EDIT:** He tardado tanto en escribir este post que ya va por la versión 1.1. He estado ocupado, ¡¿VALE?!

Puedes ver los releases con sus respectivas ramas y tags en GitHub: [asurbernardo/amperage/releases](https://github.com/asurbernardo/amperage/releases)

## Nuevas features! 🥳

Aquí te dejo la lista de todas las novedades. Recuerda que lo puedes ver todo en acción en la [kitchen sink de Amperage](https://asur.dev/en/amperage/theme-kitchen-sink/).

### La tarjeta para producto

Este componente lo he creado principalmente para resaltar productos con un CTA (*call to action*).

Es perfecto para marketing de afiliados o para hacer reviews, aunque lo he hecho con la idea de que sea flexible y que sirva para todo un poco.

Aquí tienes un ejemplo:

{{< product
    title="Un patito de goma"
    description="El mejor amigo de un programador es un patito de goma, cuando nadie quiera escucharte él siempre estará ahí. 🦆"
    image="https://images-na.ssl-images-amazon.com/images/I/8166xCVDGnL._SL1500_.jpg"
    cta="¡Cómpralo en Amazon!"
    link="https://amzn.to/2GzjKq8" >}}

Lo he hecho en un shortcode que acepta: `title`, `image`, `description`, `cta` y `link`. El ejemplo de arriba al escribirlo sería así:

{{< highlight md "linenos=table" >}}

{{</* product
    title="Un patito de goma"
    description="El mejor amigo de un programador es un patito de goma, cuando nadie quiera escucharte él siempre estará ahí. 🦆"
    image="https://example.com/your-image.jpg"
    cta="¡Cómpralo en Amazon!"
    link="https://example.com/your-link" */>}}

{{< / highlight >}}

Algo que me gustaría mejorar en el futuro es añadir la posibilidad de usar markdown en la descripción, ahora mismo solo admite texto plano.

Lo puedes ver en acción en la [página de /uses](https://asur.dev/uses) del menú donde listo las cosas que utilizo en mi día a día y con qué está hecho este mismo blog.

### Los post-its

Me parecía que este blog al ser bastante técnico había puntos que los *muros de texto* eran insalvables. Por eso he decidido desarrollar este componente.

No dejan de ser tarjetas de colores pero su cometido es romper el flujo de lectura para hacerlo menos pesado.

A diferencia de los productos aquí si se puede utilizar markdown dentro de los shortcodes, lo que los hace bastante más polivalentes.

Mira, un ejemplo:

{{% post-it type="info" title=" 💡 Sabías qué... " %}}
  En la mitología griega, *Niké* (en griego, Νίκη) es la diosa de la victoria. Algunos datos random:

  - Se la representaba a menudo como una pequeña escultura alada.

  - Su imagen adorna el frontal de los Rolls Royce.

  - Según la leyenda fué la última palabra que pronunció Filípides trás correr la primera maratón para anunciar la victoria ateniense contra los persas.

  - La palabra fué registrada en 1964 por una marca de calzado estadounidense que seguro que te suena vagamente...
{{% / post-it %}}

¿Ves? ¿A que funciona bastante bien?

He hecho que aceptasen un parámetro `type` que puede ser: `tip`, `warning`, `danger` e `info`, con fondo azul, amarillo, rojo y azul respectivamente.

Además se les puede añadir un `title` que aparecerá en grande en la parte superior.

Ambos parámetros son opcionales y el tipo tiene `warning` como fallback.

El ejemplo anterior sería así:

{{< highlight md "linenos=table" >}}

{{%/* post-it type="info" title="¿Sabías qué...? 💡 " */%}}

El texto iría aquí...

{{%/* / post-it */%}}

{{< / highlight >}}

### Etiquetas hreflang configurables

No podía faltar el toque de SEO técnico en esta actualización. Pues eso, ahora se pueden configurar a mano las tags *hreflang* de cada post.

Esta feature la tenía pensada desde que metí la internacionalización y por fin está aquí.

Simplemente en la *frontmatter* del post puedes añadir los post equivalentes y su respectivo idioma:

{{< highlight toml "linenos=table" >}}

[alternatives.en]
    code = "en"
    url = "https://asur.dev/en/how-to-deploy-your-own-crypto-trading-bot/"

{{< / highlight >}}

Con esto los motores de búsqueda podrán encontrar más facilmente la página dependiendo del idioma de búsqueda.

Recuerda que los contenidos tienen que ser equivalentes y preferiblemente una traducción directa, no se debe linkear una página que no tenga nada que ver con la original.

### La tarjeta de autor

¡Esta es la incorporación más reciente y era algo que estaba claro que le faltaba al blog! Ahora se puede crear una tarjeta de autor desde la configuración.

También he aprovechado a añadir un recordatorio para compartir y comentar al final del post, que es el lugar más lógico para sugestionar a tus lectores por lo que he leido...

La tarjeta es totalmente adaptable y ninguno de sus atributos son obligatorios.

Esos parámetros extra que se introducen ahora los he incluido en los datos estructurados del blog para enriquecerlos más, en el de tipo `Article` por ejemplo.

Puedes ver el resultado al final de este post (**foto 100% real no fake BTW**).

## ¿Y ahora qué? 🤔

Bueno, lo primero es decir que el desarrollo del tema no va a parar, pero se va a ralentizar de manera notable y con ello la cantidad de metablogs.

Por supuesto seguiré manteniendo el proyecto con bugfixes y posibles pull requests que puedan ir llegando.

 > ¿Pero vas a abandonar el blog? 😢

¿¡Pero que dices!? Tengo en la cabeza que me va a mil últimamente y ya he pensado en el siguiente proyecto, de hecho ya está bastante avanzado y, por supuesto, cuando lo publique escribiré un post. *Stay tuned!* 😎

## Wayback machine ⏰

Ver la [versión original de este post](https://web.archive.org/web/20200130165858/https://asur.dev/metablogs/ampearage-es-oficial-release-version-estable-post-publicacion/ "Versión original del post").
