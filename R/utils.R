# concatenates arguments, returns space-delimited string of unique items
to_html_class <- function(x, ...) {

  x <- c(x, ...)
  x <- unique(x)
  x <- glue::glue_collapse(x, sep = " ")
  x <- as.character(x)

  x
}
