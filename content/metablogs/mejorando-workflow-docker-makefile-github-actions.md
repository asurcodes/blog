+++
draft = false
date = "2019-11-04T10:12:32+02:00"
publishdate = "2019-11-04T10:12:32+02:00"

title = "Metablog #3 - Workflow con docker, makefile y Github actions"

description = "Actualizo el workflow, dockerizo el entorno, creo un Makefile para mantener todos mis scripts ordenados y añado despliegue continuo con Github Actions"

summary = "Si antes comento en el primer post que he escrito en el blog que estoy contento con el workflow antes lo cambio, ahora cuento con un **entorno dockerizado**, un **Makefile** para mantener todos mis scripts ordenados y **despliegue continuo**, que se dice pronto."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'gohugo', 'despliegue continuo', 'github actions', 'makefile', 'docker', 'contenedores']

[amp]
    elements = ['amp-video', 'amp-anim']

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

[image]
    src = "/images/mejorando-workflow-docker-makefile-github-actions/share-card.jpg"
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

# Nuevo workflow: docker, makefile y CD con GH actions

{{% under-title %}}

Si antes comento en el primer post que he escrito en el blog que estoy contento con el workflow antes lo cambio, ahora cuento con un **entorno dockerizado**, un **Makefile** para mantener todos mis scripts ordenados y **despliegue continuo** con Github Actions, que se dice pronto.

{{% toc %}}

## Dockerizando 🐳

Para empezar, ¿qué repositorio moderno que se precie no está dockerizado?

 > *Ninguno!!*

Exacto! Y para evitar que la gente (yo) tenga que andar instalándose Golang y Hugo por cada ordenador en el que quiera desarrollar o escribir, pues mejor hacerlo con docker, no? **NO**?

Por supuesto esto no habría sido posible sin la inestimable ayuda de [Javier](https://www.linkedin.com/in/javier-coscolla-cabrera-95948224/), un compañero de trabajo que me ha estado ayudando a afianzar conceptos sobre este maravilloso mundo de los contenedores y los sitemas informáticos!

Bien, vamos a ello... Este proceso tiene dos partes, un `Dockerfile` para construir la imagen:

{{< highlight dockerfile "linenos=table" >}}

FROM alpine:edge

RUN apk update \
    && apk add git hugo --no-cache \
    && rm -vrf /var/cache/apk/*

RUN git clone https://github.com/asurbernardo/blog.git

WORKDIR /blog

RUN git submodule foreach pull origin master

EXPOSE 1313

{{< / highlight >}}

 y un `docker-compose.yml` para parametrizar y levantar el entorno:

{{< highlight yaml "linenos=table" >}}

version: '3'
services:
  web:
    build: .
    ports:
      - "1313:1313"
    volumes:
      - .:/blog
    command: hugo server --verbose --watch --buildFuture --buildDrafts -D --bind 0.0.0.0

{{< / highlight >}}

La imagen que se crea con el `Dockerfile` ocupa aproximadamente \~80Mb, utiliza la base `alpine` que es una imagen basada en [Alpine Linux](https://alpinelinux.org/) que solo ocupa 5Mb! No hace más que instalar Hugo y descargar el repositorio, creando así una build agnóstica del entorno.

En el `docker-compose` ya es donde configuramos todo lo necesario para nuestro entorno actual, en este caso el local. Vamos a ver línea por línea:

 - **Línea 1**: Declarar la versión del *compose file*, ojo aquí que depende del *Docker engine* que uses hay que [usar una versión u otra](https://docs.docker.com/compose/compose-file/).

 - **Línea 2-3**: Declarar los servicios, en este caso solo hay uno, pero por ejemplo, en el caso de tener una aplicación estilo LAMP, pondrías tu Apache, tu MySQL y tu PHP-fpm.

 - **Línea 4**: Que imagen utilizar para el servicio, se puede elegir una subida en un repositorio público como [Docker Hub](https://hub.docker.com/) o, como en este caso, usar un `Dockerfile` local utilizando un path relativo.

 - **Línea 5-6**: El mapeo de puertos. Aquí siempre me lío y lo tengo que consultar, el orden es `HOST:CONTAINER` Asur, `HOST:CONTAINER`, `HOST:CONTAINER`, `HOST:CONTAINER`!

 - **Línea 7-8**: El mapeo de volúmenes. Lo mismo que los puertos pero con directorios... Ah sí, `HOST:CONTAINER`!!

 - **Línea 9**: El comando inicial al ejecutar un `docker-compose up` para ya tener el servidor levantado y funcionando.

Es un ejemplo muy simple pero tiene los casos de uso más comunes, seguiré investigando funcionalidades más avanzadas y os iré contando si cambio algo.

## El Makefile 🏗️

Esto ha sido la sorpresa del mes, como me comenta Javier, el Makefile es más viejo que muchos de nosotros y es verdad, lo he buscado en la Wikipedia, es de Abril de 1976!

Todo esto porque ha resurgido últimamente la moda de utilizar uno de estos ficheros para organizar los comandos de tu proyecto, para que los puedas ejecutar todos de manera secuencial o cada uno individualmente y he de admitir que me gusta mucho, igual es algo *hipster*, si, pero es cómodo al fin y al cabo.

Tras una breve sesión de investigación de la sintaxis lo único que tuve que hacer fué migrar mi antiguo `deploy.sh` y reorganizarlo en comandos más atómicos:

{{< highlight makefile "linenos=table" >}}

# Declarar que scripts se van a invocar cuando se llame a make asecas
all: update_theme clone_site compile deploy
.PHONY: all

# Variables!
NOW = $(shell date)
GITHUB_PAGES_REPO = git@github.com:asurbernardo/asurbernardo.github.io.git

# Distintos scripts de la pipeline de despliegue
update_theme:
    @printf "\033[0;32mUpdating theme submodule...\033[0m\n"
    git submodule foreach git pull origin master

clone_site:
    @printf "\033[0;32mCloning site from remote...\033[0m\n"
    rm -rf public
    git clone $(GITHUB_PAGES_REPO) public

compile:
    @printf "\033[0;32mCompiling content...\033[0m\n"
    hugo -t amperage --minify

deploy:
    @printf "\033[0;32mDeploying content to Github...\033[0m\n"
    cd public && \
        git add --all && \
        git commit -m "Rebuilding site - $(NOW)" && \
        git push origin master

{{< / highlight >}}

Como se puede ver en este snippet, hay 4 partes bien diferenciadas, aunque todas juntas formen la pipeline de despliegue y las pueda invocar con un `make`, también puedo hacer `make update_theme` si lo necesitase y ejecutaría solo ese script.

Al ejecutarlo todo junto se ve algo así:

{{< amp-gif
    alt="Output de consola del comando make"
    src="/images/mejorando-workflow-docker-makefile-github-actions/make-command.gif"
    width="1367"
    height="1112"
    layout="responsive" >}}

**OJO**: He descubierto por las malas que **cada línea de un Makefile se ejecuta en un entorno independiente**, siempre partiendo de la raiz desde donde se ha ejecutado el `make`, así que olvídate de cambiarte de directorio y hacer algo en una línea nueva por que no te va a funcionar (la que he armado en mi historial de git probando esto fué muy gorda).

## Github Actions 🐱

Microsoft parece que le está dando bastante amor a Github en forma de $$$ porque ya no solo tenemos repositorios privados gratuitos, ahora también tenemos una pipeline de CI/CD en Beta, es casi como si estuviesen copiando a GitLab!!

La Beta es abierta y mientras tengas un repositorio puedes activarla, las inscripciones se hacen en la [página oficial de actions](https://github.com/features/actions). Una vez apuntado se añadirá una pestaña de *Actions* para tu repositorio donde puedes acceder a un marketplace de snippets, pero sinceramente yo prefiero escribir la pipeline por mi cuenta a instalar los workflows como si fuesen apps, así que solo lo utilizo como un buscador.

Los límites de uso son **MUY** generosos, de la [documentación oficial de GH actions](https://help.github.com/es/github/automating-your-workflow-with-github-actions/about-github-actions#usage-limits):

 - Puedes ejecutar hasta 20 flujos de trabajo simultáneamente por repositorio.
 - Puedes ejecutar hasta 1000 solicitudes API en una hora en todas las acciones dentro de un repositorio.
 - Cada trabajo en un flujo de trabajo puede ejecutarse por hasta 6 horas de tiempo de ejecución.
 - Puedes ejecutar hasta 20 trabajos simultáneamente por repositorio en todos los flujos de trabajo.

Por supuesto, todo esto está hosteado en **Azure**, eso le permite a Github dar estos usos tan amplios. En concreto cada entorno virtual está hosteado en una instancia de tipo `Standard_DS2_v2`, que tienen **2 core CPUs, 7 GB of RAM memory, 14 GB of SSD disk space**, de nuevo... *Holy $hit!*

Los ficheros de configuración son formato `yml` y tienen una sintaxis parecida a otros proveedores de funcionalidades pareceidas como Travis o CircleCI. Siempre viene bien tener las cosas unificadas (aunque Travis y compañia para repositorios abiertos son gratis también) y además es algo nuevo y había que probarlo.

### Despliegue continuo

Desde mi punto de vista, **el mejor workflow es no tener workflow** y como esto es un site estático y no necesito ningún tipo de integración, os presento a mi mejor amigo desde hace una semana: el *Continuous Deployment*.

Para que GH te detecte el fichero hay que crealo en la ruta `.github/workflows/main.yml` y mi resultado final se ve así:

{{< highlight yml "linenos=table" >}}

name: Deploy blog
on:
  push:
    branches:
    - master

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:

    - name: Pull source
      uses: actions/checkout@master
      with:
        submodules: true

    - name: Update submodules to latests master
      run: git submodule foreach git pull origin master

    - name: Setup Hugo
      uses: peaceiris/actions-hugo@v2.2.2
      with:
        hugo-version: '0.58.3'
        extended: true

    - name: Build
      run: hugo -t amperage --gc --minify

    - name: Deploy script
      uses: peaceiris/actions-gh-pages@v2.5.0
      env:
        ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
        EXTERNAL_REPOSITORY: asurbernardo/asurbernardo.github.io
        PUBLISH_BRANCH: master
        PUBLISH_DIR: ./public

{{< / highlight >}}

Para empezar tenemos que declarar el nombre del workflow (línea 1) y en que casos se ejecuta, para mi situación, lo mejor es con cada push a master (línea 2-5).

Después hay que crear la pipeline, primero el SO en el que se ejecutará, en mi caso Ubuntu (línea x) y después cada uno de los pasos:

 - **Pull source:** Este es un paso bastante estandar entre todas las GH actions que he investigado, su función es hacer accesible el código del repositorio a la pipeline.
 - **Update submodules to latests master:** Este es un *step* que ejecuta un comando que se descarga la última versión del tema Amperage.
 - **Setup Hugo:** Primer ejemplo de como podemos usar una action externa, las configuraciones suelen estar explicadas en el *README.md* del repositorio con el mismo nombre que el contenido del campo `uses`.
 - **Build:** Otro comando, pero en este caso utiliza el entorno configurado en el paso anterior, es decir, en cada paso puedes configurar el entorno.
 - **Deploy script:** De nuevo, una action externa con algo más de configuración, lo único destacable es que los secrets se pueden añadir en la configuración del repositorio y son accesibles desde la pipeline, muy útiles si necesitas una clave de despliegue como es mi caso.

Si quieres ver como se han configurado los pasos 3 y 5 puedes visitar el [perfil de *peaceiris*](https://github.com/peaceiris), parece que ha pasado sus horas pegándose con GH actions y es una máquina ([con soporte incluido!](https://github.com/peaceiris/actions-gh-pages/issues/45)).

La verdad es que una vez lo tienes funcionando, aunque la interfaz de Github a veces tiene algún bug es algo muy satisfactorio de ver:

{{< amp-video
    alt="Output de consola del comando make"
    src="/videos/gh-actions-workflow.m4v"
    width="1280"
    height="576"
    layout="responsive" >}}

De media suele tardar unos 30 segundos desde que hago el push en estar ya desplegado, no está nada mal, lo único que espero es no levantarme un día y ver que me van a quitar esta funcionalidad a no ser que empiece a pagar.

## Siguientes pasos 👣

Para la próxima tanda creo que voy a añadir botones de compartir, la capacidad de elegir solo los scripts de AMP necesarios para cada post en vez de declararlos de manera global, así evitaré descargas innecesarias, también una redistribución del contenido a una sola columna sin sidebar para mejorar la experiencia de lectura y si me da tiempo incluiré los datos estructurados de artículo en los posts, así que como siempre, *stay tuned!* 😎