
vebmedr
=======

[![Travis-CI Build Status](https://travis-ci.org/ijlyttle/vembedr.svg?branch=master)](https://travis-ci.org/ijlyttle/vembedr) [![codecov](https://codecov.io/gh/ijlyttle/vembedr/branch/master/graph/badge.svg)](https://codecov.io/gh/ijlyttle/vembedr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vembedr)](http://cran.r-project.org/package=vembedr)

The goal of the vembedr package is to make it a little bit easier for you to embed videos into your R Markdown documents and your Shiny Apps.

### New to this release:

-   Embed useR! 2016 videos, and by extension, Microsoft Channel 9 videos.
-   A helper function, `use_start_time()` can be used consistently with YouTube, Vimeo, and Channel 9 embeds.

### Note for GitHub README and RStudio

The browser within the RStudio IDE does not support the use of iframes that point to external URLs. Similarly, the embedding does not appear on GitHub's rendering of README.md. If you like, you can visit the [demo page](http://ijlyttle.github.io/vembedr/) to see everything in action.

Installation
------------

This package is available from CRAN:

``` r
install.packages("vembedr")
```

If you like, you can install the development version using Github.

``` r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("ijlyttle/vembedr")
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
