context("secs")

test_that("secs function works", {
  expect_equal(secs("15"), 15)
  expect_equal(secs("15s"), 15)
  expect_equal(secs("1m"), 60)
  expect_equal(secs("3m15s"), 195)
  expect_equal(secs("1h3m15s"), 3795)
})
