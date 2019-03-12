# determine height, width
get_width_height <- function(width = NULL, height = 300,
                             ratio = c("16by9", "4by3")) {

  ratio <- get_ratio(ratio)

  # width and height cannot both be NULL
  assertthat::assert_that(
    !(is.null(width) && is.null(height)),
    msg = "Both width and height cannot be NULL."
  )

  if (is.null(width)) {
    width <- round(height * ratio)
  }

  if (is.null(height)) {
    height <- round(width / ratio)
  }

  list(width = width, height = height)
}

get_ratio <- function(ratio = c("16by9", "4by3")) {

  if (is.character(ratio)) {
    ratio <- match.arg(ratio)

    ratio_catalog <- list(`16by9` = 16 / 9, `4by3` = 4 / 3)

    ratio <- ratio_catalog[[ratio]]
  }

  ratio <- as.numeric(ratio)

  assertthat::assert_that(
    assertthat::is.scalar(ratio)
  )

  ratio
}
