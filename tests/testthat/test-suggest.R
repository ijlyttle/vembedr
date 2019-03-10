context("suggest")

####
url_youtube <- "https://www.youtube.com/watch?v=1-vcErOPofQ"

list_parse_youtube <- list(
  service = "youtube",
  id = "1-vcErOPofQ",
  start_time = NULL
)

list_suggest_youtube <- list(
  embed = "embed_youtube(\"1-vcErOPofQ\")",
  start_time = NULL
)

####
url_youtube_short_time <- "https://youtu.be/1-vcErOPofQ?t=28s"

list_parse_youtube_short_time <- list(
  service = "youtube",
  id = "1-vcErOPofQ",
  start_time = "28s"
)

list_suggest_youtube_short_time <- list(
  embed = "embed_youtube(\"1-vcErOPofQ\")",
  start_time = "use_start_time(\"28s\")"
)

####
url_vimeo_time <- "https://vimeo.com/131407894#t=6s"

list_parse_vimeo_time <- list(
  service = "vimeo",
  id = "131407894",
  start_time = "6s"
)

list_suggest_vimeo_time <- list(
  embed = "embed_vimeo(\"131407894\")",
  start_time = "use_start_time(\"6s\")"
)

####
url_channel9 <- "https://channel9.msdn.com/Shows/Going+Deep/Brian-Beckman-Dont-fear-the-Monads"

list_parse_channel9 <- list(
  service = "channel9",
  id = "Shows/Going+Deep/Brian-Beckman-Dont-fear-the-Monads",
  start_time = NULL
)

list_suggest_channel9 <- list(
  embed = "embed_channel9(\"Shows/Going+Deep/Brian-Beckman-Dont-fear-the-Monads\")",
  start_time = NULL
)

####
url_user2016 <- "https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM?ocid=player"

list_parse_user2016 <- list(
  service = "user2016",
  id = "Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM",
  start_time = NULL
)

list_suggest_user2016 <- list(
  embed = "embed_user2016(\"Day-3-Siepr-130-Ligtning-Talks-100-PM-140-PM\")",
  start_time = NULL
)

url_user2017 <- "https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/Room-202-Lightning-Talks"

list_parse_user2017 <- list(
  service = "user2017",
  id = "Room-202-Lightning-Talks",
  start_time = NULL
)

list_suggest_user2017 <- list(
  embed = "embed_user2017(\"Room-202-Lightning-Talks\")",
  start_time = NULL
)

####
url_box <- "https://app.box.com/s/m5do45hvzw32iv2aors3urf5pgkxxazx"
url_box_acme <- "https://acme.app.box.com/s/m5do45hvzw32iv2aors3urf5pgkxxazx"

list_parse_box <- list(
  service = "box",
  id = "m5do45hvzw32iv2aors3urf5pgkxxazx",
  custom_domain = NULL,
  start_time = NULL
)

list_parse_box_acme <- list(
  service = "box",
  id = "m5do45hvzw32iv2aors3urf5pgkxxazx",
  custom_domain = "acme",
  start_time = NULL
)

list_suggest_box <- list(
  embed = 'embed_box("m5do45hvzw32iv2aors3urf5pgkxxazx")',
  start_time = NULL
)

list_suggest_box_acme <- list(
  embed = 'embed_box("m5do45hvzw32iv2aors3urf5pgkxxazx", custom_domain = "acme")',
  start_time = NULL
)

####
url_cran <- "https://cran.rstudio.com/"

####
expect_service <- function(url, service) {
  expect_identical(get_service(url), service)
}

expect_parse <- function(url, list_parse) {
  expect_identical(parse_video_url(url), list_parse)
}

expect_build <- function(list_parse, list_suggest) {
  expect_identical(build_suggestion(list_parse), list_suggest)
}

test_that("get_service works", {
  expect_service(url_youtube, "youtube")
  expect_service(url_youtube_short_time, "youtube_short")
  expect_service(url_vimeo_time, "vimeo")
  expect_service(url_channel9, "channel9")
  expect_service(url_user2016, "channel9")
  expect_service(url_user2017, "channel9")
  expect_service(url_box, "box")
  expect_service(url_box_acme, "box")
  expect_error(get_service(url_cran), regexp = "cran\\.rstudio\\.com")
})

test_that("parse_video_url works", {
  expect_parse(url_youtube, list_parse_youtube)
  expect_parse(url_youtube_short_time, list_parse_youtube_short_time)
  expect_parse(url_vimeo_time, list_parse_vimeo_time)
  expect_parse(url_channel9, list_parse_channel9)
  expect_parse(url_user2016, list_parse_user2016)
  expect_parse(url_user2017, list_parse_user2017)
  expect_parse(url_box, list_parse_box)
  expect_parse(url_box_acme, list_parse_box_acme)
  expect_error(parse_video_url(url_cran), regexp = "cran\\.rstudio\\.com")
})

test_that("build_suggestion works", {
  expect_build(list_parse_youtube, list_suggest_youtube)
  expect_build(list_parse_youtube_short_time, list_suggest_youtube_short_time)
  expect_build(list_parse_vimeo_time, list_suggest_vimeo_time)
  expect_build(list_parse_channel9, list_suggest_channel9)
  expect_build(list_parse_user2016, list_suggest_user2016)
  expect_build(list_parse_user2017, list_suggest_user2017)
  expect_build(list_parse_box, list_suggest_box)
  expect_build(list_parse_box_acme, list_suggest_box_acme)
})
