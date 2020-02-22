+++
draft = false
date = "2020-02-21T12:47:23+02:00"
publishdate = "2020-02-21T12:47:23+02:00"

title = "Los transistores, las neuronas de un procesador"

description = "Los microprocesadores están en todo lo que requiera una mínima cantidad de procesamiento, hay una CPU desde microcontroladores Arduino hasta superordenadores, ¿pero en realidad cómo funcionan por dentro y cómo se hacen?"

summary = "Los procesadores dominan la sociedad actual, hoy en día están por todas partes, desde microcontroladores como Arduino, pasando por el portatil en el que estoy escribiendo esto, hasta llegar a enormes sistemas distribuidos de cómputo ¿Pero cómo funcionan en realidad y de que están hechos?"

tags = ['Ciencia']

keywords = ['blog', 'ciencia', 'transistores', 'cpu', 'procesadores']

[amp]
    elements = []

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

[image]
    src = "/images/los-transistores-las-neuronas-de-un-procesador/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# Los transistores, las neuronas de un procesador

{{% under-title %}}

Los procesadores dominan la sociedad actual, hoy en día están por todas partes y todo lo que requiera una mínima cantidad de procesamiento contiene una (o varias) unidades de procesamiento, desde microcontroladores como Arduino, pasando por el portatil en el que estoy escribiendo esto, hasta llegar a enormes sistemas distribuidos de cómputo.

Pero nunca me había parado a observar estos aparatos que han pasado a gobernar nuestras vidas en pocas décadas hasta hace relativamente poco, que leí la noticia de que TSMC (Taiwan SemiConductors) había iniciado el proceso de fabricación de transistores de 5nm.

Me picó el interés y me puse a investigar, llevándome por una madriguera profunda a la par que interesante y me pareció un desperdicio no compartir todo lo que he aprendido.

En el futuro hablaré sobre más temas como que nos depara el futuro de los procesadores, pero de momento vamos a empezar por el principio, los transistores.

## ¿Qué son los transistores?

Los transis... ¿qué? Los transistores, la materialización del dicho de que lo sencillo no tiene por qué significar fácil.

Con un nombre así se les da un aire de grandeza, cuando en realidad son el mecanismo más sencillo de la electrónica, una puerta binaria, un interruptor glorificado, llámalo como quieras, pero su función no es otra que producir los unos y ceros que hacen que nuestros ordenadores puedan realizar operaciones básicas.

Cuando el transistor está abierto deja pasar corriente, lo que la máquina interpreta como un 1 y si está cerrado y no pasa electricidad lo considera un 0, generando así bits.

¿Pero cómo una máquina puede hacer operaciones tan complejas como un ordenador solo con ceros y unos? Prácticamente todo se puede reprensentar con unos y ceros, mientras cuentes con la escala suficiente, y la respuesta es esa, la **escala** a la que se hace.

{{< amp-image
    alt="Un transistor escaneado con un microscopio electrónico"
    src="/images/los-transistores-las-neuronas-de-un-procesador/transistors-ibm.jpeg"
    width="1280"
    height="720"
    layout="responsive" >}}

Los transistores son imposiblemente pequeños e increiblemente rápidos, por hacernos una idea con un tamaño de 5 nanómetros hoy en día se puede alcanzar una densidad de **170 millones** por milímetro cuadrado. No solo eso, si no que son capaces de alcanzar frecuencias de reloj del orden de **5x10^9 operaciones por segundo** (5 GHz) cada uno. Todo esto nos da una escala dificil de imaginar para el cerebro humano.

## ¿Cómo se fabrican los transistores?

Probablemente te estés preguntando cómo se fabrican los transistores, que máquina hay en el mundo que pueda trabajar a una escala no solo microscópica sino atómica. Lo cierto es que esa máquina no existe. La verdad es que los días en los transistores se fabricaban mecánicamente han quedado muy atrás. La solución actual es **química**.

Seguro que te suena el silicio, además uno de los elementos más abundantes de la corteza terrestre es también un **semiconductor**, y es la base sobre la que se fabrican prácticamente todos los microchips del mundo.

{{% post-it type="info" title=" 💡 Sabías qué... " %}}
Un átomo de silicio mide 0.2 nanómetros, esto quiere decir que en su parte más ancha **un transistor moderno tiene apróximadamente 30 átomos de ancho.**
{{% / post-it %}}

El hecho de tener que elegir semiconductores para la electrónica se debe a que sus propiedades a temperatura ambiente **se encuentran en el punto medio ideal entre un material conductivo y uno aislante**, porque si conduce demasiado bien la corriente sería complicado apagarlos, y por el contrario si aisla en exceso que los electrones fluyan correctamente es difícil. La idea es que a los semiconductores puedes transformarlos en un tipo u otro con distintos aditivos, lo que los hace la base perfecta para trabajar.

La primera tarea es crear un cristal de silicio lo más puro posible, esto se consigue mediante un proceso llamado el [método Czochralski](https://en.wikipedia.org/wiki/Czochralski_method), una manera de conseguir cristales con una pureza del 99.9999% mediante [crecimiento cristalino](https://en.wikipedia.org/wiki/Crystal_growth).

{{< amp-image
    alt="Esquema del método Czochralski"
    src="/images/los-transistores-las-neuronas-de-un-procesador/czochralski-process.svg"
    width="800"
    height="400"
    layout="responsive" >}}

Una vez se forma un cilindro, este se corta en discos de menos de un milímetro, se pulen mecánicamente y después con una serie de ácidos hasta que llega a ser una oblea perfectamente lisa.

{{% post-it type="info" title=" 💡 Sabías qué... " %}}
Los *wafers* de silicio son una de las superficies más planas hechas por el hombre, con un índice de rugosidad menor a 0.1 nanómetros.
{{% / post-it %}}

Con el material ya listo se pasa al proceso de impresión, por ejemplo, el más actual, la **litografía con luz ultravioleta**, donde se impregna la placa de silicio con un material fotosensible, se expone a la luz cubriéndolo con una plantilla translúcida y el reactivo forma los componentes al verse expuesto al haz luminoso.

En las distintas capas de impresión se le introducen *impurezas* al silicio por un proceso llamado *doping*, como átomos de boro y fósforo para crear exceso o carencia de electrones en sus vículos moleculares, promoviendo así el flujo de electrones entre estas.

{{% post-it type="info" title=" 💡 Sabías qué... " %}}
Que se usen rayos UV en el proceso de fabricación no es por capricho, se debe a que la longitud de onda del espectro visible es demasido grande para ser capaz de "tallar" componentes tan pequeños con el suficiente detalle.
{{% / post-it %}}

Esto finalmente produce pequeñas impresiones tridimensional en la superficie de silicio que, tras ser recortadas, ya están listas para conectarse a un sustrato o PCB para su posterior uso.

### ¿Por qué el tamaño de los transistores ya no es tan importante?

Históricamente los transistores eran componentes planos que se imprimian de una manera u otra en una placa de silicio por reacciones químicas como he comentado antes.

Sus tamaños eran estandar y siempre se reducian por un factor de 0.7 cada generación. Partiendo de los 90nm se pasaron a los 65nm, después a los 45, 32, 22, etc, hasta llegar a los 5nm que en la actualidad es el tamaño más pequeño en fabricación (se prevee que los 3nm lleguen para 2021).

Esta progresión se debe a una profecía autocumplida por la industria: la **ley de Moore**, pues si cada año se reduce el tamaño del transistor por un factor de 0.7, ¿adivina que? ¡cada dos años el tamaño de los transistores se reduce a la mitad!

{{% post-it type="info" title=" 💡 Sabías qué... " %}}
La **ley de Moore** expresa que aproximadamente cada dos años se duplica el número de transistores en un microprocesador.
{{% / post-it %}}

{{< amp-image
    alt="Evolución en la cantidad de transistores por año - Ley de Moore"
    src="/images/los-transistores-las-neuronas-de-un-procesador/moores-law-transistor-count.svg"
    width="1280"
    height="900"
    layout="responsive">}}

El problema viene a partir de 2010, cuando se empezó a comercializar una nueva arquitectura de transistores: **FinFET**. Es un tipo de transistor que que permite aumentar considerablemente la densidad y eficiencia energética, pero hace dificil el mantener una medida estandar, por no hablar de la complejidad de sostener una progresión arbitraria cuando los tamaños se están haciendo tan diminutos.

Por esto los fabricantes comenzaron a utilizar el término de los nanómetros de sus transistores como algo más orientado al consumidor para indicar un relevo generacional en vez de como una medida física objetiva.

{{< amp-image
    alt="Densidad de transistores por fabricante y proceso de fabricación"
    src="/images/los-transistores-las-neuronas-de-un-procesador/transistors-density.png"
    width="1280"
    height="600"
    layout="responsive">}}

Para apreciar esta diferencia solo hay que ver la delta de densidad entre fabricantes cuando sus transistores son *del mismo tamaño*. Por ejemplo el proceso de 5nm Samsung produce 120 millones de transistores por milímetro cuadrado cuando TSMC llega hasta los 170, ¡casi un 50% más!

Así que no te dejes influenciar por el marketing de los GHz de una CPU comercial ni con los nanómetros de sus transistores, porque son solo factores individuales que influyen en el rendimiento final de un procesador.