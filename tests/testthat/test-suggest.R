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

####
url_cran <- "https://cran.rstudio.com/"

####
expect_parse <- function(url, list_parse){
  expect_identical(parse_video_url(url), list_parse)
}

expect_build <- function(list_parse, list_suggest){
  expect_identical(build_suggestion(list_parse), list_suggest)
}

test_that("parse_video_url works", {
  expect_parse(url_youtube, list_parse_youtube)
  expect_parse(url_youtube_short_time, list_parse_youtube_short_time)
  expect_parse(url_vimeo_time, list_parse_vimeo_time)
  expect_parse(url_channel9, list_parse_channel9)
  expect_parse(url_user2016, list_parse_user2016)
  expect_error(parse_video_url(url_cran), regexp = "cran\\.rstudio\\.com")
})

test_that("build_suggestion works", {
  expect_build(list_parse_youtube, list_suggest_youtube)
  expect_build(list_parse_youtube_short_time, list_suggest_youtube_short_time)
  expect_build(list_parse_vimeo_time, list_suggest_vimeo_time)
  expect_build(list_parse_channel9, list_suggest_channel9)
  expect_build(list_parse_user2016, list_suggest_user2016)
})
