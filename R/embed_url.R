#' Embed video based on URL
#'
#' You can use this function to embed video using only the URL and you do not
#' need any customization beyond the start-time. It works for all the
#' services supported by the [embed()] family of functions.
#'
#' This function calls [suggest_embed()] then parses and evaluates the code.
#'
#' @param url `character`, URL of web-page for video
#'
#' @inherit embed return
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

#' @rdname embed_channel9
#' @export
#
embed_user2016 <- function(id,
                           width = NULL, height = 300, ratio = c("16by9", "4by3"),
                           frameborder = 0, allowfullscreen = TRUE){

  lifecycle::deprecate_warn(
    "1.5.0",
    "embed_user2016()",
    details = c(
      i = "Microsoft made breaking changes to its Channel 9 service.",
      i = "See <https://docs.microsoft.com/en-us/teamblog/channel9joinedmicrosoftlearn>."
    ),
    id = "channel_9"
  )

  id <- c("Events", "useR-international-R-User-conference", "useR2016", id)

  embed_channel9(id, width, height, ratio, frameborder, allowfullscreen)
}

#' @rdname embed_channel9
#' @export
#
embed_user2017 <- function(id,
                           width = NULL, height = 300, ratio = c("16by9", "4by3"),
                           frameborder = 0, allowfullscreen = TRUE){


  lifecycle::deprecate_warn(
    "1.5.0",
    "embed_user2017()",
    details = c(
      i = "Microsoft made breaking changes to its Channel 9 service.",
      i = "See <https://docs.microsoft.com/en-us/teamblog/channel9joinedmicrosoftlearn>."
    ),
    id = "channel_9"
  )

  id <- c(
    "Events",
    "useR-international-R-User-conferences",
    "useR-International-R-User-2017-Conference",
    id
  )

  embed_channel9(id, width, height, ratio, frameborder, allowfullscreen)
}
