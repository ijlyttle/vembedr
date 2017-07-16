context("secs-hms")


test_that(".secs function works", {
  expect_equal(.secs("15"), 15)
  expect_equal(.secs("15s"), 15)
  expect_equal(.secs("1m"), 60)
  expect_equal(.secs("3m15s"), 195)
  expect_equal(.secs("1h3m15s"), 3795)
})

test_that(".hms function works", {
  expect_identical(.hms(3810), "1h3m30s")
  expect_identical(.hms("3810"), "1h3m30s")
  expect_identical(.hms("3m15s"), "0h3m15s")
  expect_identical(.hms("3m"), "0h3m0s")
})


