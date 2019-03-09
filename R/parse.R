#' Suggest embedding-code based on a URL
#'
#' This function is meant to work with URLs from any of the supported services.
#'
#' \describe{
#'   \item{`suggest_embed`}{called for the side-effect of
#'     messaging the suggested code the screen}
#'   \item{`suggest_embed_pure`}{returns character string
#'     that represents the suggested code}
#' }
#'
#' @param url    character, can be copied from browser location or from
#'   the "share" output on a video's web page
#'
#' @return character, returns the suggested code (`suggest_embed` returns invisibly)
#'
#' @examples
#' suggest_embed("https://youtu.be/1-vcErOPofQ?t=28s")
#' suggest_embed("https://www.youtube.com/watch?v=1-vcErOPofQ")
#' @export
#'
suggest_embed <- function(url){

  str_message <- suggest_embed_pure(url)

  message(str_message)

  invisible(str_message)
}

#' @keywords internal
#' @rdname suggest_embed
#' @export
suggest_embed_pure <- function(url){

  parse_list <- parse_video_url(url)

  suggest_list <- build_suggestion(parse_list)

  str_message <- paste(unlist(suggest_list), collapse = " %>%\n  ")

  str_message
}


#' Given a parse-list, generate an embed-list
#'
#' This is an internal function, supporting [suggest_embed()]
#'
#' @param parse_list, list generated using [parse_video_url()]
#'   with members:
#'   \describe{
#'     \item{service}{character, describes which service is used}
#'     \item{id}{character, identifier for the video at the service}
#'     \item{start_time}{character, indicates start time}
#'   }
#'
#' @return list with members:
#' \describe{
#'   \item{embed}{character, code for [embed()] call}
#'   \item{start_time}{character, (optional) code for [use_start_time()] call}
#' }
#' @seealso [suggest_embed()] [parse_video_url()]
#' @examples
#' parse_video_url("https://youtu.be/1-vcErOPofQ?t=28s") %>%
#' build_suggestion()
#' @export
#'
build_suggestion <- function(parse_list){

  str_embed <-
    paste0("embed_", parse_list$service, "(\"", parse_list$id, "\")")

  if (is.null(parse_list$start_time)){
    str_start_time <- NULL
  } else {
    str_start_time <-
      paste0("use_start_time(\"", parse_list$start_time, "\")")
  }

  suggest_list <- list(
    embed = str_embed,
    start_time = str_start_time
  )

  suggest_list
}

#' Determine the service, given the URL
#'
#' @inheritParams suggest_embed
#'
#' @return `character` identfying the video service
#'
#' @examples
#' get_service("https://youtu.be/1-vcErOPofQ?t=28s")
#' @export
#'
get_service <- function(url) {

  url_parsed <- httr::parse_url(url)
  hostname <- url_parsed$hostname

  # each service will match a regex
  regex <- c(
    channel9 = "^channel9\\.msdn\\.com$",
    youtube = "^www\\.youtube\\.com$",
    youtube_short = "^youtu\\.be$",
    vimeo = "^vimeo\\.com$",
    box = "app\\.box\\.com$"
  )

  # str_detect is vectorized over the patters
  is_service <- stringr::str_detect(hostname, regex)

  # if no service found, throw error
  if (!any(is_service)) {
    stop(
      glue::glue("Cannot find service to match '{hostname}'."),
      call. = FALSE
    )
  }

  service <- names(regex)[is_service]

  service
}


#' Parse a URL to determine service and id
#'
#' This is an internal function, supporting [suggest_embed()]
#'
#' @param url  character, URL to parse
#'
#' @return list with members:
#' \describe{
#'   \item{service}{character, describes which service is used}
#'   \item{id}{character, identifier for the video at the service}
#'   \item{start_time}{character, indicates start time}
#' }
#'
#' @keywords internal
#' @seealso suggest_embed
#' @examples
#' parse_video_url("https://youtu.be/1-vcErOPofQ?t=28s")
#' @export
#'
parse_video_url <- function(url) {

  list_parse <- list(
    channel9 = .parse_channel9,
    youtube = .parse_youtube,
    youtube_short = .parse_youtube_short,
    vimeo = .parse_vimeo,
    box = .parse_box
  )

  service <- get_service(url)

  url_parsed <- httr::parse_url(url)

  # idea:
  #  - this could be done more-conventionally using S3 dispatch
  #  - get_service() could return a parsed url with additional class
  #
  fn_parse <- list_parse[[service]]

  do.call(fn_parse, list(url_parsed = url_parsed))

}

.parse_youtube <- function(url_parsed) {
  list(
    service = "youtube",
    id = url_parsed$query$v,
    start_time = url_parsed$query$t
  )
}

.parse_youtube_short <- function(url_parsed) {
  list(
    service = "youtube",
    id = url_parsed$path,
    start_time = url_parsed$query$t
  )
}

.parse_vimeo <- function(url_parsed){

  start_time <- NULL
  if (!is.null(url_parsed$fragment)){
    start_time <- sub("^t=", "", url_parsed$fragment) # removes leading "t="
  }

  list(
    service = "vimeo",
    id = url_parsed$path,
    start_time = start_time
  )
}

.parse_channel9 <- function(url_parsed){

  path_split <-
    url_parsed$path %>%
    strsplit("/") %>%
    `[[`(1)

  path_user2016 <-
    c("Events", "useR-international-R-User-conference", "useR2016")

  path_user2017 <-c(
    "Events",
    "useR-international-R-User-conferences",
    "useR-International-R-User-2017-Conference"
  )

  if (identical(length(path_split), 4L)
      && identical(path_split[1:3], path_user2016)) {
    # this is a UseR!2016 link
    result <- list(
      service = "user2016",
      id = path_split[[4]],
      start_time = NULL
    )
  } else if (identical(path_split[1:3], path_user2017)) {
    # this is a UseR!2017 link
    result <- list(
      service = "user2017",
      id = path_split[[4]],
      start_time = NULL
    )
  }
  else {
    # this is a regular Channel 9 link
    result <- list(
      service = "channel9",
      id = url_parsed$path,
      start_time = NULL
    )
  }

  result
}

.parse_box <- function(url_parsed) {

  result <- list(
    service = "box",
    id = id,
    start_time = NULL,
    id_type = id_type,
    custom_domain = custom_domain,
  )

  result
}


