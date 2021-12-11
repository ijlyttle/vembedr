
# vembedr

<!-- badges: start -->
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/vembedr)](https://cran.r-project.org/package=vembedr)
[![R-CMD-check](https://github.com/ijlyttle/vembedr/workflows/R-CMD-check/badge.svg)](https://github.com/ijlyttle/vembedr/actions)
<!-- badges: end -->

The goal of vembedr is to make it a little bit easier for you to embed
videos into your **RMarkdown** documents and your **Shiny** apps; these
services are supported:

-   YouTube
-   Vimeo
-   Box
-   Microsoft Stream

## New to version 0.1.5

-   updated internal implementation to comport with latest Pandoc.
    ([#52](https://github.com/ijlyttle/vembedr/pull/52), thanks
    [@jnolis](https://github.com/jnolis)!)
-   deprecated Microsoft Channel 9 (including UserR! 2016 & 2017), as
    [Channel 9 has been
    moved](https://docs.microsoft.com/en-us/teamblog/channel9joinedmicrosoftlearn).
    ([#54](https://github.com/ijlyttle/vembedr/pull/54))

## Installation

You can install the latest released version from CRAN with:

``` r
install.packages("vembedr")
```

or the latest development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/vembedr")
```

## Documentation

This project supports two documentation-websites, built using
[pkgdown](https://pkgdown.r-lib.org):

-   [CRAN version](https://ijlyttle.github.io/vembedr/)
-   latest [developent version](https://ijlyttle.github.io/vembedr/dev/)
    from GitHub

### Usage

The most useful function might be `embed_url()`. If the URL is from one
of the supported services, it will do the right thing:

``` r
library("vembedr")

embed_url("https://www.youtube.com/watch?v=uV4UpCq2azs")
```

The video is not embedded in this README file as is rendered to
Markdown; to see embedded videos, please see `vignette("vembedr")`. Each
of the supported services, e.g. YouTube, is discussed in
`vignette("embed")`.

The functions are designed to be piped. For example, here’s how you can
modify the appearance and the start time:

``` r
embed_url("https://www.youtube.com/watch?v=uV4UpCq2azs") %>%
  use_start_time("1m32") %>%
  use_align("center")
```

To see these functions in action, see `vignette("modify")`.

### Caveats

-   Be aware that, due to licensing issues, not all videos will play
    when embedded at a different site (like your HTML document).

-   The RStudio viewer will embed YouTube and Vimeo videos, but not
    others. Videos from all services should be rendered as you expect in
    a browser like Chrome.

-   Some of the formatting, e.g. rounded corners, does not render on
    mobile sites.

## Code of Conduct

Please note that the vembedr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
