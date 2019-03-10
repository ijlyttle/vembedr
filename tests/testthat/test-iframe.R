context("test-iframe")

emb_youtube <- rickroll_youtube()
emb_vimeo <- rickroll_vimeo()

iframe_youtube <- get_iframe(emb_youtube)

test_that("getting an iframe works", {
  expect_is(iframe_youtube, "shiny.tag")
  expect_identical(iframe_youtube$name, "iframe")
})

test_that("setting an iframe works", {

  emb_youtube_new <- set_iframe(emb_vimeo, iframe_youtube)

  expect_identical(get_iframe(emb_youtube_new), iframe_youtube)
})

