## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library("fs")

dir_source <- here::here("man/figures")
dir_target <- here::here("vignettes")
dir_target_figures <- file.path(dir_target, "figures")

if (dir_exists(dir_target_figures)) {
  dir_delete(dir_target_figures)
}

dir_copy(dir_source, dir_target)

## ------------------------------------------------------------------------
library("htmltools")
library("vembedr")

## ------------------------------------------------------------------------
rickroll_youtube() %>%
  use_align("center")

