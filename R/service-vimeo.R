#' @rdname embed
#' @export
#
embed_vimeo <- function(id,
                        width = NULL, height = 300, ratio = c("16by9", "4by3"),
                        frameborder = 0, allowfullscreen = TRUE,
                        query = NULL, fragment = NULL){

  ratio <- match.arg(ratio)
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

  embed <- create_embed(iframe, "vembedr_embed_vimeo", ratio)

  embed
}

#' @rdname use_start_time
#' @export
#'
use_start_time.vembedr_embed_vimeo <- function(embed, start_time, ...){

  # get the iframe
  iframe <- get_iframe(embed)

  # get the src from the iframe
  src <- htmltools::tagGetAttribute(iframe, "src")

  # parse the url
  url <- httr::parse_url(src)

  # set the time in url$fragment
  url$fragment <- paste0("t=", .secs(start_time))

  # set the url in the iframe
  # == need to ask about a public API for this in htmltools ==
  iframe$attribs$src <- httr::build_url(url)

  # set the iframe in the embed
  embed <- set_iframe(embed, iframe)

  embed
}

.parse.vembedr_url_vimeo <- function(url_parsed, ...){

  start_time <- NULL
  if (!is.null(url_parsed$fragment)){
    start_time <- sub("^t=", "", url_parsed$fragment) # removes leading "t="
  }

  list(
    service = "vimeo",
    id = url_parsed$path,
    start_time = start_time
  )
}
