+++
draft = true
date = "2019-10-19T12:33:32+02:00"
publishdate = "2019-10-19T12:33:32+02:00"

title = "#3 Workflow con docker, makefile y Github actions"

description = ""

summary = ""

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'despliegue continuo', 'github actions', 'makefile', 'docker']

[amp]
    elements = []

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

# Nuevo workflow: docker, makefile y CD con Github actions

Si antes comento en el primer post que he escrito en el blog que estoy contento con el workflow antes lo cambio, por supuesto con la inestimable ayuda de [Javier](https://www.linkedin.com/in/javier-coscolla-cabrera-95948224/), un compañero de trabajo que me ha estado ayudando a afianzar conceptos sobre este maravilloso mundo de los sistemas informáticos!

## Dockerizando 🐳

Para empezar, ¿qué repositorio moderno que se precie no tiene un `Dockerfile`?

 > *Ninguno!!*

Exacto! Y para evitar que la gente (yo) tenga que andar instalándose Golang y Hugo por cada ordenador donde quiera desarrollar, pues mejor hacerlo con docker, no? **NO**?

Este proceso tiene dos partes, un `Dockerfile` para construir la imagen y un `docker-compose.yml` para parametrizar y levantar el entorno.

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

y

{{< highlight yaml "linenos=table" >}}

version: '3'
services:
  web:
    build: .
    ports:
      - "1313:1313"
    volumes:
      - .:/blog
    command: hugo server --watch -D --bind 0.0.0.0

{{< / highlight >}}

**@TODO** Documentar snippets

## El Makefile 🏗️

Esto ha sido la sorpresa de mi vida, como me comenta Javier, el Makefile es más viejo que muchos de nosotros y es verdad, lo he buscado en la Wikipedia, es de Abril de 1976.

La verdad es que ha resurgido últimamente la moda de utilizar uno de estos ficheros para organizar los comandos de tu proyecto, de manera que los puedas ejecutar todos de manera secuencial o cada uno individualmente y he de admitir que me gusta mucho, igual es algo *hipster*, si, pero es cómodo al fin y al cabo.

**@TODO** Describir el proceso de creación

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

**@TODO** Grabar en ANSICinema el proceso de despliegue con make

**OJO**: He descubierto por las malas que **cada línea de un Makefile se ejecuta en un entorno independiente**, siempre partiendo de la raiz desde donde se ha ejecutado el `make`, así que olvídate de cambiarte de directorio y hacer algo en una línea nueva por que no te va a funcionar (la que he armado en mi historial de git probando esto es muy gorda).

## Github Actions 🐱

**@TODO** Documentar el proceso de registro en la beta

### Despliegue continuo

Desde mi punto de vista, **el mejor workflow es no tener workflow** y como esto es un site estático y no necesito ningún tipo de integración, os presento a mi mejor amigo desde hace una semana: el *Continuous Deployment*.

**@TODO** Añadir vídeo de la pipeline de despliegue

## Siguientes pasos 👣

**@TODO**

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").

Ver la [versión original de la homepage](# "Versión original de la homepage").