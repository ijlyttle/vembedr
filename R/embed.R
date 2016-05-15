# helper function to convert logical into a character parameter
.convert_allowfullscreen <- function(x){

  if (x){
    result <- ""
  } else {
    result <- NULL
  }

  result
}

#' Creates an iframe for video-embedding
#'
#' @param id                character, url identifier
#' @param height            numeric, height of iframe (px)
#' @param width             numeric, width of iframe (px)
#' @param frameborder       numeric, size of frame border (px)
#' @param allow_full_screen logical, indicates if to allow fullscreen
#'
#' @return html code describing iframe
#' @examples
#' embed_vimeo("45196609")
#'
#' @export
#
embed_vimeo <- function(id, width = 500, height = 281,
                        frameborder = 0, allow_full_screen = TRUE){

  # consider other options to send as query parameters

  allowfullscreen <- .convert_allowfullscreen(allow_full_screen)

  htmltools::tags$iframe(
    src = paste0("https://player.vimeo.com/video/", as.character(id)),
    width = width,
    height = height,
    frameborder = frameborder,
    webkitallowfullscreen = allowfullscreen,
    mozallowfullscreen = allowfullscreen,
    allowfullscreen = allowfullscreen
  )
}

#' @rdname embed_vimeo
#'
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#'
#' @export
#
embed_youtube <- function(id, width = 420, height = 315,
                          frameborder = 0, allow_full_screen = TRUE){

  allowfullscreen <- .convert_allowfullscreen(allow_full_screen)

  htmltools::tags$iframe(
    src = paste0("https://www.youtube.com/embed/", as.character(id)),
    width = width,
    height = height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen
  )
}
