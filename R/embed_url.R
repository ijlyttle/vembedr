#' Embed a video based on URL
#'
#' You can use this function to embed video using only the URL and you do not
#' need any customization beyond the start-time.
#' It should work for all the services supported by the [embed()]
#' family of functions.
#'
#' This function calls [suggest_embed()] then parses and evaluates the code.
#' If you need to customize the iframe, [suggest_embed()] may be more useful to you.
#'
#' @param url character, URL of webpage for video
#'
#' @return An embed object that prints an \code{htmltools::\link[htmltools]{tags}$iframe} element
#'
#' @seealso [suggest_embed()]
#' @examples
#' embed_url("https://youtu.be/1-vcErOPofQ?t=28s")
#' @export
#'
embed_url <- function(url){

  parse_text <- function(x){
    parse(text = x)
  }

  suggest_embed_pure(url) %>%
    parse_text() %>%
    eval()
}
