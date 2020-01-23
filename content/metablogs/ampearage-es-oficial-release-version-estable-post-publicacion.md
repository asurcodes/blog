+++
draft = true
date = "2020-01-26T12:12:13+02:00"
publishdate = "2020-01-26T12:12:13+02:00"

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
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta el cacharreo y la tecnología. Siempre intento aprender cosas nuevas."

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Amperage es gold! Release de la primera versión estable

{{% under-title %}}

No sé si te has enterado pero Amperage es oficialmente un tema de Hugo! La semana pasada fué añadido a la web the themes.hugo.io e incluso me han mencionado en su cuenta de twitter:

<amp-twitter
  width="450"
  height="330"
  layout="fixed"
  data-tweetid="1214969181155794946"></amp-twitter>

Como puedes imaginar me hace muchísima ilusión, ya que **este ha sido mi primer proyecto Open Source que ha llegado a su fase final!**

{{% toc %}}

## Primera versión estable

Hace nada me han abierto [mi primer issue](https://github.com/asurbernardo/amperage/issues/23) debido a un bug en las tags debido a un cambio que había hecho recientemente.

Esto me hizo pensar en que esto de desarrollar en `master` tenía que acabar, ahora este tema lo usa más gente y debería tener una rama estable que se pudiese usar sin exponerse a bugs causados por *rolling changes*.

He movido la actividad de desarrollo a la rama `development` como medida para preparar un futuro setup de git-flow si el tema coge impulso y más gente decide aportar PRs.

Pero antes de que todo esto ocurriese me dió tiempo a meter alguna funcionalidad extra en la versión 1.0, aquí están:

## Primera versión estable