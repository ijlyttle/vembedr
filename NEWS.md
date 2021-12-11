## vembedr 0.1.5

- updates repository and GitHub actions to reflect default git branch is now `main`. (#55)

- updates `<iframe>` implementation to keep up with pandoc, see [rstudio/rmarkdown#2255](https://github.com/rstudio/rmarkdown/issues/2255). (#52,  @jnolis)

- version bump for development.

## vembedr 0.1.4

- adds support for [Microsoft Stream](https://www.microsoft.com/en-us/microsoft-365/microsoft-stream), which offers an enterprise video service; this will likely be for use internal to an organization. (#38)
- if you have a recent version of [usethis](https://usethis.r-lib.org) installed, `suggest_embed()` will copy the suggested code to your clipboard. (#32)
- sets the default `height` to 300 pixels, and introduces an argument `ratio`, to set the aspect ratio; legal values are `"16by9"` or `"4by3"`. If you set the `width` and `height`, `ratio` is ignored. If you specify only one of `width` or `height`, `ratio` is used to calculate the other. (#33)
- adds three functions to help with formatting; they are all pipeable with `embed_*()` functions:
  - `use_rounded()` lets you specify rounded corners. (#25, with @koncina and @ginolhac)
  - `use_align()` lets you specify a horizontal alignment.
  - `use_bs_responsive()` if your 'HTML' page includes [Twitter Bootstrap 3](https://getbootstrap.com/docs/3.3/components/#responsive-embed), use this function to make your `<iframe/>` responsive. In this case, the `ratio` is used, `width` and `height` are ignored. (#13)
  
- adds functionality for embedding [Box](https://www.box.com) videos, via the `embed_box()` function (#28)
- version bump for development

## vembedr 0.1.3

- updates README to show some custom formatting (#25, @koncina & @ginolhac)
- deprecates `hms()` and `secs()` in favor of `use_start_time()` (#24)
- adds function `embed_user2017()`: embed videos from UseR!2017
- version bump for development

## vembedr 0.1.2

- adds `embed_url()`: given a URL, build the `<iframe/>` to embed the video
- adds `suggest_embed()`: given a URL, provides suggested code to embed video
- fully deprecates `allow_full_screen` argument
- adds **pkgdown** support 
- version bump for development

## vembedr 0.1.1

* adds `rickroll_channel9()`, stretches definition of rickrolling
* deprecates `allow_full_screen` argument to embed functions in favor of
  `allowfullscreen` - this will be more consistent with each service's API
* adds `use_start_time()` for constent interface to all embed functions
* adds `embed_channel9()` for Microsoft videos
* adds support for start-time for Vimeo (#14, thanks @karthik for tip)
* adds `embed_user2016()`
* version bump for development

## vembedr 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Added a vignette.
* Added helper function `secs()` and query argument to both `embed_vimeo()` and `embed_youtube()`.
* Added functions `rickroll_vimeo()` and `rickroll_youtube()`.
* Added functions `embed_vimeo()` and `embed_youtube()`.


