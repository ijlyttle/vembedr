#' Embed a video into an HTML document
#'
#' These functions are used to embed video into your \strong{rmarkdown} html-documents,
#' or into your \strong{shiny} apps. There are functions to embed from
#' YouTube, Vimeo, and Microsoft Channel 9 (who host the UseR! 2016 videos).
#'
#' These services allow you to customize a lot of things by specifying
#' an optional query string. The specification for the query string will differ
#' according to the service being used:
#'
#' \describe{
#'   \item{YouTube}{\url{https://developers.google.com/youtube/player_parameters}}
#'   \item{Vimeo}{\url{https://developer.vimeo.com/player/embedding}}
#'   \item{Channel 9}{\url{https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Forty-years-of-S}
#'   (click the \emph{Embed} tab)}
#'   \item{Box}{\url{https://developer.box.com/docs/box-embed#section-build-box-embed-programatically}}
#' }
#'
#' @param id                character, identifier provided by the service
#' @param custom_domain     character, (used by Box) name of Box-instance
#'   to use. If \code{NULL}, will use the value of
#'   \code{getOption("vembedr.box_custom_domain")}. This can be useful if you
#'   are using a corporate instance of Box. If still \code{NULL}, will use
#'   \code{"cloud"}, the standard Box instance.
#' @param height            numeric, height of iframe (px)
#' @param width             numeric, width of iframe (px)
#' @param frameborder       numeric, size of frame border (px)
#' @param allowfullscreen   logical, indicates if to allow fullscreen
#' @param query             list of items to include in url-query string
#' @param fragment          character, string to include as url-fragment
#'
#' @return An embed object that prints an \code{htmltools::\link[htmltools]{tags}$iframe} element
#'
#' @name embed
#' @family embed
#' @seealso \code{\link{use_start_time}}
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#' embed_vimeo("45196609")
#' embed_user2016("Literate-Programming")
#' embed_user2017("Room-202-Lightning-Talks") %>% use_start_time("26m35s")
#'
NULL

#' @rdname embed
#' @export
#
embed_vimeo <- function(id, width = 500, height = 281,
                        frameborder = 0, allowfullscreen = TRUE,
                        query = NULL, fragment = NULL){

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  url <- httr::parse_url("https://player.vimeo.com/video")

  # update url
  url$path <- paste(url$path, id, sep = "/")
  url$query <- query
  url$fragment <- fragment

  embed <- htmltools::tags$iframe(
    class = "vimeo-embed",
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
                          frameborder = 0, allowfullscreen = TRUE,
                          query = NULL){

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
                           frameborder = 0, allowfullscreen = TRUE){

  id <- c("Events", "useR-international-R-User-conference", "useR2016", id)

  embed_channel9(id, width, height, frameborder, allowfullscreen)
}

#' @rdname embed
#' @export
#
embed_user2017 <- function(id, width = 560, height = 315,
                           frameborder = 0, allowfullscreen = TRUE){

  id <- c(
    "Events",
    "useR-international-R-User-conferences",
    "useR-International-R-User-2017-Conference",
    id
  )

  embed_channel9(id, width, height, frameborder, allowfullscreen)
}

#' @rdname embed
#' @export
#'
embed_channel9 <- function(id, width = 560, height = 315,
                           frameborder = 0, allowfullscreen = TRUE){

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

#' @rdname embed
#' @export
#'
embed_box <- function(id, custom_domain = NULL, width = 500, height = 330,
                      frameborder = 0, allowfullscreen = TRUE) {

  # adapted from:
  # https://developer.box.com/docs/box-embed#section-build-box-embed-programatically

  # <iframe
  #    src="https://{custom_domain}.app.box.com/embed/s/{shared link value}"
  #    width="{pixels}"
  #    height="{pixels}"
  #    frameborder="0"
  #    allowfullscreen webkitallowfullscreen msallowfullscreen>
  # </iframe>

  custom_domain <- custom_domain %||% getOption("vembedr.box_custom_domain")

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  host <- "app.box.com"
  if (!is.null(custom_domain)) {
    host <- "{custom_domain}.app.box.com"
  }

  url <- glue::glue("https://{host}/embed/s/{id}")

  embed <- htmltools::tags$iframe(
    src = url,
    width = width,
    height = height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen,
    webkitallowfullscreen = allowfullscreen,
    msallowfullscreen = allowfullscreen
  )

  class(embed) <- c("embed_box", class(embed))

  embed
}
