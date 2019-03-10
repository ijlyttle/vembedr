#' Accessor methods for iframe
#'
#' @name iframe
#'
#' @inheritParams use_start_time
#' @param iframe `shiny.tag` with `name` `"iframe"`, object to be set
#' @param ... other args as needed
#'
#' @return
#' \describe{
#'   \item{get_iframe}{`shiny.tag` with `name` `"iframe"`, created using [htmltools::tags]`$iframe()`}
#'   \item{set_iframe}{`embed` object}
#' }
#' @keywords internal
#' @export
#'
get_iframe <- function(embed, ...) {
  UseMethod("get_iframe", embed)
}

#' @rdname iframe
#' @export
#'
get_iframe.default <- function(embed, ...) {
  stop(
    glue::glue("Cannot get_iframe() for object of type {class(embed)}"),
    call. = FALSE
  )
}

#' @rdname iframe
#' @export
#'
get_iframe.vembedr_embed <- function(embed, ...) {
  embed[["children"]][[1]][["children"]][[1]]
}

#' @rdname iframe
#' @export
#'
set_iframe <- function(embed, ...) {
  UseMethod("set_iframe", embed)
}

#' @rdname iframe
#' @export
#'
set_iframe.default <- function(embed, ...) {
  stop(
    glue::glue("Cannot set_iframe() for object of type {class(embed)}"),
    call. = FALSE
  )
}

#' @rdname iframe
#' @export
#'
set_iframe.vembedr_embed <- function(embed, iframe, ...) {

  assertthat::assert_that(
    inherits(iframe, "shiny.tag"),
    assertthat::are_equal(iframe$name, "iframe"),
    msg = "iframe is not an `iframe`"
  )

  embed[["children"]][[1]][["children"]][[1]] <- iframe

  embed
}

