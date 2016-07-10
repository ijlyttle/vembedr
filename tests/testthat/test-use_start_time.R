context("use_start_time")

youtube <- rickroll_youtube()
youtube_start <- use_start_time(youtube, "25s")

get_query <- function(elem){
  src <- htmltools::tagGetAttribute(elem, "src")
  url <- httr::parse_url(src)

  url$query
}

test_that("youtube works", {
  expect_identical(get_query(youtube_start), list(start="25"))
})

vimeo <- rickroll_vimeo()
vimeo_start <- use_start_time(vimeo, "1m3s")

get_fragment <- function(elem){
  src <- htmltools::tagGetAttribute(elem, "src")
  url <- httr::parse_url(src)

  url$fragment
}

test_that("vimeo works", {
  expect_identical(get_fragment(vimeo_start), "at=63")
})

