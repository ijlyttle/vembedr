
div_bs_responsive <- function(..., ratio = c("16by9", "4by3")) {

  ratio <- match.arg(ratio)

  class = glue::glue("embed-responsive embed-responsive-{ratio}")

  contents <- list(...)

  # need to find any <iframes> in any of the contents, then add
  # class "embed-responsive-item"

  htmltools::div(contents, class = class)
}



