#' Align horizontally
#'
#' Use this function to specify the horizontal alignment of the `<iframe/>`
#' within the enclosing `</div>`.
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
#' If your 'HTML` page includes
#' [Twitter Bootstrap 3](https://getbootstrap.com/docs/3.3/components/#responsive-embed),
#' you can use this function to make the size of the `<iframe/>` responsive
#' within the enclosing `</div>`.
#'
#' @inheritParams use_start_time
#' @param ratio `character`, indicates aspect ratio for the `<iframe/>`
#'
#' @inherit embed return
#' @export
#'
use_bs_responsive <- function(embed, ratio = c("16by9", "4by3")) {

  assertthat::assert_that(
    inherits(embed, "vembedr_embed"),
    msg = "embed is not a `vebmedr_embed` object"
  )

  ratio <- match.arg(ratio)

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



