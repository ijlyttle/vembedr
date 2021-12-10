#' Embed popular video
#'
#' If you want to experiment with the arguments to [embed()],
#' such as `query`, but do not have a particular video in mind, this function
#' may be useful to you.
#'
#' Please note that the YouTube video seems no longer embeddable.
#'
#' @param ... arguments (other than `id`) passed on to [embed()]
#'
#' @return An embed object that prints an \code{htmltools::\link[htmltools]{tags}$iframe} element
#'
#' @name rickroll
#' @examples
#'   rickroll_vimeo()
#'   rickroll_youtube()
#'
NULL

#' @rdname rickroll
#' @export
#
rickroll_vimeo <- function(...){
  embed_vimeo(id = "148751763", ...)
}

#' @rdname rickroll
#' @export
#
rickroll_youtube <- function(...){
  embed_youtube(id = "iik25wqIuFo", ...)
}

#' @rdname embed_channel9
#' @export
#
rickroll_channel9 <- function(...){

  lifecycle::deprecate_warn(
    "1.5.0",
    "rickroll_channel9()",
    details = c(
      i = "Microsoft made breaking changes to its Channel 9 service.",
      i = "See <https://docs.microsoft.com/en-us/teamblog/channel9joinedmicrosoftlearn>."
    ),
    id = "channel_9"
  )

  embed_channel9(
    id = c("Blogs", "Dan", "BlueHat-v7-Katie-Moussouris-interviews-Dan-Kaminsky-on-some-interesting-research-hes-been-doing-late"),
    ...
  ) %>%
    use_start_time("05m08s")
}
