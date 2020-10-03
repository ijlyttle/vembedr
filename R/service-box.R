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

  ratio <- match.arg(ratio)
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

  embed <- create_embed(iframe, "vembedr_embed_box", ratio)

  embed
}


#' @rdname use_start_time
#' @export
#'
use_start_time.vembedr_embed_box <- function(embed, ...) {

  warning("Start time cannot be specified for Box.")

  embed
}


.parse.vembedr_box <- function(url_parsed, ...) {

  # determine custom-domain by taking apart hostname
  hostname_split <- stringr::str_split(url_parsed$hostname, "\\.")[[1]]

  custom_domain <- NULL
  if (identical(length(hostname_split), 4L)) {
    custom_domain <- hostname_split[1]
  }

  # determine id by taking apart path
  path_split <- stringr::str_split(url_parsed$path, "/")[[1]]

  id <- path_split[2]

  result <- list(
    service = "box",
    id = id,
    custom_domain = custom_domain,
    start_time = NULL
  )

  result
}
