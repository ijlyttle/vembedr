#' Creates an iframe for video-embedding
#'
#' @param id                character, url identifier
#' @param height            numeric, height of iframe (px)
#' @param width             numeric, width of iframe (px)
#' @param frameborder       numeric, size of frame border (px)
#' @param allow_full_screen logical, indicates if to allow fullscreen
#' @param query             list of items to include in query string
#'
#' @return html code describing iframe
#' @examples
#' embed_vimeo("45196609")
#'
#' @export
#
embed_vimeo <- function(id, width = 500, height = 281,
                        frameborder = 0, allow_full_screen = TRUE,
                        query = NULL){

  allowfullscreen <- .convert_allowfullscreen(allow_full_screen)

  url <- httr::parse_url("https://player.vimeo.com/video")

  # update url
  url$path <- paste(url$path, id, sep = "/")
  url$query <- query

  htmltools::tags$iframe(
    src = httr::build_url(url),
    width = width,
    height = height,
    frameborder = frameborder,
    webkitallowfullscreen = allowfullscreen,
    mozallowfullscreen = allowfullscreen,
    allowfullscreen = allowfullscreen
  )
}

#' Creates an iframe for video-embedding
#'
#' @inheritParams  embed_vimeo
#'
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#'
#' @export
#
embed_youtube <- function(id, width = 420, height = 315,
                          frameborder = 0, allow_full_screen = TRUE,
                          query = NULL){

  allowfullscreen <- .convert_allowfullscreen(allow_full_screen)

  url <- httr::parse_url("https://www.youtube.com/embed")

  url$path <- paste(url$path, id, sep = "/")
  url$query <- query

  htmltools::tags$iframe(
    src = httr::build_url(url),
    width = width,
    height = height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen
  )
}
