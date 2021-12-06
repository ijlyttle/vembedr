#' @rdname embed
#' @export
#
embed_msstream <- function(id, width = NULL, height = 300,
                           ratio = c("16by9", "4by3"), query = NULL){

  ratio <- match.arg(ratio)
  dim <- get_width_height(width, height, ratio)

  url <- httr::parse_url("https://web.microsoftstream.com/embed/video")

  url$path <- glue::glue("{url$path}/{id}")
  url$query <- c(list(autoplay = "false", showinfo = "true"), query)

  iframe <- htmltools::tags$iframe(
    src = httr::build_url(url),
    width = dim$width,
    height = dim$height,
    allowfullscreen = NULL,
    style = "border:none;",
    `data-external` = 1
  )

  embed <- create_embed(iframe, "vembedr_embed_msstream", ratio)

  embed
}

#' @rdname use_start_time
#' @export
#'
use_start_time.vembedr_embed_msstream <- function(embed, start_time, ...){

  # get the iframe
  iframe <- get_iframe(embed)

  # get the src from the iframe
  src <- htmltools::tagGetAttribute(iframe, "src")

  # parse the url
  url <- httr::parse_url(src)

  # set the time in url$query
  url$query$st <- .secs(start_time)

  # set the url in the iframe
  # == need to ask about a public API for this in htmltools ==
  iframe$attribs$src <- httr::build_url(url)

  # set the iframe in the embed
  embed <- set_iframe(embed, iframe)

  embed
}

.parse.vembedr_url_msstream <- function(url_parsed, ...) {

  path_split <- stringr::str_split(url_parsed$path, "/")[[1]]

  list(
    service = "msstream",
    id = path_split[[2]],
    start_time = url_parsed$query$st
  )
}
