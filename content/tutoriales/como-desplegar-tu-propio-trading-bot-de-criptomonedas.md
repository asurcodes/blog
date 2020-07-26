+++
draft = false
date = "2020-01-11T14:12:32+02:00"
publishdate = "2020-01-11T14:12:32+02:00"

title = "¿Cómo desplegar tu propio trading bot de criptomonedas? 💰"

description = "Aprende a desplegar tu propio trading bot para Bitcoin en la nube o en una Rapberry Pi utilizando la librería open source Gekko"

summary = "Parece que el boom de las **criptomonedas** ya ha pasado, pero hay gente que se sigue ganando la vida haciendo trading en plataformas online, vamos a ver como podemos automatizar este proceso desplegando un **trading bot** que compra y venda automáticamente basandose en unas reglas predefinidas con la librería open source de **Gekko**."

tags = ['Tutorial', 'Criptomonedas']

keywords = ['tutorial', 'criptomonedas', 'trading bot', 'gekko', 'javascript']

[amp]
    elements = ['amp-anim']

[author]
    name = "Asur Bernardo"
    homepage = "/"
    image="/images/me.jpg"
    bio="Back end developer sin ningún tipo de gusto estético. Me encanta la programación, el cacharreo y la tecnología en general. Siempre intento aprender cosas nuevas."

[image]
    src = "/images/how-to-deploy-your-own-crypto-trading-bot/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[alternatives.en]
    code = "en"
    url = "https://asur.dev/en/how-to-deploy-your-own-crypto-trading-bot/"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# ¿Cómo desplegar tu propio trading bot de criptomonedas?

{{< under-title >}}

Es posible que estés pensando:

> Asur, ¿las criptomonedas no son algo muy del 2018? 😕

Pues sí, pero eso no quita que mucha gente las siga utilizando para ganarse la vida mediante el trading.

La verdad es que en la mayoría de los casos, nosotros, los mortales, no tenemos las habilidades necesarias para conseguirlo, ya sea por un exceso de *trading emocional* o por falta de conocimientos del mercado y de análisis técnico.

¡Trading bots al rescate! Estos programas se encargan de observar los mercados y ejecutar compras y ventas automáticas basándose en una estrategia que tu les proporcionas.

{{< post-it
    type="tip"
    title="Disclaimer 🚨" >}}
Ten en cuenta que si ejecutas tu trading bot en producción te arriegas a perder dinero ¡Procede con precaución! 😬
{{< /post-it >}}

{{< toc >}}

## La plataforma Gekko

Gekko es un proyecto open source disponible en GitHub. Está escrito en NodeJS y es tanto un *Bitcoin Trading Bot* como una plataforma para hacer *backtesting*.

Hay varias cosas que me han hecho decantarme por esta plataforma:

 - Es Open Source 100% y permite que la gente colabore creando sus propias estrategias.
 - Tiene ya integración con las plataformas de trading de crypto más importantes.
 - Permite hacer *backtesting* (probar tu estrategia con periodos pasados para ver como se habría comportado).
 - Está hecho en JavaScript, que aunque no sea mi primer lenguaje me puedo sacar las castañas del fuego.

Todo esto lo puedes leer con más detalle en la [documentación de Gekko](https://gekko.wizb.it/docs/introduction/about_gekko.html), pero está en Inglés.

## Desplegar en una Raspberry Pi

Resulta que la idea de este proyecto me surgió investigando usos interesantes que se le podía dar a una Raspberry Pi, una de ellas era hostear un trading bot... 🤔

{{< post-it >}}
Estas instrucciones no se limitan a solo una Raspberry, solo necesitas una distribución de Linux basada en Debian, así que también puedes hacerlo en un VPS como <a href="https://www.linode.com/?r=ca90aa0a45540066ec753ff02b33a332d566e243" target="_blank" rel="nofollow noopener noreferrer" >Linode</a>, la idea es que siempre esté online.
{{< /post-it >}}

Me voy a saltar toda la parte de instalar de cero Raspian y conectarte por SSH, doy por sentado que si tienes una Raspy por casa alguna que otra vez ya te habrás visto en esta situación.

**¡Vamos a ello!**

Al buscar guías de instalación en la documentación nos encontramos con varias opciones, para un servidor Linux, para un PC con Windows... ¡y **Docker**! Bueno, está claro el camino que vamos a tomar ¿no? 🐋

{{<amp-gif
    alt="Docker nyan cat"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/docker-nyan-cat.gif"
    width="800"
    height="600"
    layout="responsive" >}}

Para empezar tenemos que instalar Docker CE y `docker-compose` en nuestro equipo:

{{< highlight sh >}}

# Instalar dependencias
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg2
# Añadir el repositorio de docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable"
# Actualizar referencias e instalar docker
sudo apt update && sudo apt install docker-ce
# Añadir tu usuario actual al grupo de docker
sudo usermod -aG docker $USER
# Probar que docker se ha instalado correctamente
docker -v
# Descargar el binario de docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose- \
    $(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Dar permiso de ejecución al binario de docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# Probar que docker-compose funciona correctamente
docker-compose --version

{{< / highlight >}}

Pues con esto ya lo tenemos casi todo hecho, ahora solo hay que clonar el repositorio y ejecutar su `docker-compose.yml`:

{{< highlight sh >}}

git clone https://github.com/askmike/gekko.git
cd gekko
docker-compose build
HOST=mydomain.com PORT=3001 docker-compose up -d

{{< / highlight >}}

Tengo un par de cosas que comentar de este último paso:

 1. Tanto si nuestro servidor está en nuestra NAT o en un VPS en el `HOST` tenemos que poner nuestra IP o dominio para poder acceder por la interfaz web.
 2. Si te has decantado por un VPS y quieres hacer trading real es **MUY** recomendable que habilites Basic Auth a través de un reverse proxy que se comunique con tu proceso de Docker.

## Cómo utilizar Gekko

Ya tenemos todo funcionando y no vamos a necesitar tocar más una terminal. Para a la interfaz web de Gekko navega a la IP y el puerto que hemos configurado durante la instalación.

Se ve algo así:

{{< amp-image
    alt="Gekko landing page"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-landing-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

¡Genial! Ahora vamos paso a paso... Gekko ya viene con algunas estrategias de trading comunes, lo primero que tenemos que hacer es un poco de backtesting a ver cual de ellas se podría comportar mejor con el estado del mercado actual.

Para descargarnos datos pasados del mercado podemos ir a `Local Data > Importer`

{{< amp-image
    alt="Gekko local data page"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-local-data-page.jpg"
    width="920"
    height="780"
    layout="responsive" >}}

Desde aquí podemos descargarnos los últimos 3 meses del provider que queramos, yo en mi caso uso *Binance*:


{{< amp-image
    alt="Gekko importer"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-importer-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

Hay que tener un poco de paciencia ya que son muchos datos y las APIs tienen *rate limiting*, lo bueno es que no necesitas que acabe para empezar con el testeo.

Para hacer pruebas, en la sección *Backtesting* podemos ahora ver nuestros datos, elegir la estrategia y ajustar los parámetros:

{{< amp-image
    alt="Gekko backtesting"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-backtest-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

Los parámetros de cada estrategia pueden variar, te recomiendo hacer una búsqueda rápida en Google para ver en que consiste y que significa cada una de las opciones. También puedes aprovechar e informarte sobre estrategias que haya hecho la comunidad, ¡hay de todo!

Una vez haya analizado los datos que le pases se te mostrará un resumen de las compras y ventas que se hubiesen ejecutado de haber sido en vivo.

Cuando tengas ajustada una estrategia con la que te sientas cómod@ puedes empezar a hacer pruebas live con *paper trading*, que es básicamente utilizar tu trading bot en modo simulado pero esta vez en *real time*.

{{< amp-image
    alt="Gekko live gekkos page"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-live-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

Pues ya estaría, si quieres dar el paso a real lo único que te falta por hacer es crear una cuenta en alguno de los *providers* soportados y en la sección `Config` añadir tus claves de su API.

## ¿Y ahora qué?

No espero sacar dinero con esto pero me viene muy bien para practicar tanto JavaScript como para refrescar y aprender conceptos de análisis técnico.

Quizás si encuentro algún marcador o estrategia que me llame especialmente la atención lo implemente y escriba un post al respecto. *Stay tuned!* 😜
