#' Suggest embedding-code based on a URL
#'
#' This function is meant to work with URLs from any of the supported services.
#'
#' \describe{
#'   \item{`suggest_embed`}{called for the side-effect of
#'     printing suggested code the screen. If you have a recent version
#'     of [usethis](https://cran.r-project.org/package=usethis), the code
#'     will be copied to your clipboard}
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
#' \dontrun{
#'   # not run because it may copy to your clipboard
#'   suggest_embed("https://youtu.be/1-vcErOPofQ?t=28s")
#'   suggest_embed("https://www.youtube.com/watch?v=1-vcErOPofQ")
#' }
#'   cat(suggest_embed_pure("https://youtu.be/1-vcErOPofQ?t=28"))
#' @export
#'
suggest_embed <- function(url){

  code <- suggest_embed_pure(url)

  # do we have a recent-enough version of usethis?
  has_usethis <-
    requireNamespace("usethis", quietly = TRUE) &&
    utils::packageVersion("usethis") > "1.4.0"

  if (has_usethis) {
    usethis::ui_code_block(code)
  } else {
    message(code)
  }

  invisible(code)
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

  # idea: this seems like a great place to implement tidyeval

  str_embed <-
    glue::glue('embed_{parse_list$service}("{parse_list$id}")')

  # if we have a custom_domain (this is getting hacky):
  if (!is.null(parse_list$custom_domain)) {
    str_embed <-
      glue::glue(
        'embed_{parse_list$service}("{parse_list$id}", ',
        'custom_domain = "{parse_list$custom_domain}")'
      )
  }

  if (is.null(parse_list$start_time)){
    str_start_time <- NULL
  } else {
    str_start_time <- glue::glue("use_start_time(\"{parse_list$start_time}\")")
    str_start_time <- as.character(str_start_time)
  }

  suggest_list <- list(
    embed = as.character(str_embed),
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

  service <- get_service(url)

  url_parsed <- httr::parse_url(url)
  class(url_parsed) <- c(glue::glue("vembedr_{service}"))

  .parse(url_parsed)
}

.parse <- function(url_parsed, ...) {
  UseMethod(".parse")
}

.parse.default <- function(url_parsed, ...) {
  stop("no method available")
}

.parse.vembedr_youtube <- function(url_parsed, ...) {
  list(
    service = "youtube",
    id = url_parsed$query$v,
    start_time = url_parsed$query$t
  )
}

.parse.vembedr_youtube_short <- function(url_parsed, ...) {
  list(
    service = "youtube",
    id = url_parsed$path,
    start_time = url_parsed$query$t
  )
}

.parse.vembedr_vimeo <- function(url_parsed, ...){

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

.parse.vembedr_channel9 <- function(url_parsed, ...){

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

.parse.vembedr_box <- function(url_parsed, ...) {

  # determine custom-domain by taking apart hostname
  hostname_split <- stringr::str_split(url_parsed$hostname, "\\.")[[1]]

  custom_domain <- NULL
  if (identical(length(hostname_split), 4L)) {
    custom_domain <- hostname_split[1]
  }

  # determine id by taking apart path
  path_split <- stringr::str_split(url_parsed$path, "/")[[1]]

  id <- path_split[2]

  result <- list(
    service = "box",
    id = id,
    custom_domain = custom_domain,
    start_time = NULL
  )

  result
}


