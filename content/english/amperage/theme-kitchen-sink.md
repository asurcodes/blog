+++
draft = false
date = "2019-12-11T15:47:05+02:00"
publishdate = "2019-12-11T15:47:05+02:00"

title = "Amperage theme kitchen sink"

description = "This a demo page for all the components in the Amperage theme for GoHugo"

summary = "This is a demo page for all the components in the Amperage theme. This posts is updated on every version release of Amperage. **Last updated on January 16th, 2020**."

tags = ['Amperage']

keywords = ['amperage', 'theme', 'gohugo', 'kitchen sink', 'demo', 'components']

[amp]
    elements = ['amp-ad', 'amp-anim', 'amp-iframe', 'amp-video']

[author]
    name = "Asur"
    homepage = "/"

[image]
    src = "/images/amperage-theme-kitchen-sink/share-card.jpg"

[twitter]
    site = "@asurbernardo"

[sitemap]
  changefreq = "monthly"
  priority = 0.5
  filename = "sitemap.xml"
+++

# Amperage theme kitchen sink

{{% under-title %}}

This is a demo page for all the components in the Amperage theme. This posts is updated on every version release of Amperage. **Last updated on January 16th, 2020**.

## Titles

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

## Paragraphs and inline modifications

Lorem ipsum dolor sit amet, consectetur adipiscing elit. **Fusce eget mauris augue**. Ut auctor nunc nec blandit malesuada. Suspendisse posuere tincidunt magna consequat pretium. In facilisis ultricies aliquam. *Ut vitae quam convallis*, facilisis lacus eget, tempus dolor. `Pellentesque eu justo` nec turpis sollicitudin malesuada. Proin vel mattis nisl.

## Code highlights

How to:

{{< highlight md "linenos=table" >}}

{{</* highlight html "linenos=table" */>}}

<link rel="manifest" href="https://example.com/manifest.json">
<link rel="icon" type="image/png"
    sizes="32x32" href="https://example.com/icons/favicon-32x32.png">
<link rel="icon" type="image/png"
    sizes="16x16" href="https://example.com/icons/favicon-16x16.png">
<link rel="apple-touch-icon"
    sizes="180x180" href="https://example.com/icons/apple-touch-icon.png">

{{</* /highlight */>}}

{{< / highlight >}}

Result:

{{< highlight html "linenos=table" >}}

<link rel="manifest" href="https://example.com/manifest.json">
<link rel="icon" type="image/png"
    sizes="32x32" href="https://example.com/icons/favicon-32x32.png">
<link rel="icon" type="image/png"
    sizes="16x16" href="https://example.com/icons/favicon-16x16.png">
<link rel="apple-touch-icon"
    sizes="180x180" href="https://example.com/icons/apple-touch-icon.png">

{{< / highlight >}}

## Tables

How to:

{{< highlight markdown "linenos=table" >}}

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |

{{< / highlight >}}

Result:

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |

## Ads

How to:

{{< highlight markdown "linenos=table" >}}

{{</* amp-adsense
    width="320"
    height="320"
    layout="fixed"
    slot="123456789" */>}}

{{< / highlight >}}

Result:

{{< amp-adsense
    width="320"
    height="320"
    layout="fixed"
    slot="9425131909" >}}

## Images

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-image
    alt="Amperage image demo"
    src="/images/your-image.jpg"
    width="1280"
    height="720"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-image
    alt="Amperage image demo"
    src="/images/amperage-theme-kitchen-sink/share-card.jpg"
    width="1280"
    height="720"
    layout="responsive" >}}

## Images with caption

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-image
    alt="Amperage image demo"
    caption="Welcome to the Amperage theme kitchen sink!"
    src="/images/your-image.jpg"
    width="1280"
    height="720"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-image
    alt="Amperage image demo"
    caption="Welcome to the Amperage theme kitchen sink!"
    src="/images/amperage-theme-kitchen-sink/share-card.jpg"
    width="1280"
    height="720"
    layout="responsive" >}}

## Post-its

How to:

{{< highlight md "linenos=table" >}}

{{%/* post-it title="Warning! 🚨" */%}}
Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.
{{%/* / post-it */%}}

{{%/* post-it type="success" title="Success! 🎉" */%}}
Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.
{{%/* / post-it */%}}

{{%/* post-it type="danger" title="Danger! ☠️" */%}}
Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.
{{%/* / post-it */%}}

{{%/* post-it type="info" title="Info! ℹ️" */%}}
Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.
{{%/* / post-it */%}}

{{< / highlight >}}

Result:

{{% post-it title="Warning! 🚨" %}}

Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.

{{% / post-it %}}

{{% post-it type="success" title="Success! 🎉" %}}

Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.

{{% / post-it %}}

{{% post-it type="danger" title="Danger! 💀" %}}

Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.

{{% / post-it %}}

{{% post-it type="info" title="Info! 💬" %}}

Lorem **ipsum** dolor sit amet, consectetur adipiscing elit.
Sed eiusmod tempor incidunt ut labore et *dolore* magna aliqua.

{{% / post-it %}}

## Videos

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-video
    alt="Amperage video demo"
    src="/videos/your-video.m4v"
    width="1280"
    height="576"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-video
    alt="Amperage video demo"
    src="/videos/gh-actions-workflow.m4v"
    width="1280"
    height="576"
    layout="responsive" >}}

## GIFs

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-gif
    alt="Amperage GIF demo"
    src="/images/your-animation.gif"
    width="1367"
    height="1112"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-gif
    alt="Amperage GIF demo"
    src="/images/how-to-deploy-your-own-crypto-trading-bot/docker-nyan-cat.gif"
    width="800"
    height="600"
    layout="responsive" >}}

## Products

How to:

{{< highlight md "linenos=table" >}}

{{</* product
    title="Yellow rubber duck 🦆"
    description="A programmer's best friend when you don't have anyone to talk to."
    image="https://example.com/your-image.jpg"
    cta="Find out price!"
    link="https://example.com/your-product" */>}}

{{< / highlight >}}

Result:

{{< product
    title="Yellow rubber duck!"
    description="A programmer's best friend when you don't have anyone to talk to. He will always be there! 🦆"
    image="https://images-na.ssl-images-amazon.com/images/I/8166xCVDGnL._SL1500_.jpg"
    cta="Find out price!"
    link="https://www.amazon.com/Munchkin-White-Safety-Bath-Ducky/dp/B000GUZC2A/ref=sr_1_3" >}}

## Iframes

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-iframe
    sandbox="allow-scripts allow-same-origin"
    src="https://example.com/embed/rihCLlGLlTYm4"
    width="480"
    height="321"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-iframe
    sandbox="allow-scripts allow-same-origin"
    src="https://giphy.com/embed/rihCLlGLlTYm4"
    width="480"
    height="321"
    layout="responsive" >}}
