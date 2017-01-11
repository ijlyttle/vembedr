
vebmedr
=======

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vembedr)](https://cran.r-project.org/package=vembedr) [![Travis-CI Build Status](https://travis-ci.org/ijlyttle/vembedr.svg?branch=master)](https://travis-ci.org/ijlyttle/vembedr) [![Coverage Status](https://img.shields.io/codecov/c/github/ijlyttle/vembedr/master.svg)](https://codecov.io/github/ijlyttle/vembedr?branch=master)

The goal of the vembedr package is to make it a little bit easier for you to embed videos into your **rmarkdown** documents and your **shiny** apps. Three services are currently supported: YouTube, Vimeo, and Microsoft Channel 9 (including UseR! 2016 videos).

New to version 0.1.2
--------------------

-   New function `embed_url()`: given a URL, build the `<iframe/>` to embed the video
-   New function `suggest_embed()`: given a URL from a video's web-page: suggests embedding-code.

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

Note for GitHub README and RStudio viewer
-----------------------------------------

The GitHub Markdown renderer does not support video embedding. To see everything in action, you are invited to visit the [GitHub pages](http://ijlyttle.github.io/vembedr/) site, built using [pkgdown](http://hadley.github.io/pkgdown/).

If you use the RStudio-IDE viewer to preview your work, please note that RStudio have made the design choice not to allow arbitrary external web-content in the IDE, which is wholly appropriate. Simply open your preview in an external browser.

Examples
--------

For these examples, it can be useful to load the **htmltools** package along with the **vembedr** package.

``` r
library("htmltools")
library("vembedr")
```

With the newest function, `embed_url()`, you can use the URL from your browser to embed video:

``` r
embed_url("https://www.youtube.com/watch?v=uV4UpCq2azs")
```

<!--html_preserve-->
<iframe src="https://www.youtube.com/embed/uV4UpCq2azs" width="420" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->
If you just want the embedding code, the `suggest_embed()` function may be useful:

``` r
suggest_embed("https://youtu.be/uV4UpCq2azs?t=1m32s")
#> embed_youtube("uV4UpCq2azs") %>%
#>   use_start_time("1m32s")
```

All of the features shown here can be used for all the supported services: YouTube, Vimeo, and Channel 9. Here, the features are mixed-and-matched in the interest of brevity.

To embed a YouTube (or Vimeo, or Channel 9) video you can use its identifier, which you can get from the original URL.

``` r
embed_youtube("1-vcErOPofQ")
```

<!--html_preserve-->
<iframe src="https://www.youtube.com/embed/1-vcErOPofQ" width="420" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->
Similarly, to embed a Vimeo, use its identifier. Note that we can apply some formatting by wrapping the output of the `embed_vimeo()` function in an **htmltools** `div()`.

``` r
div(
  align = "center",
  embed_vimeo("189919038")
)
```

<!--html_preserve-->
<iframe class="vimeo-embed" src="https://player.vimeo.com/video/189919038" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen>
</iframe>

<!--/html_preserve-->
Hat tip to Karthik Ram for [tweeting](https://twitter.com/_inundata/status/794616331727294464) out this Vimeo.

For YouTube, Vimeo, and Microsoft Channel 9 (hosts of the User! 2016 videos) you can specify a start time. Please note that for Vimeo, specifying a start time implies that the video **will** be auto-played (which can be annoying).

Here's an example using a lightning presentation from UseR! 2016:

``` r
embed_user2016("Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM") %>% 
  use_start_time("21m45s")
```

<!--html_preserve-->
<iframe src="https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM/player#time=0h21m45s:paused" width="560" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->
Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
