# helper function to convert logical into a character parameter
.convert_allowfullscreen <- function(x){

  if (x){
    result <- ""
  } else {
    result <- NULL
  }

  result
}

#' Get number of seconds given a string
#'
#' This is a helper function to get the number of seconds.
#'
#' This could be useful for composing query parameters for YouTube embeds.
#'
#' @param x  character, describes a time duration, i.e. "3m15s"
#'
#' @return numeric, number of seconds
#'
#' @seealso [embed_youtube()], [hms()]
#'
#' @keywords internal
#' @export
#
secs <- function(x){

  .Deprecated("use_start_time")

  .secs(x)
}

# internal function
# @examples
#   secs("45s")
#   secs("3m15s")
#   secs("1h1m5s")
.secs <- function(x) {

  parse <- function(x, char){
    regex <- paste0("(\\d+)", char)

    if (stringr::str_detect(x, regex)){
      num <- as.numeric(stringr::str_match(x, regex)[[2]])
    } else {
      num <- 0
    }

    num
  }

  hours <- parse(x, "h")
  minutes <- parse(x, "m")
  seconds <- parse(x, "s")
  only_seconds <- parse(x, "$") # capture one-or-more digits at the end of a string

  result <- only_seconds + seconds + 60*(minutes + 60*hours)

  result
}


#' Create an hours-minutes-seconds string
#'
#' @param x, numeric (number of seconds), or character (i.e. "3m15s")
#'
#' @return character string (i.e. "0h3m15s")
#' @seealso [secs()]
#'
#' @keywords internal
#' @export
#'
hms <- function(x){

  .Deprecated("use_start_time")

  .hms(x)
}

# internal function
# @examples
#   hms(30)
#   hms("3m15s")
#
.hms <- function(x) {
  seconds <- .secs(x)

  h <- floor(seconds/3600)
  m <- floor((seconds %% 3600)/60)
  s <- floor(seconds %% 60)

  paste0(h, "h", m, "m", s, "s")
}

