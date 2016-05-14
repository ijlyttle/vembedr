#' Creates an iframe for video-embedding
#'
#' @param id       character, vimeo_id
#' @param height   numeric, height of iframe (pixels)
#' @param width    numeric, width of iframe (pixels)
#'
#' @return html code describing iframe
#' @examples
#' embed_vimeo(45196609)
#'
#' @export
#
embed_vimeo <- function(id, width = 500, height = 281){

  htmltools::tags$iframe(
    src = paste0("https://player.vimeo.com/video/", as.character(id)),
    width = as.character(width),
    height = as.character(height),
    frameborder = 0,
    webkitallowfullscreen = "",
    mozallowfullscreen = "",
    allowfullscreen = ""
  )
}

#' @rdname embed_vimeo
#'
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#'
#' @export
#
embed_youtube <- function(id, width = 420, height = 315){

  htmltools::tags$iframe(
    src = paste0("https://www.youtube.com/embed/", as.character(id)),
    width = as.character(width),
    height = as.character(height),
    frameborder = 0,
    allowfullscreen = ""
  )
}
