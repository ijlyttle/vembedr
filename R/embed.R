#' Creates an iframe for video-embedding
#'
#' These functions are used to embed video into your RMarkdown html documents,
#' or into your Shiny apps. There are currently functions for you to embed from
#' either YouTube or Vimeo.
#'
#' Both of these services allow you to customize a lot of things by specifying
#' an optional query string. The specification for the query string will differ
#' according to the service being used:
#'
#' \describe{
#'   \item{YouTube}{\url{https://developers.google.com/youtube/player_parameters}}
#'   \item{Vimeo}{\url{https://developer.vimeo.com/player/embedding}}
#' }
#'
#' @param id                character, identifier provided by the service
#' @param height            numeric, height of iframe (px)
#' @param width             numeric, width of iframe (px)
#' @param frameborder       numeric, size of frame border (px)
#' @param allow_full_screen logical, indicates if to allow fullscreen
#'   (deprecated in favor of \code{allowfullscreen})
#' @param allowfullscreen logical, indicates if to allow fullscreen
#' @param query             list of items to include in url-query string
#' @param fragment          character, string to include as url-fragment
#'
#' @return html \code{<iframe>} element
#'
#' @name embed
#' @family embed
#' @examples
#' embed_vimeo("45196609")
#' embed_youtube("dQw4w9WgXcQ")
#' embed_user2016("Literate-Programming")
#' embed_youtube("8SGif63VW6E", query = list(start = secs("4m12s")))
#'
NULL

#' @rdname embed
#' @export
#
embed_vimeo <- function(id, width = 500, height = 281,
                        frameborder = 0, allow_full_screen = TRUE,
                        allowfullscreen = TRUE,
                        query = NULL, fragment = NULL){

  if (!missing(allow_full_screen)){
    warning(
      "argument allow_full_screen is deprecated; please use allowfullscreen instead.",
      call. = FALSE
    )
    allowfullscreen <- allow_full_screen
  }

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  url <- httr::parse_url("https://player.vimeo.com/video")

  # update url
  url$path <- paste(url$path, id, sep = "/")
  url$query <- query
  url$fragment <- fragment

  embed <- htmltools::tags$iframe(
    src = httr::build_url(url),
    width = width,
    height = height,
    frameborder = frameborder,
    webkitallowfullscreen = allowfullscreen,
    mozallowfullscreen = allowfullscreen,
    allowfullscreen = allowfullscreen
  )

  class(embed) <- c("embed_vimeo", class(embed))

  embed
}

#' @rdname embed
#' @export
#
embed_youtube <- function(id, width = 420, height = 315,
                          frameborder = 0, allow_full_screen = TRUE,
                          allowfullscreen = TRUE,
                          query = NULL){

  if (!missing(allow_full_screen)){
    warning(
      "argument allow_full_screen is deprecated; please use allowfullscreen instead.",
      call. = FALSE
    )
    allowfullscreen <- allow_full_screen
  }

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  url <- httr::parse_url("https://www.youtube.com/embed")

  url$path <- paste(url$path, id, sep = "/")
  url$query <- query

  embed <- htmltools::tags$iframe(
    src = httr::build_url(url),
    width = width,
    height = height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen
  )

  class(embed) <- c("embed_youtube", class(embed))

  embed
}

#' @rdname embed
#' @export
#
embed_user2016 <- function(id, width = 560, height = 315,
                           frameborder = 0, allow_full_screen = TRUE){

  id <- c("Events", "useR-international-R-User-conference", "useR2016", id)

  embed_channel9(id, width, height, frameborder, allow_full_screen)
}

#' @rdname embed
#' @export
#'
embed_channel9 <- function(id, width = 560, height = 315,
                           frameborder = 0,
                           allow_full_screen = TRUE, allowfullscreen = TRUE){

  if (!missing(allow_full_screen)){
    warning(
      "argument allow_full_screen is deprecated; please use allowfullscreen instead.",
      call. = FALSE
    )
    allowfullscreen <- allow_full_screen
  }

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)


  url <- httr::parse_url("https://channel9.msdn.com")

  url$path <- paste0(url$path, c(id, "player"), collapse = "/")

  embed <- htmltools::tags$iframe(
    src = httr::build_url(url),
    width = width,
    height = height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen
  )

  class(embed) <- c("embed_channel9", class(embed))

  embed
}
