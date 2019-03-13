context("test-misc")

test_that("get_ratio() works", {

  expect_identical(get_ratio("16by9"), 16 / 9)
  expect_identical(get_ratio("4by3"), 4 / 3)

  expect_error(get_ratio("foo"), "should be one of")
})

test_that("get_width_height() works", {

  expect_identical(
    get_width_height(width = 500, height = 300, ratio = "16by9"),
    list(width = 500, height = 300)
  )

  expect_identical(
    get_width_height(width = NULL, height = 300, ratio = "16by9"),
    list(width = 533, height = 300)
  )

  expect_identical(
    get_width_height(width = 533, height = NULL, ratio = "16by9"),
    list(width = 533, height = 300)
  )



})
