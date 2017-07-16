
vebmedr
=======

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/vembedr)](https://cran.r-project.org/package=vembedr) [![Travis-CI Build Status](https://travis-ci.org/ijlyttle/vembedr.svg?branch=master)](https://travis-ci.org/ijlyttle/vembedr) [![Coverage Status](https://img.shields.io/codecov/c/github/ijlyttle/vembedr/master.svg)](https://codecov.io/github/ijlyttle/vembedr?branch=master)

The goal of the vembedr package is to make it a little bit easier for you to embed videos into your **rmarkdown** documents and your **shiny** apps. Three services are currently supported: YouTube, Vimeo, and Microsoft Channel 9 (including UseR! 2016 and 2017 videos).

New to version 0.1.3
--------------------

-   updates README to show some custom formatting, thanks [Eric Koncina](https://github.com/koncina) and [Aurélien Ginolhac](https://github.com/ginolhac)
-   adds function `embed_user2017()`: embed videos from UseR!2017

Installation
------------

You can install the latest released version from CRAN with:

``` r
install.packages("vembedr")
```

or the latest development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/vembedr")
```

Examples
--------

For these examples, it can be useful to load the **htmltools** package along with the **vembedr** package.

``` r
library("htmltools")
library("vembedr")
```

With the function `embed_url()`, you can use the URL from your browser to embed video:

``` r
embed_url("https://www.youtube.com/watch?v=uV4UpCq2azs")
```

<!--html_preserve-->
<iframe src="https://www.youtube.com/embed/uV4UpCq2azs" width="420" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->

------------------------------------------------------------------------

If you just want the embedding code, the `suggest_embed()` function may be useful:

``` r
suggest_embed("https://youtu.be/uV4UpCq2azs?t=1m32s")
#> embed_youtube("uV4UpCq2azs") %>%
#>   use_start_time("1m32s")
```

All of the features shown here can be used for all the supported services: YouTube, Vimeo, and Channel 9. Here, the features are mixed-and-matched in the interest of brevity.

------------------------------------------------------------------------

To embed a YouTube (or Vimeo, or Channel 9) video you can use its identifier, which you can get from the original URL.

``` r
embed_youtube("1-vcErOPofQ")
```

<!--html_preserve-->
<iframe src="https://www.youtube.com/embed/1-vcErOPofQ" width="420" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->

------------------------------------------------------------------------

For this example, we embed a Vimeo using some custom formatting - thanks to [Eric Koncina](https://github.com/koncina) and [Aurélien Ginolhac](https://github.com/ginolhac) who [showed the way](https://github.com/ijlyttle/vembedr/issues/25). First let's introduce some css where we can define some rounded corners for an embedded video, by describing an HTML class, `vembedr`:

    ```{css}
    .vembedr {
      display: inline-block;
      border-radius: 25px; /* adjust it to your needs */
      overflow: hidden;
    }

    .vembedr iframe {
      display: block;
      border: none;
    }
    ```

To embed a Vimeo with some custom formatting:

-   call `embed_vimeo()` using the Vimeo identifier, *then*
-   wrap that in `<div/>` using our new `vembedr` class, *then*
-   wrap that in a `<div/>` that centers its contents

``` r
embed_vimeo("189919038") %>%
  div(class = "vembedr") %>%
  div(align = "center")
```

<!--html_preserve-->
<iframe class="vimeo-embed" src="https://player.vimeo.com/video/189919038" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen>
</iframe>

<!--/html_preserve-->
<!--html_preserve-->
<br/><!--/html_preserve-->

Of course, the use of the pipe operator is optional. Hat tip to Karthik Ram for [tweeting](https://twitter.com/_inundata/status/794616331727294464) out this Vimeo.

------------------------------------------------------------------------

You can also specify a start time. Please note that for Vimeo, specifying a start time implies that the video **will** be auto-played (which can be annoying).

Here's an example using a lightning presentation from UseR!2017:

``` r
embed_user2017("Room-202-Lightning-Talks") %>% 
  use_start_time("26m35s")
```

<!--html_preserve-->
<iframe src="https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/Room-202-Lightning-Talks/player#time=0h26m35s:paused" width="560" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->

------------------------------------------------------------------------

Note for GitHub README and RStudio viewer
-----------------------------------------

The GitHub Markdown renderer does not support video embedding. To see everything in action, you are invited to visit the [GitHub pages](http://ijlyttle.github.io/vembedr/) site, built using [pkgdown](http://hadley.github.io/pkgdown/).

If you use the RStudio-IDE viewer to preview your work, please note that RStudio have made the design choice not to allow arbitrary external web-content in the IDE, which is wholly appropriate. However, with the advent of the [learnr](https://rstudio.github.io/learnr/) package, the IDE-viewer supports embedding of Vimeo and YouTube videos.

Otherwise, you can simply open your preview in an external browser.

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
