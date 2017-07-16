## vembedr 0.1.2.9000

- updates README to show some custom formatting (#25, thanks @koncina and @ginolhac)
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


