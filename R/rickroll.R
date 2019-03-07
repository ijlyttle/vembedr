#' Embed a popular video
#'
#' If you want to experiment with the arguments to \code{\link{embed}},
#' such as \code{query}, but do not have a particular video in mind, this function
#' may be useful to you.
#'
#' @param ... arguments (other than \code{id}) passed on to \code{\link{embed}}
#'
#' @return An embed object that prints an \code{htmltools::\link[htmltools]{tags}$iframe} element
#'
#' @name rickroll
#' @examples
#'   rickroll_vimeo()
#'   rickroll_youtube()
#'   rickroll_channel9()
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
  embed_youtube(id = "DLzxrzFCyOs", ...)
}

#' @rdname rickroll
#' @export
#
rickroll_channel9 <- function(...){
  embed_channel9(
    id = c("Blogs", "Dan", "BlueHat-v7-Katie-Moussouris-interviews-Dan-Kaminsky-on-some-interesting-research-hes-been-doing-late"),
    ...
  ) %>%
    use_start_time("05m08s")
}
