+++
date = "2019-10-14T12:33:32+02:00"
publishdate = "2019-10-14T12:33:32+02:00"
draft = false

title = "El primer post en mi nuevo blog!"

tags = ['Iteracion']

keywords = ['blog', 'desarrollo', 'git', 'deploy']

[amp]
    elements = []

[article]
    lead = ""
    category = ""
    related = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = ""

[image]
    src = ""
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

# El primer post en mi nuevo blog!

Si, si, ya sé que estás pensando: ¿Que leches es esta web y cómo he llegado aquí? Espera, por favor, dame la oportunidad de explicarme. Me llamo Asur y este es mi nuevo proyecto...

<!--more-->

 > *Pues menuda mierda de nuevo proyecto!* 🤣

Vale, estamos de acuerdo, pero escucha, la idea es que llegue a ser más que eso y alcance la categoría de pasable, déjame contarte cómo.

## El por qué

Para empezar, una pequeña presentación para quitarlo de delante, me llamo Asur, no espero que me conozcas, pero considero importante que sepas que, a parte de ganarme la vida con ello, me encanta programar, en concreto todo lo que tenga que ver con internet y este blog es uno de mis periódicos cacharreos tecnológicos.

Hace ya tiempo que esta idea me ha estado rondando la cabeza, **crear un blog personal el cual documente su propio proceso de desarrollo y mejora!** Mi objetivo es ir desarrollando y documentar esas mejoras en forma de posts, registrar cada paso en la [Wayback Machine](http://web.archive.org/) de *archive.org* para que cada post se pueda visitar en su estado original y poder ver la evolución paso a paso.

Así pues, la idea de esta entrada es introducir este proyecto al mundo e invitarte a un viaje en el que hablaremos mucho de programación y otros familiares, así que si te gusta el desarrollo web, el SEO o la gestión de sistemas te recomiendo que te mantengas al tanto.

## El cómo

Para llevar a cabo este proyecto elegido **GoHugo**, un generador de sites estáticos, al estilo de Jekyll, pero desarrollado en Go. También he creado un tema llamado amperage, que será donde iremos haciendo las mejoras y añadiendo funcionalidades.

Todo lo que ves es código abierto, así que si lo que ves te gusta, que de momento lo dudo, descárgatelo, pruébalo y si estás espléndid@ las aportaciones son siempre bienvenidas.

Todo está hosteado en **Github Pages**, porque es gratis, es fácil, es rápido y... ah si, es **GRATIS**.

He estado trabajando en el workflow de desarrollo para este proyecto y seguramente sea mejorable, pero estoy bastante contento con el estado actual, así que voy a entrar un poco más en detalle de como está montado todo este tinglado.

### El hosting

Este site al ser estático no necesita de mucho en cuanto a infraestructura, lo único que hace es escupir ficheros a tu navegador, lo que lo hace super rápido y sencillo de gestionar, pero como todo, el haber elegido este estilo de web implica ciertas limitaciones, no tener un backend significa que probablemente voy a tener que depender de servicios de terceros para posibles funcionalidades futuras, como comentarios en los posts o una newsletter.

Github pages me parece una opción ideal, ya que lo iba a utilizar de todas formas para alojar los repositorios, así que mato dos pájaros de un tiro. Para poner un frontal con CDN, políticas personalizadas, así como mi propio dominio utilizo **Cloudflare**, que de nuevo es gratis (vais captando el patrón aquí?).

La verdad es que lo único que me ha costado averiguar de esta parte es la convención que tiene Github para alojar tu site. Para que la web esté accesible en la url `{user}.github.io` tienes que crear un repositorio que se llame igual y esa es tu única opción y si no te gusta, pues bailas. 

### La estructura de repositorios

Este proyecto va a estar organizado en tres repositorios:

  - [Blog](https://github.com/asurbernardo/blog): Todo el contenido del blog, con sus posts escritos en markdown y sus metadatos.
  - [Tema](https://github.com/asurbernardo/amperage): El tema que he llamado amperage, donde estarán los estilos y la estructura básica de la web. Aquí es donde se va a llevar a cabo la mayor parte del desarrollo.
  - [Build](https://github.com/asurbernardo/asurbernardo.github.io): El contenido una vez ha sido compilado en HTML estático, esta es la parte que se hostea y estás leyendo ahora mismo.

A la hora de trabajar solo usaré un directorio, el repositorio de blog, pero los otros dos estarán configurados como submódulos de git, de esta manera la estructura de trabajo quedaría algo así:

```
blog
├── archetypes
├── config.toml
├── content
│   └── posts
├── data
├── deploy.sh
├── layouts
├── public // Submódulo de build
├── README.md
├── resources
├── static
└── themes
    └── amperage // Submódulo de tema
```

Todas las actualizaciones se subirán independientemente y a la hora de empezar a trabajar en un ordenador nuevo solo necesitaré clonar el repositorio y descargar sus submódulos, lo que considero bastante cómodo, algo así:

```
git clone git@github.com:asurbernardo/blog.git && git submodule update --recursive --remote
```

Por supuesto esto también aplica para alguién que quiera aportar su granito de arena al proyecto.

### El despliegue

Para desplegar la web de manera rápida y sencilla he creado un script siguiendo la [documentación oficial](https://gohugo.io/hosting-and-deployment/hosting-on-github/#put-it-into-a-script) de Hugo:

```
#!/bin/sh

# If a command fails then the deploy stops

set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project

hugo -t amperage

cd public

git add .

msg="rebuilding site $(date)"

if [ -n "$*" ]; then
    msg="$*"
fi

git commit -m "$msg"

git push origin master
```

Una vez configurado todo en tu cuenta de Github simplemente compilamos el blog con `hugo -t amperage` y pusheamos los cambios en el submódulo de `/public` con un mensaje autogenerado a partir de la fecha.

## Conclusión

De momento eso es todo, espero traer más novedades pronto, y también espero que estén relacionadas con algún estilo básico, porque creeme que el estado actual de la web me duele más a mí que a ti...

 > *Lo dudo mucho!*  😒

Bueno, pues eso, que hasta la próxima!

## Wayback Machine

Ver la [versión original de este post](http://web.archive.org/web/20191014123731/https://asurbernardo.com/posts/el-primer-post-en-mi-nuevo-blog/ "Versión original del post").

Ver la [versión original de la homepage](http://web.archive.org/web/20191014123830/https://asurbernardo.com/ "Versión original de la homepage").