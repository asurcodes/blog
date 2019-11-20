+++
draft = false
date = "2019-11-24T11:27:32+02:00"
publishdate = "2019-11-24T11:27:32+02:00"

title = "Metablog #5 - Sistema de comentarios y datos estructurados"

description = "Despliego un sistema de comentarios con remark en GCP Compute engine y añado datos estructurados a mi blog de tipo artículo, carrusel, migas de pan y website"

summary = "He estado cacharreando con Google Cloud Platform y he desplegado un **sistema de comentarios** dockerizado en Compute engine utilizando la capa gratuita, también le doy otro empujon al SEO técnico añadiendo **datos estructurados** en toda la web del tipo website, carousel, migas de pan y blog posting."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'comentarios', 'remark', 'GPC', 'Compute engine', 'SEO', 'datos estructurados', 'breadcrumbs', 'website', 'carousel']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = ""

[image]
    src = "/images/sistema-de-comentarios-gcp-y-datos-estructurados.jpg"
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

# Sistema de comentarios y datos estructurados

{{% under-title %}}

Vuelvo una semana más al formato metablog, creo que hay novedades que merece la pena comentar!

He estado cacharreando con Google Cloud Platform y he desplegado un **sistema de comentarios** dockerizado en Compute engine utilizando la capa gratuita. 

También he avanzado otro poco con el SEO técnico añadiendo **datos estructurados** en toda la web del tipo website, carousel, migas de pan y blog posting.

{{% toc %}}

## Sistema de comentarios 🦜

Estaba claro que todo blog necesita un buen sistema de comentarios para que la gente se queje de tu contenido.

Por supuesto no voy a ser menos que el resto de la blogosfera así que me he puesto con ello.

Pero no he usado Disqus, no, no, no, esa sería la opción fácil que me permitiría conservar la cordura. He decidido no utilizar un Saas si no que me lo he montado todo yo solito en GCP.

Al principio pensé en empezar a usar [Commento](https://commento.io/), que no solo es un servicio, si no que es open source así que le di una oportunidad... mala idea!

Parece que la última versión tiene un bug, que si lo configuras para usar `https` la página padre si que se pide por el protocolo correcto pero sus subrequest son todos `http`, generando un montón de errores por *mixed content* en el navegador.

## Datos estructurados 🧱

Los datos estructurados son una de las cosas más comunes que se suelen implementar para mejorar el SEO desde la parte técnica.

No dejan de ser una serie de *json scripts* que se añaden a tu página para facilitar el crawleo al bot de Google. Puedes ver los ejemplos más comunes en [jsonld.com](https://jsonld.com).

La gracia de esto es que Google y otros motores de búsqueda favorecen a las páginas que los tienen, no solo en posicionamiento directo, si no que tienes la posibilidad de que tu resultado se muestre como enriquecido, algo que aumenta significativamente el CTR.

Hay algún dato estructurado más que podría añadir pero creo que en esfuerzo/beneficio estos son los mejores:

### Dato estructurado de Website

Los datos estructurados de Website se añaden en la **solo** en homepage de tu web.

### Dato estructurado de Breadcrumbs

Los datos estructurados de Breadcrumb, también llamados de navegación son unas migas de pan que ordenan jerarquicamente el path de una página.

### Dato estructurado de BlogPost

Los datos estructurados de BlogPost son un subtipo de Artículo que, como su nombre indica se usan en un blog.

### Dato estructurado de Carousel

Los datos estructurados de Carousel se utilizan para en páginas de listado de artículos, productos, cursos...

## Siguientes pasos 👣

Tengo un proyecto en proceso muy muy chulo del que voy a hacer un post en detalle, quizás no un tutorial pero algo más documental describiendo lo que he hecho, creo que los voy a llamar *megapost*. Stay tuned! 😎

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").