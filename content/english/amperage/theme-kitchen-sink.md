+++
draft = false
date = "2019-12-15T16:14:05+02:00"
publishdate = "2019-12-15T16:14:05+02:00"

title = "Amperage theme kitchen sink"

description = "This a demo page for all the components in the Amperage theme for GoHugo"

summary = "This is a demo page for all the components in the Amperage theme. This posts is updated on every version release of Amperage. **Last updated on 9th of December 2019**."

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

This is a demo page for all the components in the Amperage theme. This posts is updated on every version release of Amperage. **Last updated on 9th of December 2019**.

{{% toc %}}

**Titles:**

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

**Paragraph:**

Lorem ipsum dolor sit amet, consectetur adipiscing elit. **Fusce eget mauris augue**. Ut auctor nunc nec blandit malesuada. Suspendisse posuere tincidunt magna consequat pretium. In facilisis ultricies aliquam. *Ut vitae quam convallis*, facilisis lacus eget, tempus dolor. `Pellentesque eu justo` nec turpis sollicitudin malesuada. Proin vel mattis nisl.

**Code highlight:**

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

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |

**Image:**

{{< amp-image
    alt="Amperage demo image"
    src="/images/amperage-theme-kitchen-sink/share-card.jpg"
    width="1280"
    height="720"
    layout="responsive" >}}

**Video:**

{{< amp-video
    alt="Amperage demo video"
    src="/videos/gh-actions-workflow.m4v"
    width="1280"
    height="576"
    layout="responsive" >}}

**GIF:**

{{< amp-gif
    alt="Amperage demo GIF"
    src="/images/mejorando-workflow-docker-makefile-github-actions/make-command.gif"
    width="1367"
    height="1112"
    layout="responsive" >}}

**Iframe:**

{{< amp-iframe
    alt="Amperage demo iframe"
    sandbox="allow-scripts allow-same-origin"
    src="https://giphy.com/embed/rihCLlGLlTYm4"
    width="480"
    height="321"
    layout="responsive" >}}
