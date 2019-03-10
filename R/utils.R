# concatenates arguments, returns space-delimited string of unique items
to_html_class <- function(x, ...) {

  x <- c(x, ...)
  x <- unique(x)
  x <- glue::glue_collapse(x, sep = " ")
  x <- as.character(x)

  x
}

# define html-dependency
vembedr_dependency <-
  htmltools::htmlDependency(
    name = "vembedr",
    version = packageVersion("vembedr"),
    src = "vembedr",
    stylesheet = c("css/vembedr.css"),
    package = "vembedr"
  )
