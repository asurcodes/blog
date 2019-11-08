+++
draft = true
date = "2019-11-09T11:27:32+02:00"
publishdate = "2019-11-09T11:27:32+02:00"

title = "#4 Nuevo dominio, nuevo layout y más AMP!"

description = "Sigo desarrollando el tema amperage, añadiendo botones para compartir en redes sociales, mejorando la integración del tema con AMP y haciendo más sencillo el layout para facilitar la lectura y mejorar la UX."

summary = "Sigo desarrollando el tema amperage, añadiendo datos estructurados de artículo para los posts y botones para compartir en redes sociales, mejorando la integración del tema con AMP y haciendo más sencillo el layout para facilitar la lectura y mejorar la UX."

tags = ['Evolutivo']

keywords = ['blog', 'desarrollo', 'amp', 'compartir', 'redes sociales', 'datos estructurados', 'artículo', 'UX', 'legibilidad']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = ""

[image]
    src = "https://asur.dev/images/nuevo-dominio-legibilidad-integracion-amp-scripts-share.png"
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

# Nuevo dominio, nuevo layout y más AMP!

{{% under-title %}}

Un nuevo lavado de cara del blog, no solo visual, sino que he cambiado el dominio! Atrás quedan los días de asurbernardo.com, un dominio largo y dificil de recordar, el nuevo dominio es asur.dev, algo mejor eh? Ah, y también he mejorado algunas cosas de AMP, pero que bonito mi nuevo dominio...

{{% toc %}}

## Nuevo dominio! 🌍

Este proceso ha sido un poco tedioso, con varios pasos para evitar que se desindexase alguna página...

 - DNS

 - Analítica

 - Redirects

 - GH Pages

## Mejora del layout 🧩

Con el objectivo de mejorar la lectura en todas las plataformas y aplicar un poco el paradigma de *mobile first* he simplificado la distribución.

El primer cambio y el más evidente es el eliminar la columna sticky de la derecha en desktop. La tabla de contenidos y los posts relacionados se han movido dentro del propio contenido.

El segundo es mover el autor y las tags debajo del título.

### Nuevo logo!

El último cambio es la creación de un logo. No tengo ni idea de diseño entonces lo único que he hecho es abrir InkScape y hacer pruebas con fuentes y colores.

## Mejorar integración de AMP con Hugo ⚡

Ahora llega la parte de AMP, con un par de cambios en Amperage para mejorar aun más la integración.

### Scripts configurables

Los scripts ahora son configurables por cada post, así solo se añaden los necesarios para cada caso, si quieres poner un video en el post pues añader el script pertinente.

Esto lo he hecho de la siguiente forma:

 1- 

### Botones de compartir en AMP

Al poner los metadatos del post debajo del título me faltaba algo para compartir, así que lo he añadido.

## Miscelanea 🧪

Un par de cosas extras que comentar.

### Estilos de tablas en markdown

Algunos temas de GoHugo se olvidan de que en markdown se pueden crear tablas y no les aplican ningún estilo, una auténtica lástima porque puede aportar mucho dinamismo al contenido. Por lo pronto he hecho algo muy sencillo pero para salir del paso llega:

```
| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |
```

se ve así:

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |

Si teneis que escribir muchas tablas en markdown por cualquier razón, os recomiendo [TablesGenerator](https://www.tablesgenerator.com/markdown_tables) o alguna página similar.

### Nuevas imágenes para compartir

Ahora que ya tengo botones de compartir creo que al menos hacer que se vea decente la tarjeta, así que he añadido unas imágenes 

## Siguientes pasos 👣

Para la próxima iteración, como comenté en el anterior post, no solo voy a integrar los datos estructurados de artículo, voy a añadir artículo, migas de pan, website y organización. Stay tuned! 😎

## Wayback Machine ⏰

Ver la [versión original de este post](# "Versión original del post").