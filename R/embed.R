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
#'   \item{YouTube}{<https://developers.google.com/youtube/player_parameters>}
#'   \item{Vimeo}{<https://developer.vimeo.com/player/embedding>}
#'   \item{Channel 9}{<https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Forty-years-of-S>
#'   (click the *Embed* tab)}
#'   \item{Box}{<https://developer.box.com/docs/box-embed#section-build-box-embed-programatically>}
#' }
#'
#' @param id                character, identifier provided by the service
#' @param custom_domain     character, (used by Box) name of Box-instance
#'   to use. It can be useful to use `getOption("vembedr.box_custom_domain")`
#'   if you are using a corporate instance of Box. If `NULL`, it will use
#'   the standard Box instance.
#' @param height            numeric, height of iframe (px)
#' @param width             numeric, width of iframe (px)
#' @param frameborder       numeric, size of frame border (px)
#' @param allowfullscreen   logical, indicates if to allow fullscreen
#' @param query             list of items to include in url-query string
#' @param fragment          character, string to include as url-fragment
#'
#' @return object with class `vembedr_embed`,
#'   prints to an 'HTML' `<div/>` that contains an `<iframe/>`
#'
#' @name embed
#' @family embed
#' @seealso [use_start_time()]
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#' embed_vimeo("45196609")
#' embed_user2016("Literate-Programming")
#' embed_user2017("Room-202-Lightning-Talks") %>% use_start_time("26m35s")
#' embed_box("m5do45hvzw32iv2aors3urf5pgkxxazx")
#'
NULL

#' @rdname embed
#' @export
#
embed_vimeo <- function(id,
                        width = NULL, height = 300, ratio = c("16by9", "4by3"),
                        frameborder = 0, allowfullscreen = TRUE,
                        query = NULL, fragment = NULL){

  dim <- get_width_height(width, height, ratio)

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  url <- httr::parse_url("https://player.vimeo.com/video")

  # update url
  url$path <- paste(url$path, id, sep = "/")
  url$query <- query
  url$fragment <- fragment

  iframe <- htmltools::tags$iframe(
    class = "vimeo-embed",
    src = httr::build_url(url),
    width = dim$width,
    height = dim$height,
    frameborder = frameborder,
    webkitallowfullscreen = allowfullscreen,
    mozallowfullscreen = allowfullscreen,
    allowfullscreen = allowfullscreen
  )

  embed <- create_embed(iframe, "vembedr_embed_vimeo")

  embed
}

#' @rdname embed
#' @export
#
embed_youtube <- function(id,
                          width = NULL, height = 300, ratio = c("16by9", "4by3"),
                          frameborder = 0, allowfullscreen = TRUE,
                          query = NULL){

  dim <- get_width_height(width, height, ratio)

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  url <- httr::parse_url("https://www.youtube.com/embed")

  url$path <- paste(url$path, id, sep = "/")
  url$query <- query

  iframe <- htmltools::tags$iframe(
    src = httr::build_url(url),
    width = dim$width,
    height = dim$height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen
  )

  embed <- create_embed(iframe, "vembedr_embed_youtube")

  embed
}

#' @rdname embed
#' @export
#
embed_user2016 <- function(id,
                           width = NULL, height = 300, ratio = c("16by9", "4by3"),
                           frameborder = 0, allowfullscreen = TRUE){

  id <- c("Events", "useR-international-R-User-conference", "useR2016", id)

  embed_channel9(id, width, height, ratio, frameborder, allowfullscreen)
}

#' @rdname embed
#' @export
#
embed_user2017 <- function(id,
                           width = NULL, height = 300, ratio = c("16by9", "4by3"),
                           frameborder = 0, allowfullscreen = TRUE){

  id <- c(
    "Events",
    "useR-international-R-User-conferences",
    "useR-International-R-User-2017-Conference",
    id
  )

  embed_channel9(id, width, height, ratio, frameborder, allowfullscreen)
}

#' @rdname embed
#' @export
#'
embed_channel9 <- function(id,
                           width = NULL, height = 300, ratio = c("16by9", "4by3"),
                           frameborder = 0, allowfullscreen = TRUE){

  dim <- get_width_height(width, height, ratio)

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  url <- httr::parse_url("https://channel9.msdn.com")

  url$path <- paste0(url$path, c(id, "player"), collapse = "/")

  iframe <- htmltools::tags$iframe(
    src = httr::build_url(url),
    width = dim$width,
    height = dim$height,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen
  )

  embed <- create_embed(iframe, "vembedr_embed_channel9")

  embed
}

#' @rdname embed
#' @export
#'
embed_box <- function(id, custom_domain = getOption("vembedr.box_custom_domain"),
                      width = NULL, height = 300, ratio = c("16by9", "4by3"),
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

  dim <- get_width_height(width, height, ratio)

  allowfullscreen <- .convert_allowfullscreen(allowfullscreen)

  host <- "app.box.com"
  if (!is.null(custom_domain)) {
    host <- "{custom_domain}.app.box.com"
  }

  url <- glue::glue("https://{host}/embed/s/{id}")

  iframe <- htmltools::tags$iframe(
    src = url,
    width = dim$width,
    height = dim$height + 60,
    frameborder = frameborder,
    allowfullscreen = allowfullscreen,
    webkitallowfullscreen = allowfullscreen,
    msallowfullscreen = allowfullscreen
  )

  embed <- create_embed(iframe, "vembedr_embed_box")

  embed
}


create_embed <- function(iframe, name) {

  embed <- htmltools::div(
    htmltools::div(iframe)
  )

  class(embed) <- c(name,  "vembedr_embed", class(embed))

  embed
}
