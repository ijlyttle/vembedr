
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

div_bs_responsive <- function(..., ratio = c("16by9", "4by3")) {

  ratio <- match.arg(ratio)

  class = glue::glue("embed-responsive embed-responsive-{ratio}")

  contents <- list(...)

  # need to find any <iframes> in any of the contents, then add
  # class "embed-responsive-item"

  htmltools::div(contents, class = class)
}



