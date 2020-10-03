#' Specify start time
#'
#' This function provides you a consistent way to specify the start time,
#' regardless of the service. Please note that Box does not provide a
#' means to specify the start time.
#'
#' The `start_time` argument can take a variety of formats; these inputs
#' all evaluate to the same value:
#'
#' \itemize{
#'   \item{`"0h1m0s"`, `"0h01m00s"`, `"0h1m"`}
#'   \item{`"1m0s"`, `"1m"`}
#'   \item{`"60s"`, `60`}
#' }
#'
#' Please note that for Vimeo, you can specify a start time, but you can not
#' specify that the video be paused at this time. In other words, it is like
#' "autoplay" is set to `TRUE`, and you cannot unset it.
#'
#' @rdname use_start_time
#' @param ...         generic arguments to pass through
#' @param embed       `vembedr_embed` object, created using an [embed()] function
#' @param start_time  `numeric` (seconds), or `character` (e.g. `"3m15s"`)
#' @param is_paused   `logical`, for "Channel 9" specifies if the video
#'   should be paused at this time
#'
#' @inherit embed return
#'
#' @export
#' @examples
#'   rickroll_youtube() %>%
#'     use_start_time("3m32s")
#'
use_start_time <- function(embed, ...) UseMethod("use_start_time")


#' @rdname use_start_time
#' @export
#'
use_start_time.default <- function(embed, ...) "Unknown class"


