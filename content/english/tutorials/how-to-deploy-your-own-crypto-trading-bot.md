+++
draft = false
date = "2020-01-11T14:12:32+02:00"
publishdate = "2020-01-11T14:12:32+02:00"

title = "How to deploy your own cryptocurrency trading bot? 💰"

description = "Learn how to deploy your own Bitcoin trading bot on the cloud or on a Raspberry Pi using the open source platform Gekko"

summary = "It seems like the *crypto boom* is far gone, but there's still people making a living from online cryptocurrency trading. Let's find out how we can automatize this proccess deploying a **trading bot** that buys and sells by it self based on predefined strategies using the **Gekko** platform."

tags = ['Tutorial']

keywords = ['tutorial', 'cryptocurrency', 'trading bot', 'gekko', 'javascript']

[amp]
    elements = ['amp-anim']

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = "/images/how-to-deploy-your-own-crypto-trading-bot/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[alternatives.es]
    code = "es"
    url = "https://asur.dev/como-desplegar-tu-propio-trading-bot-de-criptomonedas/"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# How to deploy your own cryptocurrency trading bot?

{{% under-title %}}

You might be thinking:

> Asur, cryptocurrency is so 2018... 😕

I agree, but still many people are making a living out of online cryptocurrency trading, and I would like to give it a go too.

The truth is that in most cases, us, mere mortals, don't have the skills necessary to make it due to an excess of emotional trading or a lack of knowledge on technical analysis.

¡Trading bots to the rescue! This programs watch the markets and execute orders automatically based on a given strategy.

{{% post-it
    type="tip"
    title="Disclaimer 🚨" %}}
Take into consideration that real trading might cause you to lose money. Proceed with caution! 😬
{{% /post-it %}}

{{% toc %}}

## The Gekko project

Gekko is an open-source project available on GitHub. It's written in NodeJS and it's a Bitcoin trading bot manager and a backtesting platform.

Several things that made me choose Gekko:

 - It's 100% open source, that allows people to collaborate to the platform and create new bot strategies.
 - It's integrated with the most well-known crypto broker platforms.
 - It allows you to make backtesting (trying your strategy with past market data to check how it would have performed)
 - It's made with JavaScript, which might not be my main language, but I can find my way around it.

You can read more about these features in [Gekko's official documentation](https://gekko.wizb.it/docs/introduction/about_gekko.html).

## Deploy it on a Raspberry Pi

I was browsing the internet for cool and useful ways to use a Raspberry Pi I had lying around the house, one of those uses was to host a trading bot... 🤔

{{% post-it %}}
This set of instructions are not only meant for a Raspberry Pi, you just need a Debian based Linux distro, so you could use a VPS like <a href="https://www.linode.com/?r=ca90aa0a45540066ec753ff02b33a332d566e243" target="_blank" rel="nofollow noopener noreferrer" >Linode</a> too.
{{% /post-it %}}

I'm going to omit the whole Raspbian  and SSH setup, I assume if you are the proud owner of a Raspi you have done this before.

**¡Let's get to it!**

Looking for installation guides on the documentation I found several options, manually install all the dependencies in a Linux server, on a Windows PC... and Docker! Well, it's clear the path we are taking, isn't it?

{{<amp-gif
    alt="Docker nyan cat"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/docker-nyan-cat.gif"
    width="800"
    height="600"
    layout="responsive" >}}

To get started we need Docker CE and `docker-compose` installed in our machine:

{{< highlight sh >}}

# Install dependencies
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg2
# Add docker official repository to apt
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable"
# Update apt references and install Docker CE
sudo apt update && sudo apt install docker-ce
# Add your current user to the docker group
sudo usermod -aG docker $USER
# Test docker is installed correctly
docker -v
# Download docker-compose binary
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose- \
    $(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Give execution permissions to docker-compose binary
sudo chmod +x /usr/local/bin/docker-compose
# Test docker-compose is installed correctly
docker-compose --version

{{< / highlight >}}

With the installation out of the way we are almost done, now we only need to clone the Gekko repository and build its docker image.

{{< highlight sh >}}

git clone https://github.com/askmike/gekko.git
cd gekko
docker-compose build
HOST=mydomain.com PORT=3001 docker-compose up -d

{{< / highlight >}}

A couple of thing about the steps above:

 1. It doesn't matter if our server is behind a NAT or it's a VPS, we need to provide our server IP in the `HOST` parameter if we want to use the web GUI.
 2. If you finally decided to use a VPS and you want to trade real Bitcoin you must set up at least a basic auth with a reverse proxy to secure it against scanners.

## How to use Gekko

Now that everything is up and running we won't need to use a terminal anymore. To access the Gekko web interface browse to the IP and port you set up on the `docker-compose up` command.

The web landing page looks like this:

{{< amp-image
    alt="Gekko landing page"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-landing-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

Cool! Now let's go step by step on how to get our bot trading.

Gekko already provides some common trading strategies based on different technical indicators, the first thing to do is backtest these strategies to see how they would have behaved with the current state of the market.

But first, we need to download the past market data, for that we navigate to `Local Data > Importer`:

{{< amp-image
    alt="Gekko local data page"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-local-data-page.jpg"
    width="920"
    height="780"
    layout="responsive" >}}

From this page we can download all the data we need from any provider, I downloaded the last 3 months from Binance:

{{< amp-image
    alt="Gekko importer"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-importer-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

You will need to have some patience, this is a big amount of data and APIs are rate limited, but you don't need to wait for it to finish, you can start backtesting now. To do so, in the menu option *Backtesting* you will  have your downloaded data available, now you have to choose your strategy and set its parameters:

{{< amp-image
    alt="Gekko backtesting"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-backtest-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

Every strategy can have different parameters, I would recommend you to make a quick Google search to read about the strategy you are testing and what its parameters mean. You can also find strategies made by the community, there are a ton, from really basic examples to machine learning models!

Once you click on backtest it will start analyzing the data and when it finishes will show you a summary of the operations it would have performed in that period if that strategy would have been running.

After some parameters tweaking and testing multiple periods, you can launch a live paper trading bot, this is also for testing purposes, but this time is on real-time.

{{< amp-image
    alt="Gekko live gekkos page"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/gekko-live-page.jpg"
    width="1280"
    height="1280"
    layout="responsive" >}}

And that's it! If you want to make the ultimate step, you just need to register in one of the supported providers and set up its API keys on the `Config` section. Have fun!

## And now what?

I don't expect to make money from this but I consider it a cool exercise to practice some JavaScript and learn a bit more about technical analysis.

Maybe if I can think of an interesting strategy I will implement it and write a post about it. *Stay tuned!* 😜