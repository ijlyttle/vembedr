context("test-div")

test_that("use_align() works", {

  emb <- rickroll_youtube()
  emb_new <- use_align(emb, "center")

  expect_error(use_align(emb, "down"))

  expect_is(emb_new, class(emb))
  expect_identical(get_iframe(emb), get_iframe(emb_new))
  expect_identical(emb_new$attribs$align, "center")
})
