#' vembedr S3 Classes
#'
#' Knowledge of these classes is not needed for day-to-day use. Rather,
#' it is a bookkeeping device used to make it clearer to add a new service
#' in development.
#'
#' We use S3 classes to distinguish an embed object, and to denote which
#' service it uses. Objects of these classes are created by [embed_url()]
#' and each service's embed function.
#'
#' **`vembedr_embed`**
#'
#' - base class for all services
#' - HTML `<div>`
#' - contains the embed code
#'
#' There is an additional class attached according to the service:
#'
#' **`vembedr_embed_youtube`**
#' **`vembedr_embed_youtube_short`**
#' **`vembedr_embed_vimeo`**
#' **`vembedr_embed_channel9`**
#' **`vembedr_embed_box`**
#' **`vembedr_embed_msstream`**
#'
#' To support parsing, there is an internal S3 class attached to the URL
#' being processed. It is named according to the service:
#'
#' **`vembedr_url_youtube`**
#' **`vembedr_url_youtube_short`**
#' **`vembedr_url_vimeo`**
#' **`vembedr_url_channel9`**
#' **`vembedr_url_box`**
#' **`vembedr_url_msstream`**
#'
#' @name vembedr-s3-classes
#'
NULL


