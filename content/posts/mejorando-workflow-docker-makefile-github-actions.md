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

# Workflow con docker, makefile y Github actions

Si antes comento en el primer post que he escrito en el blog que estoy contento con el workflow antes lo cambio, por supuesto con la inestimable ayuda de [Javier](https://www.linkedin.com/in/javier-coscolla-cabrera-95948224/), un compañero de trabajo que me ha estado ayudando a afianzar conceptos sobre este maravilloso mundo de los sistemas informáticos!

## Dockerfile

**@TODO**

{{< highlight dockerfile "linenos=table" >}}

FROM alpine:edge

RUN apk update \
    && apk add git openssh hugo --no-cache \
    && rm -vrf /var/cache/apk/*

RUN git config --global url."https://$GITHUB_TOKEN:@github.com/".insteadOf "https://github.com/"
RUN git config --global url."https://$GITHUB_TOKEN:@github.com/".insteadOf "git@github.com:"

RUN git clone --recurse-submodules --remote-submodules https://github.com/asurbernardo/blog.git

WORKDIR /blog 

EXPOSE 1313

CMD ["hugo","-t","amperage","server","--buildFuture","--bind","0.0.0.0"]

{{< / highlight >}}

## Makefile

**@TODO**

{{< highlight makefile "linenos=table" >}}

all: compile deploy

.PHONY: all

NOW = $(shell date)

compile:
    @printf "\033[0;32mUpdating theme submodule...\033[0m\n"
    # Update theme
    git submodule foreach git pull origin master
    @printf "\033[0;32mCompiling content...\033[0m\n"
    # Compile content
    hugo -t amperage --minify

deploy:
    @printf "\033[0;32mDeploying content to Github...\033[0m\n"
    # Go to Public folder
    cd public && \
        git add . && \
        git commit -m "Rebuilding site - $(NOW)" && \
        git push origin master

{{< / highlight >}}

## Github actions beta

**@TODO**

### Despliegue continuo

**@TODO**

## Siguientes pasos

**@TODO**