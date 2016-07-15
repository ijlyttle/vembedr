
vebmedr
=======

[![Travis-CI Build Status](https://travis-ci.org/ijlyttle/vembedr.svg?branch=master)](https://travis-ci.org/ijlyttle/vembedr) [![codecov](https://codecov.io/gh/ijlyttle/vembedr/branch/master/graph/badge.svg)](https://codecov.io/gh/ijlyttle/vembedr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vembedr)](http://cran.r-project.org/package=vembedr)

The goal of the vembedr package is to make it a little bit easier for you to embed videos into your R Markdown documents and your Shiny Apps.

### New to version 0.1.1

-   Embed useR! 2016 videos, and by extension, Microsoft Channel 9 videos.
-   A helper function, `use_start_time()` can be used consistently with YouTube, Vimeo, and Channel 9 embeds.

### Installation

You can install the latest released version from CRAN with

``` r
install.packages("dplyr")
```

or the latest development version from github with

``` r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("ijlyttle/vembedr")
```

### Note for GitHub README

The GitHub Markdown renderer does not support video embedding. To see everything in action, you are invited to visit this page using the [GitHub pages](http://ijlyttle.github.io/vembedr/) service.

Services
--------

The package supports embedding from three services: YouTube, Vimeo, and now Microsoft's Channel 9 (including the useR! 2016 presentations).

### Channel 9

One of the great things about the useR! 2016 conference was that all of the keynotes and contributed talks were recorded, thanks to Microsoft. The videos are available on Microsoft's Channel 9 service - so it behooves us to make an function to embed Channel 9 videos.

Consider Rick Becker's talk on the history of the S language. Seriously, consider it - now, if you have not already seen it.

Here is the URL for the page that hosts the video:

`https://channel9.msdn.com/`**`Events/useR-international-R-User-conference/useR2016/Forty-years-of-S`**

To embed a Channel 9 video, the `id` is the path of the URL, which you can express as a vector of character strings:

``` r
embed_channel9(
  id = c("Events", "useR-international-R-User-conference", "useR2016", "Forty-years-of-S")
)
```

#### useR! 2016

Of course, it could be easier to embed these conference videos - hence the `embed_user2016()` function. For example, this talk needs no introduction:

`https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/`**`Literate-Programming`**

The trick for these useR! videos is that the `id` is just the last component of the URL's path.

``` r
embed_user2016(id = "Literate-Programming")
```

### YouTube

Your first step will be to get the YouTube identifier for the particular video. One way to do this is to inspect the URL of the YouTube page featuring the video that you want to embed. For example:

    "https://www.youtube.com/watch?v=q2nNzNo_Xps"

The identifier is simply the last part of the URL: `"q2nNzNo_Xps"`.

To embed this video, use the function `embed_youtube()`, using the `id` argument:

``` r
embed_youtube(id = "q2nNzNo_Xps")
```

If you wish to add some formatting within your document, the htmltools package makes that easier:

``` r
div(align = "center", embed_youtube(id = "Qpoqzt2EHaA"))
```

You will be the best judge of the best formatting for your situation. By providing only the iframe, you can wrap the iframe in whatever tags will work best for you.

### Vimeo

Embedding a video from Vimeo is just as easy.

    "https://vimeo.com/48699174"

The Vimeo `id` is just the path part of the URL: `"48699174"`:

``` r
embed_vimeo(id = "48699174")
```

API philosophy
--------------

The `embed_*()` family of functions is designed to help you compose the URL according to the API of each service, using the `query` and `fragment` arguments - these are passed to `httr::build_url()` to compose the URL.

The query/fragment parameters for each service can be found at:

-   [YouTube IFrame API](https://developers.google.com/youtube/player_parameters)
-   [Vimeo emebedding](https://developer.vimeo.com/player/embedding)
-   [Channel 9](https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Forty-years-of-S) - click the embed button to see options

A well-known example of this is YouTube allowing you to use a URL where the video starts at a given time (thanks to Aurélien Ginolhac for suggesting this link): `https://youtu.be/8SGif63VW6E?t=4m12s`

Unfortunately, the query parameters for YouTube links are different from those for YouTube embeds. To do the same thing for embedding, you specify a `start` with the number of seconds.

``` r
embed_youtube(id = "8SGif63VW6E", query = list(start = 252))
```

For Vimeo, there is a somewhat undocumented way to do this (thanks Karthik Ram for the heads-up). Word of warning, there seems to be no way to avoid the autoplay, so beware - also see some notes at Vimeo: (<https://vimeo.com/forums/topic:49396>).

``` r
embed_vimeo(id = "98892825", fragment = "t=60")
```

### Helper functions

It's a bit inconvenient to visit a service's API page to figure out how do something relatively common, like specify a start time. For this reason a consistent set of helper functions is offered. It is proposed that helper functions used to modify the URL will be called `use_something()` and can be composed using the pipe, `%>%`.

#### Start time

To specify the start time, simply pipe your embed function to the `use_start_time()` function, which figures out which service you are using, then does the "right thing" to modify the query or fragment.

The `use_start_time()` function will treat these all of these inputs equivalently:

-   `"0h1m0s"`, `"0h01m00s"`, `"0h1m"`
-   `"1m0s"`, `"1m"`
-   `"60s"`, `60`

``` r
embed_youtube(id = "8SGif63VW6E") %>% use_start_time("4m12s")
```

``` r
embed_vimeo(id = "98892825") %>% use_start_time("60")
```

Let's say you wanted to point to a specific lightning talk at useR! 2016.

Please note that it seems to take a few seconds from when the browser loads until the video will be ready to start at the specified time.

``` r
embed_user2016(id = "Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM") %>% 
  use_start_time("21m45s")
```

#### Video specification

Some convenience functions are provided so that you can focus on experimenting with the arguments and the query parameters. In these functions, the video `id` is specified, any argument you provide is passed along to either `embed_youtube()` or `embed_vimeo()`.

``` r
rickroll_youtube()
```

``` r
rickroll_vimeo()
```

It is imagined that in a future release of this package, this approach will be deprecated in favor of something like:

``` r
embed_youtube() %>% use_rickroll()
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
