#' Embeds a popular video
#'
#' @param ... arguments passed on to \code{embed_foo}
#'
#' @return html code describing iframe
#'
#' @examples
#'   rickroll_vimeo()
#'   rickroll_youtube()
#'
#' @export
#
rickroll_vimeo <- function(...){
  embed_vimeo(id = "45196609", ...)
}

#' @rdname rickroll_vimeo
#' @export
#
rickroll_youtube <- function(...){
  embed_youtube(id = "dQw4w9WgXcQ", ...)
}
