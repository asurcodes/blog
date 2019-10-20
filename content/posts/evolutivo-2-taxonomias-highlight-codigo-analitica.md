+++
date = "2019-10-18T12:33:32+02:00"
publishdate = "2019-10-18T12:33:32+02:00"
draft = true

title = "Evolutivo #2 - Taxonomías, highlighting de código y analítica"

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'tags', 'syntax highlighting', 'analytics', 'syntax highlighting', 'search console']

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

# Evolutivo #2 - Taxonomías, highlighting de código y analítica

**@TODO**

## Taxonomía de tags

**@TODO**

## Highlight de código

Desde un principio esta funcionalidad ha estado en el punto de mira, me encanta escribir snippets en mis posts, porque *talk is cheap, show me the code* es un mantra con el que me identifico.

Me gusta mucho como está implementado esto en Hugo, se puede considerar *server-side highlighting*, ya que a la hora de compilar tu contenido a HTML se utiliza [Chroma](https://github.com/alecthomas/chroma), una librería escrita en Go que analiza y aplica markup a tus snippets y luego a través de CSS puedes darles estilos.

En mi opinión esto es un acercamiento mucho más óptimo que al highlight en el cliente, como el de [highlight.js](https://highlightjs.org/) ya que además de no ocupar tiempo en el hilo de javascript analizando texto al vuelo, no habrá ningún parpadeo en el que el código salga sin estilos.

**@TODO**

## Analítica

Soy un *nerd* para los números y las gráficas, por lo que la parte de analítica iba a llegar más pronto que tarde. Por el momento he decidido utilizar tres fuentes de datos: Google Analytics, Search console y Cloudflare.

### Google Analytics

Google Analytics es una navaja suiza, con el conocimiento suficiente puedes hacer prácticamente lo que quieras en lo que recolección de datos se datos se refiere.

**@TODO**

### Search console

Search console te muestra datos de la indexación de tu web en Google, así como las datos

**@TODO**

### Cloudflare

Con Cloudflare no he tenido que hacer nada, ya estaba montado desde el principio como proxy de esta web, pero sigue teniendo una parte de analítica muy interesante, que está más orientada a los datos técnicos y son mucho más crudos que en el resto de plataformas ya que son recaudados a nivel DNS y proxy. 

Las partes más interesantes son:

**@TODO**

## Siguientes pasos

Para el siguiente evolutivo ya tengo bastante claro en que va a consistir, ya he empezado a trabajar (con mucha ayuda) en una mejora del workflow de desarrollo y redacción de contenido, vamos a crear un flujo con Docker y Makefiles, además también me voy a apuntar a la beta abierta de Github Actions y haremos algo de despliegue continuo. *Stay tuned!* 😎

## Wayback Machine

Ver la [versión original de este post](# "Versión original del post").

Ver la [versión original de la homepage](# "Versión original de la homepage").