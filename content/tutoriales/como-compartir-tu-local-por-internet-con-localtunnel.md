+++
draft = true
date = "2019-11-17T16:12:32+02:00"
publishdate = "2019-11-17T16:12:32+02:00"

title = "¿Cómo compartir tu entorno local por internet con ngrok?"

description = "Explico http tunneling, una técnica que te permite exponer tu entorno local al internet, como funciona, las diferentes herramientas disponibles y como utilizar ngrok para nuestros propios proyectos."

summary = "¿Alguna vez te has preguntado como puedo hacer una demo a ese cliente sin un entorno de staging? La respuesta viene de la mano de **http tunneling**, una técnica que te permite exponer tu entorno local al internet. Vamos a averiguar como funciona, las diferentes herramientas disponibles y como utilizar la librería **ngrok** para nuestros propios proyectos."

tags = ['Tutorial']

keywords = ['tutorial', 'http tunneling', 'ngrok', 'loclatunnel', 'docker']

[amp]
    elements = []

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = ""

[image]
    src = "https://asur.dev/images/demo-ngrok-webhooks.jpg"
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

# ¿Cómo compartir tu entorno local por internet?

{{% under-title %}}

¿Alguna vez te has preguntado como puedo hacer una demo a ese cliente sin un entorno de staging? ¿O cómo puedo probar esos webhooks que estoy programando sin hacer un despliegue? La respuesta viene de la mano de **http tunneling**, una técnica que te permite compartir exponer tu entorno local a internet. Vamos a averiguar como funciona, las diferentes herramientas disponibles y como utilizar la librería **ngrok** para nuestros propios proyectos.

{{% toc %}}

## ¿Qué es http tunneling y cómo funciona? 🕳️

El **http tunneling** es una técnica que te permite hacer túneles http, valga la redundancia, que son links de red directos entre dos máquinas en condiciones que normalmente no se podrían hacer debido a restricciones de Firewall, NAT, ACLs, etc.

Estos túneles requieren que una máquina intermediaria (un *proxy* vamos) que actúe de servidor.

La máquina cliente se podrá conectar a este servidor,  la única llamada HTTP que se lanzará es la de conexión (normalmente con el verbo *HTTP CONNECT*), luego lo único que hace el servidor es un proxy directo de TCP.

## ¿Qué usos tiene el http tunneling? 📱

La teoría es maravillosa, queda super vistoso hablar de protocolos, clientes y servidores, pero lo mejor es la práctica, así que vamos a ver en que lodazales nos podemos meter para embarrarnos bien.

**Exponer tu entorno local a internet para demos**

<amp-img class="post__image"
    alt="Esquema de ngrok describiendo una demo a un cliente"
    src="/images/demo-ngrok-cliente.jpg"
    width="1200"
    height="678"
    layout="responsive">
</amp-img>

**Pruebas de consumidores de webhooks en local**

 <amp-img class="post__image"
    alt="Esquema de ngrok describiendo un testeo de webhooks"
    src="/images/demo-ngrok-webhooks.jpg"
    width="750"
    height="422"
    layout="responsive">
</amp-img>

**Pruebas de API en apps o aparatos IOT**

 <amp-img class="post__image"
    alt="Esquema de ngrok describiendo un testeo de API en aparatos IOT"
    src="/images/demo-ngrok-iot.jpg"
    width="1200"
    height="800"
    layout="responsive">
</amp-img>


**Otras ideas...**

Se me ocurren alguna otra idea aplicable a esta tecnología como pruebas de responsive reales en distintos móviles físicos, probar entornos de cloud en local (un AWS SQS por ejemplo) y seguro que muchas más que se me escapan pero de momento creo que ya tenemos para un rato.

**@TODO** Completar cada caso de uso con una descripción

## ¿Qué herramientas hay de http tunneling? ⚒️

Ahora que ya hemos elegido nuestro caso de uso, vamos a ver que herramientas podemos usar para llevarlo a cabo:

### Localtunnel - expose yourself

https://github.com/localtunnel/localtunnel

### Ngrok - secure introspectable tunnels to localhost

https://github.com/inconshreveable/ngrok

**@TODO** Añadir descripción breve y pros y contras de cada uno

## ¿Cómo utilizar ngrok en tu proyecto? 👩‍🏭

Nos ponemos manos a la obra, al final me he decantado por exponer mi local a internet utilizando ngrok porque como binario descargable es más directo. El proceso a seguir es el siguiente:

Nos descargamos el zip con el código de la web oficial:

```
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
```

Extraemos los ficheros:

```
unzip ngrok-stable-linux-amd64.zip
```

Ejecutamos el comando especificando el procolo y el puerto de escucha:

```
./ngrok http 80
```

En la se nos mostrará un output con todos los datos de nuestro nuevo túnel, pinta algo así:

<amp-img class="post__image"
    alt="Output de consola del cliente de ngrok"
    src="/images/ngrok-output-consola.jpg"
    width="1970"
    height="932"
    layout="responsive">
</amp-img>

Listo, ya podemos compartir el link con quien queramos que acceda a nuestra máquina.

Ngrok ofrece una GUI para analizar los requests que llegan a tu servidor, e incluso hacer respuestas custom a cada uno. Esto puede ser muy útil en el caso de que estés probando una API, webhooks o *IOT devices*.

**EXTRA:** En la web oficial también hay analítica y un dashboard, pero para eso hay que registrarse, puedes ver como configurarlo todo en la documentación oficial.

## Setup alternativo con localtunnel y docker 🐳

Está muy bien eso de instalar globalmente una herramienta, pero yo soy mucho más fan de los contenedores, así que he estado haciendo pruebas con docker a ver si se puede configurar y ha resultado que si!

Ya tengo un [entorno dockerizado para este mismo blog](https://asur.dev/metablogs/mejorando-workflow-docker-makefile-github-actions/#dockerizando), así que lo he aprovechado para hacer pruebas.

He encontrado una [imagen de docker](https://hub.docker.com/r/efrecon/localtunnel) que es genial, pesa solo 20Mb y tiene más de 1M de descargas, así que el 90% del trabajo ya está hecho, la comunidad de docker es una pasada!

Lo podemos hacer todo desde el `docker-compose.yml`, no hace falta ni siquiera tocar la parte que ya estaba hecha.

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

  # 🡣 Nuevo contenido 🡣

  localtunnel:
    image: efrecon/localtunnel
    links:
      - web
    command:
      --local-host web --port 1313

{{< / highlight >}}

Vamos a ver que se hace en cada paso:

 - **Línea 13:** Declaramos el nuevo servicio de localtunnel.

 - **Línea 14:** Especificamos la imagen que vamos a usar en este servicio, en este caso `efrecon/localtunnel`, que está alojada en DockerHub.

 - **Línea 15-16:** Linkeamos el servicio de tunneling con el servidor web para que sean conscientes el uno del otro y se puedan comunicar por la red por defecto.

 - **Línea 17-18:** Lanzamos el comando de localtunnel especificando la dirección y el puerto del servicio web.

Y eso es todo, al lanzarlo se nos inicia un cliente de localtunnel listo para usar como en el paso anterior, pero sin instalar software en tu equipo, mucho mejor!