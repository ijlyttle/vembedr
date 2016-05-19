
[Github page, with live demo](http://ijlyttle.github.io/vembedr/)

<!-- README.md is generated from README.Rmd. Please edit that file -->
The functions in this package make it a little bit easier for you to embed hosted videos into your RMarkdown documents and Shiny apps.

[Demo](http://ijlyttle.github.io/vembedr/)

Installation
------------

You may install the latest development version from github by:

``` r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("ijlyttle/vembedr")
```

Use
===

``` r
library("htmltools")
library("vembedr")
```

It's fairly simple, you just need the video id from either Vimeo or YouTube.

``` r
embed_vimeo("45196609", query = list(start = 10))
```

You may wish to center the embed:

``` r
div(align = "center", embed_youtube("dQw4w9WgXcQ"))
```

Embedding does not work for the standard Github site, but it does for `gh-pages`.

Future work
===========

Both YouTube and Vimeo support the use of query parameters in the URL. Supporting this is the likely next step.

-   [Vimeo embedding](https://developer.vimeo.com/player/embedding)
-   [YouTube embedding](https://developers.google.com/youtube/player_parameters)

At some point, I'd like to submit this to CRAN, so your feedback will be very welcome.

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
