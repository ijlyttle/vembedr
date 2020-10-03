#' Suggest embed-code based on URL
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
#' @inheritParams embed_url
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
#' @noRd
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

#' Determine service based on URL
#'
#' @inheritParams embed_url
#'
#' @return `character` identifying the video service
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
    box = "app\\.box\\.com$",
    msstream = "microsoftstream\\.com$"
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



