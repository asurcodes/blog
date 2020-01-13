+++
draft = false
date = "2019-11-14T21:08:32+02:00"
publishdate = "2019-11-14T21:08:32+02:00"

title = "How to share your local on the internet with Ngrok? 📡"

description = "Learn the basis of http tunneling, how to expose your local environment to the internet and how to use ngrok and localtunnel with docker in your project"

summary = "Have you ever wondered how to show that client your amazing demo with no staging environment? The answer is **HTTP tunneling**, this technique allows you to share your local development server on the internet. Let's find out how it all works, the different tools available and how to use **ngrok** or **localtunnel + docker** on your own projects."

tags = ['Tutorial']

keywords = ['tutorial', 'http tunneling', 'ngrok', 'localtunnel', 'docker']

[amp]
    elements = []

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = "/images/como-compartir-tu-local-por-internet-con-localtunnel/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[alternatives.es]
    code = "es"
    url = "https://asur.dev/como-compartir-tu-local-por-internet-con-localtunnel/"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"

+++

# How to share your local on the internet with Ngrok?

{{% under-title %}}

Have you ever wondered how to show that client your amazing demo with no staging environment? Or maybe how to test those webhooks I'm programming without a deploy? The answer is **HTTP tunneling**, this technique allows you to share your local development server on the internet.

Let's find out how it all works, the different tools available and how to use **Ngrok** or **Localtunnel with docker** on your own projects.

{{% toc %}}

## What is HTTP tunneling and how does it work? 🕳️

**Http tunneling** is a technique that allows you to make direct network links between two machines which normally wouldn't be able to be connected due to restrictions like firewalls, NATs, ACLs, etc.

These tunnels require a proxy to act as a server. The client will connect to the server making an HTTP request (normally using the verb *HTTP CONNECT*), once the handshake is done and the connection established  the only thing the server does is to directly proxy TCP request between the final objective of the request and the tunnel client.

## What are HTTP tunnels used for? 📱

All that theory is amazing and it looks great to talk about protocols, clients and servers, but everything is useless if it isn't put to good use, so let's find out how can we do it.

All of these showcases, while they are applied to very different technologies they are all based around the same concept: make an environment behind a NAT or firewall accessible with no deploy required.

### Expose your local environment for demos

This is the use case par excellence, it consists on generating a URL to access the tunneling server, this server consumes requests, communicates with the client and it returns an HTTP response, this way we can access our local environment through the server, and as the server is public anyone can access our local setup.

{{< amp-image
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/demo-ngrok-cliente.jpg"
    alt="Ngrok flow describing a demo for a client"
    width="1200"
    height="678"
    layout="responsive" >}}

<br>

### Testing webhooks from local

Testing webhooks is a common use-case as well, even Slack or Shopify recommend to third-party developers this workflow to develop apps and plugins.

The thing is apps that support webhooks normally require a URL to consume data from, and it needs to be public and accessible, this is exactly what an HTTP tunnel can do, so you don't need to deploy to a public server every time you want to make a change.

{{< amp-image
    alt="Ngrok flow describing webhook testing"
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/demo-ngrok-webhooks.jpg"
    width="750"
    height="422"
    layout="responsive" >}}

<br>

### API testing and IoT devices

Almost every app and IoT device require some sort of API to consume data, to test the server-side development in real-time you can configure your endpoint base URL to be the tunnel's.

{{< amp-image
    alt="Esquema de ngrok describiendo un testeo de API en aparatos IOT"
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/demo-ngrok-iot.jpg"
    width="1200"
    height="800"
    layout="responsive" >}}

<br>

### More ideas...

As you can see use cases are almost limitless and I'm pretty sure I'm missing out on many, but here are some more quick ideas I have in mind:

 - Access your app though an https connection while your local setup only supports http.
 - Real responsive testing on a real phone with no deploy required.
 - Test cloud-based environments on your computer, like an AWS SQS for example.
 - Create a Minikube and use it as a full-fledged Kubernetes cluster.

## What HTTP tunneling tools are there? ⚒️

Now that we know what we can use tunnels for and our ideas are flowing let's check out the tools that would make them possible:

### Ngrok - secure introspectable tunnels to localhost

Ngrok is the most well-known tool in this matter. It's a SaaS and its main characteristics are:

**Pros**

 - Downloadable binary for multiple operating systems that enables quick setup.
 - Free tier using their servers.
 - An account with web GUI from which you can analyze requests and make custom responses, very useful for testing.
 - Local stats dashboard if you have a Ngrok account.
 - It's a successful business, which ensures future updates and a level of service stability.

**Cons**

 - It's not open source, at least the 2.x version. The original project is [public on Github](https://github.com/inconshreveable/ngrok), but it's not longer being maintained.
 - There are no self-hosted options.
 - The free tier is very limited to encourage conversion.

### Localtunnel - expose yourself

Even though their slogan may lead to misinterpretation, Localtunnel is the open-source project if you are talking about HTTP tunnels. It was created in 2012 and it's been developed and maintained ever since, without a doubt a good all-rounder and a great alternative to Ngrok.

**Pros**

 - It's open source, client and server.
 - Free tier for SaaS servers.
 - Great community and stable project, with more than 9K stars on GitHub.

**Cons**

 - To be picky, it's written in NodeJS that could be slower than Ngrok or Chisel, which are based in GoLang.

Repository: https://github.com/localtunnel/localtunnel

### Chisel - A fast TCP tunnel over HTTP

The new kid in the block, providing a fast and secure http tunneling experience. With more than 3K stars on Github, it seems that it's convincing the community.

**Pros**

 - It's open-source and the client and server are on the same project.
 - It's fast because it's written in GoLang with a clear focus on performance.
 - Official dockerize environment for ease of use.

**Cons**

 - No *as a service* available, this means you need to set up client and server.

Repository: https://github.com/jpillora/chisel

## How to use Ngrok in a web project? 👩‍🏭

Now let's get to work. At last, I decided to use Ngrok for my web app to do testing and demos due to its one-step setup with the binary file and because a simple web page doesn't need a lot of connections to work. I followed these steps:

We download the compressed binary from the official repository:

```
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
```

We unzip the files:

```
unzip ngrok-stable-linux-amd64.zip
```

We execute the file specifying the protocol and the listening port:

```
./ngrok http 80
```
The terminal will show all the data of our running tunnel including the URLs to access the server, using http or https. It looks something like this:

{{< amp-image
    alt="Output de consola del cliente de ngrok"
    src="/images/como-compartir-tu-local-por-internet-con-localtunnel/ngrok-output-consola.jpg"
    width="1970"
    height="932"
    layout="responsive" >}}

Done, now we can share the link with whoever we want to access our machine.

Ngrok offers a GUI to analyze requests that arrive at your server and even create custom responses for them. You can try it out accessing to `localhost:4040`. This can be very useful in case you are testing an API, webhook integrations or IOT devices communications with no coding required.

On the official website, if you log in to your account to see all your tunnels and their stats, check out the docs to learn how to configure it.

{{% post-it title="Warning 🚨" %}}
Ngrok free tier is quite limited, if you have a simple web application it should be enough, but in case your app makes many subrequests you should consider a paid plan or using other of the tools mentioned above!
{{% /post-it %}}

## Alternative setup with Localtunnel and docker 🐳

It's really cool to install globally a tool or download a binary file, but do you know what is cooler? Integrate your htpp tunnel with your docker workflow. Using the magic of containers and `docker-compose` it's possible to seamlessly add Localtunnel to a new or existing project!

I already have a simple dockerized setup for this blog, so that's what I'm going to use as a showcase.

Looking for a way to do this I found one amazing [docker image](https://hub.docker.com/r/efrecon/localtunnel), it only weights 20Mb and it has more than 1 million downloads! This took care of 90% of the work, now we only need to

It all can be done from the `docker-compose.yml` file, it doesn't even require to modify other services, it's just an add-on:

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

  # 🡣 New content 🡣

  localtunnel:
    image: efrecon/localtunnel
    depends_on:
      - web
    command:
      --local-host web --port 1313

{{< / highlight >}}

Let's see what this configuration means line by line:

 - **Line 13:** Declares the new Localtunnel service.
 - **Line 14:** Specifies the image that we are going to use in this service, in this case `efrecon/localtunnel` hosted in DockerHub, which is the default docker repository.
 - **Line 15-16:** Links the tunneling service with the web service to make them able to communicate with each other using the default docker network.
 - **Line 17-18:** Launches the startup command for Localtunnel with the IP and the post of the web service.

And that's it, when you launch it using a `docker-compose up` it will initialize a Localtunnel client and print the URL to access it!