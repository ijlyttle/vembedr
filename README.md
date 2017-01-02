
vebmedr
=======

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vembedr)](http://cran.r-project.org/package=vembedr) [![Travis-CI Build Status](https://travis-ci.org/ijlyttle/vembedr.svg?branch=master)](https://travis-ci.org/ijlyttle/vembedr) [![Coverage Status](https://img.shields.io/codecov/c/github/ijlyttle/vembedr/master.svg)](https://codecov.io/github/ijlyttle/vembedr?branch=master)

The goal of the vembedr package is to make it a little bit easier for you to embed videos into your **rmarkdown** documents and your **shiny** apps. Three services are currently supported: YouTube, Vimeo, and Microsoft Channel 9 (including UseR! 2016 videos).

New to version 0.1.1
--------------------

-   Embed useR! 2016 videos, and by extension, Microsoft Channel 9 videos.
-   A helper function, `use_start_time()`, can be used consistently with YouTube, Vimeo, and Channel 9 embeds.

Installation
------------

You can install the latest released version from CRAN with

``` r
install.packages("vembedr")
```

or the latest development version from github with

``` r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
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

To embed a YouTube video, simply use its `id`, which you can get from the original URL.

``` r
embed_youtube(id = "66BsXw9MKqA")
```

<!--html_preserve-->
<iframe src="https://www.youtube.com/embed/66BsXw9MKqA" width="420" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->
Similarly, to embed a Vimeo, use its `id`. Note that we can apply some formatting by wrapping the output of the `embed_vimeo()` function in an **htmltools** `div()`.

``` r
div(
  align = "center",
  embed_vimeo(id = "189919038")
)
```

<!--html_preserve-->
<iframe src="https://player.vimeo.com/video/189919038" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen>
</iframe>

<!--/html_preserve-->
Hat tip to Karthik Ram for [tweeting](https://twitter.com/_inundata/status/794616331727294464) out this Vimeo.

For YouTube, Vimeo, and Microsoft Channel 9 (hosts of the User! 2016 videos) you can specify a start time. Please note that for Vimeo, specifying a start time implies that the video **will** be auto-played (which can be annoying).

Here's an example using a lightning presentation from UseR! 2016:

``` r
embed_user2016(id = "Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM") %>% 
  use_start_time("21m45s")
```

<!--html_preserve-->
<iframe src="https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM/player#time=0h21m45s:paused" width="560" height="315" frameborder="0" allowfullscreen>
</iframe>
<!--/html_preserve-->
Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
