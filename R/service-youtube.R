#' @rdname embed
#' @export
#
embed_youtube <- function(id,
                          width = NULL, height = 300, ratio = c("16by9", "4by3"),
                          frameborder = 0, allowfullscreen = TRUE,
                          query = NULL){

  ratio <- match.arg(ratio)
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

  embed <- create_embed(iframe, "vembedr_embed_youtube", ratio)

  embed
}

#' @rdname use_start_time
#' @export
#'
use_start_time.vembedr_embed_youtube <- function(embed, start_time, ...){

  # get the iframe
  iframe <- get_iframe(embed)

  # get the src from the iframe
  src <- htmltools::tagGetAttribute(iframe, "src")

  # parse the url
  url <- httr::parse_url(src)

  # set the time in url$query
  url$query$start <- .secs(start_time)

  # set the url in the iframe
  # == need to ask about a public API for this in htmltools ==
  iframe$attribs$src <- httr::build_url(url)

  # set the iframe in the embed
  embed <- set_iframe(embed, iframe)

  embed
}

.parse.vembedr_url_youtube <- function(url_parsed, ...) {
  list(
    service = "youtube",
    id = url_parsed$query$v,
    start_time = url_parsed$query$t
  )
}

.parse.vembedr_url_youtube_short <- function(url_parsed, ...) {
  list(
    service = "youtube",
    id = url_parsed$path,
    start_time = url_parsed$query$t
  )
}
