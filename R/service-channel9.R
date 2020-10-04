#' @rdname embed
#' @export
#'
embed_channel9 <- function(id,
                           width = NULL, height = 300, ratio = c("16by9", "4by3"),
                           frameborder = 0, allowfullscreen = TRUE){

  ratio <- match.arg(ratio)
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

  embed <- create_embed(iframe, "vembedr_embed_channel9", ratio)

  embed
}

#' @rdname use_start_time
#' @export
#'
use_start_time.vembedr_embed_channel9 <- function(embed, start_time, is_paused = TRUE, ...){

  # get the iframe
  iframe <- get_iframe(embed)

  # get the src from the iframe
  src <- htmltools::tagGetAttribute(iframe, "src")

  # parse the url
  url <- httr::parse_url(src)

  # set the time in url$fragment
  frag <- paste("time", .hms(start_time), sep = "=")

  if (is_paused){
    frag <- paste(frag, "paused", sep = ":")
  }

  url$fragment <- frag

  # set the url in the iframe
  # == need to ask about a public API for this in htmltools ==
  iframe$attribs$src <- httr::build_url(url)

  # set the iframe in the embed
  embed <- set_iframe(embed, iframe)

  embed
}

.parse.vembedr_url_channel9 <- function(url_parsed, ...){

  path_split <-
    url_parsed$path %>%
    strsplit("/") %>%
    `[[`(1)

  path_user2016 <-
    c("Events", "useR-international-R-User-conference", "useR2016")

  path_user2017 <-c(
    "Events",
    "useR-international-R-User-conferences",
    "useR-International-R-User-2017-Conference"
  )

  if (identical(length(path_split), 4L)
      && identical(path_split[1:3], path_user2016)) {
    # this is a UseR!2016 link
    result <- list(
      service = "user2016",
      id = path_split[[4]],
      start_time = NULL
    )
  } else if (identical(path_split[1:3], path_user2017)) {
    # this is a UseR!2017 link
    result <- list(
      service = "user2017",
      id = path_split[[4]],
      start_time = NULL
    )
  }
  else {
    # this is a regular Channel 9 link
    result <- list(
      service = "channel9",
      id = url_parsed$path,
      start_time = NULL
    )
  }

  result
}

