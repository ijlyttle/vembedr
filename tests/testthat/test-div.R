context("test-div")

library("conflicted")
library("htmltools")

test_that("embed functions set a ratio", {

  ratio <- function(x) {
    attr(x, "ratio")
  }

  expect_identical(ratio(rickroll_youtube()), "16by9")
  expect_identical(ratio(rickroll_vimeo()), "16by9")
  expect_identical(ratio(embed_box("foo")), "16by9")
})

test_that("use_align() works", {

  emb <- rickroll_youtube()
  emb_new <- use_align(emb, "center")

  expect_error(use_align(emb, "down"))

  expect_is(emb_new, class(emb))
  expect_identical(get_iframe(emb), get_iframe(emb_new))
  expect_identical(emb_new$attribs$align, "center")
})

test_that("use_bs_responsive() works", {

  emb <- rickroll_youtube(ratio = "4by3")
  emb_new <- use_bs_responsive(emb)

  expect_error(use_align(emb, "down"))

  expect_is(emb_new, class(emb))

  expect_identical(
    tagGetAttribute(emb_new, "class"),
    "vembedr embed-responsive embed-responsive-4by3"
  )

  expect_identical(
    tagGetAttribute(get_iframe(emb_new), "class"),
    "embed-responsive-item"
  )
})

test_that("use_rounded() works", {

  emb <- rickroll_youtube()
  emb_standard <- use_rounded(emb)
  emb_user <- use_rounded(emb, 10)

  # iframe remains unchanged
  expect_identical(get_iframe(emb), get_iframe(emb_standard))

  # we have attached the html dependency
  expect_true(is.list(attr(emb_standard, "html_dependencies")))

  # the interior div has right class
  expect_identical(
    htmltools::tagGetAttribute(emb_standard[["children"]][[1]], "class"),
    "vembedr-rounded"
  )

  # setting the radius
  expect_identical(
    htmltools::tagGetAttribute(emb_user[["children"]][[1]], "style"),
    "border-radius: 10px;"
  )

})

