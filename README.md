
# vembedr

<!-- badges: start -->
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/vembedr)](https://cran.r-project.org/package=vembedr)
[![R build
status](https://github.com/ijlyttle/vembedr/workflows/R-CMD-check/badge.svg)](https://github.com/ijlyttle/vembedr/actions)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The goal of the vembedr package is to make it a little bit easier for
you to embed videos into your **rmarkdown** documents and your **shiny**
apps. Four services are currently supported:

  - YouTube
  - Vimeo
  - Microsoft Channel 9 (including UseR\! 2016 and 2017 videos).
  - Box

## New to version 0.1.3.9000

  - functions to help you format: `use_rounded()`, `use_align()`, and
    `use_bs_responsive()`.
  - you can embed videos hosted on Box, using `embed_box()`.

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

  - [CRAN version](https://ijlyttle.github.io/vembedr)
  - latest [developent version](https://ijlyttle.github.io/vembedr/dev)
    from GitHub

### Usage

The most useful function might be `embed_url()`. If the URL is from one
of the supported services, it will do the right thing:

``` r
library("vembedr")

embed_url("https://www.youtube.com/watch?v=uV4UpCq2azs")
```

To see this in action, please see `vignette("vembedr")`.

To see details on each of the services supported, see
`vignette("embed")`. You can also modify the appearance and the start
time, for example:

``` r
embed_url("https://www.youtube.com/watch?v=uV4UpCq2azs") %>%
  use_start_time("1m32") %>%
  use_align("center")
```

To see these functions in action, see `vignette("modify")`.

### Caveats

Be aware that not all videos will play when embedded at a different site
(like your RMarkdown document). This is due to licensing issues.

The RStudio viewer will embed YouTube and Vimeo videos, but not others.
Everthing should work well in a browser like Chrome.

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
