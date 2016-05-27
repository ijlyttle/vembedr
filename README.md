
vebmedr
=======

[![Travis-CI Build Status](https://travis-ci.org/ijlyttle/vembedr.svg?branch=master)](https://travis-ci.org/ijlyttle/vembedr) [![codecov](https://codecov.io/gh/ijlyttle/vembedr/branch/master/graph/badge.svg)](https://codecov.io/gh/ijlyttle/vembedr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vembedr)](http://cran.r-project.org/package=vembedr)

The functions in this package make it a little bit easier for you to embed hosted videos into your RMarkdown documents and Shiny apps.

The embedding does not appear on GitHub's rendering of README. If you like, you can visit the [demo page](http://ijlyttle.github.io/vembedr/) to see everything in action.

Installation
------------

The vembedr package is available yet on CRAN. However, you can install from GitHub:

``` r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("ijlyttle/vembedr")
```

### Note for RStudio users

The browser within the RStudio IDE does not support the use of iframes that point to external URLs. Opening your rendered html file in a different browser, such as Chrome or Firefox, should work just fine.

Embedding a YouTube video
-------------------------

Let's say that you want to embed a YouTube video into an RMarkdown document, perhaps a vignette. Your first step will be to get the YouTube identifier for the particular video. One way to do this is to inspect the URL of the YouTube page featuring the video that you want to embed. For example:

    "https://www.youtube.com/watch?v=q2nNzNo_Xps"

The identifier is simply the last part of the url: `"q2nNzNo_Xps"`.

To embed this video, use the function `embed_youtube()`, using the `id` argument:

``` r
embed_youtube(id = "q2nNzNo_Xps")
```

Voila! If you wish to add some formatting within your document, the htmltools package makes that easier:

``` r
div(align = "center", embed_youtube(id = "Qpoqzt2EHaA"))
```

You will be the best judge of the best formatting for your situation. By providing only the iframe, you can wrap the iframe in whatever tags will work best for you.

Embedding a Vimeo video
-----------------------

Embedding a video from Vimeo is just as easy.

    "https://vimeo.com/48699174"

The Vimeo id is just the path part of the URL: `"48699174"`:

``` r
div(align = "center", embed_vimeo(id = "48699174"))
```

Other arguments and query parameters
------------------------------------

The defaults for height and width of the iframe are taken from each service's defaults. You can change this using the `height` and `width` arguments to either of the embedding functions:

``` r
div(
  align = "center", 
  embed_youtube(id = "1hKSYgOGtos", width = 640,  height = 390)
)
```

YouTube and Vimeo each provide you the means to specify more options using http query parameters. A well-known example of this is YouTube allowing you to use a URL where the video starts at a given time (thanks to Aurélien Ginolhac for suggesting this link): <https://youtu.be/8SGif63VW6E?t=4m12s>

Unfortunately, the query parameters for YouTube links are different from those for YouTube embeds. To do the same thing for embedding, you specify a `start` with the number of seconds.

``` r
div(
  align = "center", 
  embed_youtube(id = "8SGif63VW6E", query = list(start = 252))
)
```

To make things a little easier, a helper function, `secs()` is provided:

``` r
div(
  align = "center", 
  embed_youtube(id = "8SGif63VW6E", query = list(start = secs("4m12s")))
)
```

It seems that Vimeo does not provide the option to specify a start time.

The query parameters for each service can be found at:

-   [YouTube IFrame API](https://developers.google.com/youtube/player_parameters)
-   [Vimeo emebedding](https://developer.vimeo.com/player/embedding)

### Convenience functions

Finally, a couple of convenience functions are provided so that you can focus on experimenting with the arguments and the query parameters. In these functions, the video `id` is specified, any argument you provide is passed along to either `embed_youtube()` or `embed_vimeo()`.

``` r
rickroll_youtube()
```

``` r
rickroll_vimeo()
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
