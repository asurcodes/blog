+++
draft = false
date = "2019-11-14T21:08:32+02:00"
publishdate = "2019-11-14T21:08:32+02:00"

title = "¿Cómo compartir tu entorno local por internet con ngrok? 📡"

description = "Explico http tunneling, cómo exponer tu entorno local al internet, su funcionamiento y a usar ngrok, localtunnel y docker en nuestro proyecto"

summary = "¿Alguna vez te has preguntado como puedo hacer una demo a ese cliente sin un entorno de staging? La respuesta viene de la mano de **http tunneling**, una técnica que te permite compartir tu entorno local a internet. Vamos a averiguar cómo funciona, las diferentes herramientas disponibles y como utilizar la librerías **ngrok** y **localtunnel** en nuestros propios proyectos."

tags = ['Tutorial']

keywords = ['tutorial', 'http tunneling', 'ngrok', 'localtunnel', 'docker']

[amp]
    elements = ['amp-iframe']

[author]
    name = "Asur"
    image = ""
    bio = ""
    homepage = "/"

[image]
    src = "/images/como-compartir-tu-local-por-internet-con-localtunnel/share-card.jpg"
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

¿Alguna vez te has preguntado como puedo hacer una demo a ese cliente sin un entorno de staging? ¿O cómo puedo probar esos webhooks que estoy programando sin hacer un despliegue? La respuesta viene de la mano de **http tunneling**, una técnica que te permite compartir tu entorno local a internet.

Vamos a averiguar como funciona, las diferentes herramientas disponibles y como utilizar la librerías **ngrok** y **localtunnel** en nuestros propios proyectos.

{{% toc %}}

## ¿Qué es http tunneling y cómo funciona? 🕳️

El **http tunneling** es una técnica que te permite hacer links de red directos entre dos máquinas que normalmente no se podrían conectar debido a restricciones de Firewall, NAT, ACLs, etc.

Estos túneles requieren una máquina intermediaria (un *proxy*) que actúe de servidor. La máquina cliente se podrá conectar a este servidor a través de una llamada HTTP (normalmente con el verbo *HTTP CONNECT*), una vez establecida la única función del servidor es de proxy directo de TCP entre ambos extremos, quién realiza el request y el cliente del túnel.

## ¿Qué usos tiene el http tunneling? 📱

La teoría es maravillosa, queda super vistoso hablar de protocolos, clientes y servidores, pero lo mejor es la práctica, así que vamos a ver en que lodazales nos podemos meter para embarrarnos bien.

Todos estos casos de uso, aunque se aplican a tecnologías distintas, suelen girar alrededor del concepto de hacer accesible un entorno que está detrás de una NAT y/o un Firewall sin necesidad de desplegarlo a un servidor público.

### Exponer tu entorno local al internet para demos

Este es el caso de uso por excelencia y es en lo que se especializan varias de las librerias de las que vamos a hablar a continuación. 

Consiste en generar una url por la que se puede acceder al servidor de tunneling, este servidor consume datos del cliente y devuelve una respuesta HTTP, de esta manera podemos acceder al servidor como si estuviesemos viendo nuestro local, pero desde cualquier sitio que tenga acceso a internet.

{{< amp-image
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/demo-ngrok-cliente.jpg"
    alt="Esquema de ngrok describiendo una demo a un cliente"
    width="1200"
    height="678"
    layout="responsive" >}}

<br>

### Pruebas de webhooks desde local

Probar webhooks es también un caso bastante conocido, incluso los desarrolladores de aplicaciones como Slack recomiendan este workflow.

Las aplicaciones que soportan webhooks suelen requerir una url de la que consumir datos que sea accesible desde internet, al levantar un túnel puedes configurar la url que te proporciona y hacer cambios en tiempo real (con ngrok incluso puedes lanzar request custom desde su GUI).

{{< amp-image
    alt="Esquema de ngrok describiendo un testeo de webhooks"
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/demo-ngrok-webhooks.jpg"
    width="750"
    height="422"
    layout="responsive" >}}

<br>

### Pruebas de API en apps o aparatos IOT

Prácticamente todas las aplicaciones dinámicas y aparatos IOT requieren algún tipo de API de la que consumir datos, para hacer pruebas en tiempo real mientras se desarrolla puedes configurar el endpoint de tu túnel en tu consumidor y ponerte a testear.

{{< amp-image
    alt="Esquema de ngrok describiendo un testeo de API en aparatos IOT"
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/demo-ngrok-iot.jpg"
    width="1200"
    height="800"
    layout="responsive" >}}

<br>

### Otras ideas...

Como veis solo hay que echarle originalidad, seguro que hay muchas más aplicaciones que se me escapan pero estas son algunas extra que se me han ido ocurriendo:

 - Acceder a tu app a través de https cuando tu local tan solo soporta http.

 - Pruebas de responsive reales en distintos teléfonos móviles físicos.

 - Probar entornos de cloud en local (un AWS SQS por ejemplo).

 - Crear un cluster con Minikube y utilizarlo como uno de Kubernetes normal.

## ¿Qué herramientas hay de http tunneling? ⚒️

Ahora que ya hemos visto algún caso de uso y hemos echado a andar la imaginación, vamos a ver de que herramientas disponemos para llevar a cabo nuestra idea:

### Ngrok - secure introspectable tunnels to localhost

Ngrok es quizás el nombre más reconocible en esta materia, es un SaaS que tiene la facilidad de uso por bandera. Sus características son las siguientes:

**Pros**

 - Binario descargable para multitud de plataformas, rápido montaje.

 - Capa gratuita de servidores SaaS.

 - Cuenta con una GUI web en la que puedes analizar los request y hacer respuestas custom.

 - Posibilidad de acceder a un dashboard con analítica si te registras en su web.

 - Al ser un negocio te asegura el mantenimiento y futuras actualizaciones.

**Contras**

 - No es Open Source, al menos la nueva versión 2.x, aún se puede encontrar [la antigua versión en Github](https://github.com/inconshreveable/ngrok), aunque no está mantenida.

 - No tiene la opción de montar tu propio servidor.

 - La capa gratuita en sus servidores es algo limitada, es evidente que buscan la conversión.

### Localtunnel - expose yourself

Aunque su eslogan se puede malinterpretar facilmente, localtunnel es el proyecto open source más reconocible de http tunneling y lleva desde el 2012 siendo desarrollado y mantenido. Es la alternativa más frecuente a ngrok y no sin razón:

**Pros**

 - Es Open Source, tanto el cliente como el servidor.

 - Capa gratuita de servidores SaaS.

 - Gran comunidad y muy asentada, con más de 9K estrellas en Github.

**Contras**

 - Puede ser algo más lento que el resto al estar escrito en Nodejs, pero para la mayoría de casos de uso ni se nota.

Repositorio: https://github.com/localtunnel/localtunnel

### Chisel - A fast TCP tunnel over HTTP

El nuevo de la clase, se promociona como una herramienta de http tunneling rápida y segura. Con más de 3K estrellas en Github parece que ha convencido a los usuarios, lamentablemente aún no lo he podido probar, pero su rápido crecimiento es prueba más que suficiente de que merece la pena darle una oportunidad.

**Pros**

 - Es Open Source, puedes ver el código en Github, tanto el cliente como el servidor.

 - Es rápido, está escrito en Go.

 - Facilidad de uso.

 - Dockeriación oficial.

**Contras**

 - No tiene servidores *as a service*, te lo tienes que montar tu todo.

Repositorio: https://github.com/jpillora/chisel

## ¿Cómo utilizar ngrok en tu proyecto web? 👩‍🏭

Nos ponemos manos a la obra, al final me he decantado por publicar mi webapp al internet utilizando ngrok porque al proporcionar un binario descargable es muy fácil y rápido, ni siquiera requiere instalación. El proceso a seguir es el siguiente:

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

La consola nos mostrará todos los datos de nuestro nuevo túnel, con ambos links para entrar a nuestro túnel, tanto http como https. Pinta algo así:

{{< amp-image
    alt="Output de consola del cliente de ngrok"
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/ngrok-output-consola.jpg"
    width="1970"
    height="932"
    layout="responsive" >}}

Listo, ya podemos compartir el link con quien queramos que acceda a nuestra máquina para hacer una demostración.

Ngrok ofrece una GUI para analizar los requests que llegan a tu servidor, e incluso hacer respuestas custom a cada uno. Normalmente es accesible desde tu navegador en `localhost:4040`. Esto puede ser muy útil en el caso de que estés probando una API, webhooks o *IOT devices* y necesitas hacer una request en concreto sin tener que picar código.

En la web oficial también hay analítica y un dashboard, pero para eso hay que registrarse, puedes ver como configurarlo todo en su documentación oficial.

**OJO**: La capa gratuita de ngrok es bastante limitada, para hacer pruebas en una web sencilla sin muchos subrequest funciona perfectamente, si lo necesitas para algo más complejo o en un entorno profesional quizás te merezca la pena pagar por un plan premium.

## Setup alternativo con localtunnel y docker 🐳

Está muy bien eso de instalar globalmente una herramienta o descargarte un binario, pero yo soy mucho más fan de utilizar contenedores para mi workflow, así que he estado haciendo pruebas con docker a ver si se puede integrar localtunnel y ha resultado que si!

Ya tengo un [entorno dockerizado para este mismo blog](https://asur.dev/metablogs/mejorando-workflow-docker-makefile-github-actions/#dockerizando), así que lo he aprovechado para hacer pruebas.

He encontrado una [imagen de docker](https://hub.docker.com/r/efrecon/localtunnel) que es genial, pesa solo 20Mb y tiene más de 1 millón de descargas, así que el 90% del trabajo ya está hecho, la comunidad de docker es una pasada!

Lo podemos hacer todo desde el `docker-compose.yml`, no hace falta ni siquiera tocar la parte que ya estaba hecha, tan solo añadir el nuevo servicio:

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
    depends_on:
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

## Presentación en diapositivas

He hecho una presentación sobre este tema recientemente, dejo por aquí las diapositivas por si alguien les quiere echar un vistazo o las quiere reutilizar:

{{< amp-iframe
    sandbox="allow-scripts allow-same-origin"
    src="https://slides.com/asurbernardo/como-exponer-tu-local-a-internet-con-http-tunneling/embed"
    width="576"
    height="420"
    layout="responsive" >}}