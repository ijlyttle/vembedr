context("test-div")

library("conflicted")
library("htmltools")

test_that("use_align() works", {

  emb <- rickroll_youtube()
  emb_new <- use_align(emb, "center")

  expect_error(use_align(emb, "down"))

  expect_is(emb_new, class(emb))
  expect_identical(get_iframe(emb), get_iframe(emb_new))
  expect_identical(emb_new$attribs$align, "center")
})

test_that("use_bs_responsive() works", {

  emb <- rickroll_youtube()
  emb_new <- use_bs_responsive(emb, "4by3")

  expect_error(use_align(emb, "down"))

  expect_is(emb_new, class(emb))

  expect_identical(
    tagGetAttribute(emb_new, "class"),
    "embed-responsive embed-responsive-4by3"
  )

  expect_identical(
    tagGetAttribute(get_iframe(emb_new), "class"),
    "embed-responsive-item"
  )
})

