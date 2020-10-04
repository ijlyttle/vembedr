context("use_start_time")

youtube <- rickroll_youtube()
youtube_start <- use_start_time(youtube, "25s")

get_query <- function(embed) {
  iframe <- get_iframe(embed)
  src <- htmltools::tagGetAttribute(iframe, "src")
  url <- httr::parse_url(src)

  url$query
}

test_that("youtube works", {
  expect_identical(get_query(youtube_start), list(start="25"))
})

vimeo <- rickroll_vimeo()
vimeo_start <- use_start_time(vimeo, "1m3s")

get_fragment <- function(elem) {
  iframe <- get_iframe(elem)
  src <- htmltools::tagGetAttribute(iframe, "src")
  url <- httr::parse_url(src)

  url$fragment
}

test_that("vimeo works", {
  expect_identical(get_fragment(vimeo_start), "t=63")
})

test_that("box throws a warning", {

  emb_box <- embed_box("foo")

  expect_warning(use_start_time(emb_box, "25s"), "^Start time")
})

test_that("msstream works", {

  emb_msstream <- embed_msstream("foo") %>% use_start_time(10)

  expect_identical(
    get_query(emb_msstream)[["st"]],
    "10"
  )

})

