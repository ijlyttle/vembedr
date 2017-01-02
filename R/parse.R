#' Parse a URL to determine service and id
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
#' @seealso suggest_embed
#' @examples
#'
parse_video_url <- function(url){

  list_parse <- list(
    `channel9.msdn.com` = .parse_channel9,
    `www.youtube.com` = .parse_youtube,
    `youtu.be` = .parse_youtube_short,
    `vimeo.com` = .parse_vimeo
  )

  url_parsed <- httr::parse_url(url)

  # what to do if hostname not there

  fn_parse <- list_parse[[url_parsed$hostname]]

  do.call(fn_parse, list(url_parsed = url_parsed))

}

.parse_youtube <- function(url_parsed){
  list(
    service = "youtube",
    id = url_parsed$query$v,
    start_time = url_parsed$query$t
  )
}

.parse_youtube_short <- function(url_parsed){
  list(
    service = "youtube",
    id = url_parsed$path,
    start_time = url_parsed$query$t
  )
}

.parse_vimeo <- function(url_parsed){
  list(
    service = "vimeo",
    id = url_parsed$path,
    start_time = sub("^t=", "", url_parsed$fragment) # removes the leading "t="
  )
}

.parse_channel9 <- function(url_parsed){

  path_split <-
    url_parsed$path %>%
    strsplit("/") %>%
    `[[`(1)

  path_user2016 <-
    c("Events", "useR-international-R-User-conference", "useR2016")

  if (identical(length(path_split), 4L)
      && identical(path_split[1:3], path_user2016)){
    # this is a UseR! 2016 link
    result <- list(
      service = "user2016",
      id = path_split[[4]],
      start_time = NULL
    )
  } else {
    # this is a regular Channel 9 link
    result <- list(
      service = "channel9",
      id = url_parsed$path,
      start_time = NULL
    )
  }

  result
}

suggest_embed <- function(url){

  parse_list <- parse_video_url(url)

  str_embed <-
    paste0("embed_", parse_list$service, "(\"", parse_list$id, "\")")

  if (is.null(parse_list$start_time)){
    str_start_time <- NULL
  } else {
    str_start_time <-
      paste0("use_start_time(\"", parse_list$start_time, "\")")
  }

  str_message <-
    paste(c(str_embed, str_start_time), collapse = " %>%\n  ")

  cat(str_message)

  invisible(str_message)
}
