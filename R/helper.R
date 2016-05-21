# helper function to convert logical into a character parameter
.convert_allowfullscreen <- function(x){

  if (x){
    result <- ""
  } else {
    result <- NULL
  }

  result
}

#' Gets number of seconds given a string
#'
#' This is a helper function to get the number of seconds.
#'
#' This could be useful for composing query parameters for YouTube embeds.
#'
#' @param x  character, describes a time duration, i.e. "3m15s"
#'
#' @return numeric, number of seconds
#' @examples
#'   secs("45s")
#'   secs("3m15s")
#'   secs("1h1m5s")
#'
#' @seealso \code{\link{embed_youtube}}
#' @export
#
secs <- function(x){

  parse <- function(x, char){
    regex <- paste0("(\\d*)", char)

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

  result <- seconds + 60*(minutes + 60*hours)

  result
}
