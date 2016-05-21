#' Embeds a popular video
#'
#' If you want to experiment with the arguments to \code{\link{embed}},
#' such as \code{query}, but do not have a particular video in mind, this function
#' may be useful to you.
#'
#' @param ... arguments (other than \code{id}) passed on to \code{\link{embed}}
#'
#' @return html \code{<iframe>} element
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
  embed_vimeo(id = "45196609", ...)
}

#' @rdname rickroll
#' @export
#
rickroll_youtube <- function(...){
  embed_youtube(id = "dQw4w9WgXcQ", ...)
}
