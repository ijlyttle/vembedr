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
    `channel9.msdn.com` = identity,
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

}



suggest_embed <- function(url){

}
