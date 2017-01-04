#' Embed a video based on url
#'
#' You can use this function to embed video using only the URL and you do not
#' need any customization beyond the start-time.
#' It should work for all the services supported by the \code{\link{embed}}
#' family of functions.
#'
#' This function calls \code{\link{suggest_embed}} then parses and evaluates the code.
#' If you need to customize the iframe, \code{\link{suggest_embed}} may be more useful to you.
#'
#' @param url character, url of webpage for video
#'
#' @return An embed object that prints an \code{htmltools::\link[htmltools]{tags}$iframe} element
#'
#' @seealso \code{\link{suggest_embed}}
#' @examples
#' embed_url("https://youtu.be/1-vcErOPofQ?t=28s")
#' @export
#'
embed_url <- function(url){

  suggest_embed(url, quiet = TRUE) %>%
    parse(text = .) %>%
    eval()
}
