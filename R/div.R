#' Align horizontally
#'
#' Use this function to specify the horizontal alignment of the `iframe`
#' within the enclosing `div`.
#'
#' @inheritParams use_start_time
#' @param align `character`, indicates type of alignment
#'
#' @inherit embed return
#' @export
#'
use_align <- function(embed,
                      align = c("left", "right", "center", "justified")) {

  assertthat::assert_that(
    inherits(embed, "vembedr_embed"),
    msg = "embed is not a `vebmedr_embed` object"
  )

  align <- match.arg(align)

  embed[["attribs"]][["align"]] <- align

  embed
}

#' Make size responsive
#'
#' If your HTML page includes
#' [Twitter Bootstrap 3](https://getbootstrap.com/docs/3.3/components/#responsive-embed),
#' you can use this function to make the size of the `iframe` responsive
#' within the enclosing `div`.
#'
#' @inheritParams use_start_time
#'
#' @inherit embed return
#' @export
#'
use_bs_responsive <- function(embed) {

  assertthat::assert_that(
    inherits(embed, "vembedr_embed"),
    msg = "embed is not a `vebmedr_embed` object"
  )

  # ratio is set when we create the embed
  ratio <- attr(embed, "ratio")

  class_div <- c(
    "embed-responsive",
    glue::glue("embed-responsive-{ratio}")
  )

  class_iframe <- "embed-responsive-item"

  # add the class to the div
  embed[["attribs"]][["class"]] <-
    to_html_class(embed[["attribs"]][["class"]], class_div)

  # add the class to the iframe
  iframe <- get_iframe(embed)

  iframe[["attribs"]][["class"]] <-
    to_html_class(iframe[["attribs"]][["class"]], class_iframe)

  embed <- set_iframe(embed, iframe)

  embed
}

#' Make rounded corners
#'
#' You can use this function to make rounded corners for the enclosing `</div>`.
#'
#' @inheritParams use_start_time
#' @param radius `numeric` or `character`, css property for the border-radius
#'   for the `<iframe/>`. Numeric values will be interpreted as number of pixels.
#'
#' @inherit embed return
#' @export
#'
use_rounded <- function(embed, radius = NULL) {

  assertthat::assert_that(
    inherits(embed, "vembedr_embed"),
    msg = "embed is not a `vebmedr_embed` object"
  )

  # cast numeric radius as number of pixels
  if (is.numeric(radius)) {
    radius <- glue::glue("{radius}px")
  }

  # if we do this again, make an accessor
  div <- embed[["children"]][[1]]

  # add the class to the div
  div[["attribs"]][["class"]] <-
    to_html_class(div[["attribs"]][["class"]], "vembedr-rounded")

  # if we have a user-specified radius, use it
  if (!is.null(radius)) {
    div <-
      htmltools::tagAppendAttributes(
        div,
        style = as.character(glue::glue("border-radius: {radius};"))
      )
  }

  embed[["children"]][[1]] <- div

  embed
}
