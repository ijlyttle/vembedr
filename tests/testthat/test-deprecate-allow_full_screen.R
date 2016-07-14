context("deprecate-allow_full_screen")

## TODO: Rename context
## TODO: Add more tests

test_that("deprecate allow_full_screen", {
  expect_warning(rickroll_vimeo(allow_full_screen = TRUE))
  expect_warning(rickroll_youtube(allow_full_screen = TRUE))
})
