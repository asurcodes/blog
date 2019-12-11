+++
draft = false
date = "2019-12-11T15:47:05+02:00"
publishdate = "2019-12-11T15:47:05+02:00"

title = "Amperage theme kitchen sink"

description = "This a demo page for all the components in the Amperage theme for GoHugo"

summary = "This is a demo page for all the components in the Amperage theme. This posts is updated on every version release of Amperage. **Last updated on December 9th, 2019**."

tags = ['Amperage']

keywords = ['amperage', 'theme', 'gohugo', 'kitchen sink', 'demo', 'components']

[amp]
    elements = ['amp-anim', 'amp-iframe']

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

This is a demo page for all the components in the Amperage theme. This posts is updated on every version release of Amperage. **Last updated on December 9th, 2019**.

{{% toc %}}

**Titles:**

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

**Paragraph:**

Lorem ipsum dolor sit amet, consectetur adipiscing elit. **Fusce eget mauris augue**. Ut auctor nunc nec blandit malesuada. Suspendisse posuere tincidunt magna consequat pretium. In facilisis ultricies aliquam. *Ut vitae quam convallis*, facilisis lacus eget, tempus dolor. `Pellentesque eu justo` nec turpis sollicitudin malesuada. Proin vel mattis nisl.

**Code highlight:**

How to:

{{< highlight md "linenos=table" >}}

{{</* highlight html "linenos=table" */>}}

<link rel="manifest" href="https://asur.dev/manifest.json">
<link rel="icon" type="image/png" 
    sizes="32x32" href="https://asur.dev/icons/favicon-32x32.png">
<link rel="icon" type="image/png" 
    sizes="16x16" href="https://asur.dev/icons/favicon-16x16.png">
<link rel="apple-touch-icon" 
    sizes="180x180" href="https://asur.dev/icons/apple-touch-icon.png">

{{</* /highlight */>}}

{{< / highlight >}}

Result:

{{< highlight html "linenos=table" >}}

<link rel="manifest" href="https://asur.dev/manifest.json">
<link rel="icon" type="image/png" 
    sizes="32x32" href="https://asur.dev/icons/favicon-32x32.png">
<link rel="icon" type="image/png" 
    sizes="16x16" href="https://asur.dev/icons/favicon-16x16.png">
<link rel="apple-touch-icon" 
    sizes="180x180" href="https://asur.dev/icons/apple-touch-icon.png">

{{< / highlight >}}

**Table:**

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

**Image:**

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-image
    alt="Amperage image demo"
    src="/images/amperage-theme-kitchen-sink/share-card.jpg"
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

**Video:**

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-video
    alt="Amperage video demo"
    src="/videos/gh-actions-workflow.m4v"
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

**GIF:**

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-gif
    alt="Amperage GIF demo"
    src="/images/mejorando-workflow-docker-makefile-github-actions/make-command.gif"
    width="1367"
    height="1112"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-gif
    alt="Amperage GIF demo"
    src="/images/mejorando-workflow-docker-makefile-github-actions/make-command.gif"
    width="1367"
    height="1112"
    layout="responsive" >}}

**Iframe:**

How to:

{{< highlight md "linenos=table" >}}

{{</* amp-iframe
    alt="Amperage iframe demo"
    sandbox="allow-scripts allow-same-origin"
    src="https://giphy.com/embed/rihCLlGLlTYm4"
    width="480"
    height="321"
    layout="responsive" */>}}

{{< / highlight >}}

Result:

{{< amp-iframe
    alt="Amperage iframe demo"
    sandbox="allow-scripts allow-same-origin"
    src="https://giphy.com/embed/rihCLlGLlTYm4"
    width="480"
    height="321"
    layout="responsive" >}}
