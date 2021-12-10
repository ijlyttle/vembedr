#' Embed video from service
#'
#' These functions are used to embed video into your \strong{rmarkdown} html-documents,
#' or into your \strong{shiny} apps. There are functions to embed from
#' YouTube, Vimeo, Microsoft Channel 9 (who host the UseR! 2016 videos), and Box.
#'
#' These services allow you to customize a lot of things by specifying
#' an optional query string. The specification for the query string will differ
#' according to the service being used:
#'
#' \describe{
#'   \item{YouTube}{<https://developers.google.com/youtube/player_parameters>}
#'   \item{Vimeo}{<https://developer.vimeo.com/player/embedding>}
#'   \item{Box}{<https://developer.box.com/docs/box-embed#section-build-box-embed-programatically>}
#'   \item{Microsoft Stream}{<https://docs.microsoft.com/en-us/stream/portal-embed-video>}
#' }
#'
#' @param id                `character`, identifier provided by the service
#' @param custom_domain     `character`, (used by Box) name of Box-instance
#'   to use. It can be useful to use `getOption("vembedr.box_custom_domain")`
#'   if you are using a corporate instance of Box. If `NULL`, it will use
#'   the standard Box instance.
#' @param height            `numeric`, height of iframe (px)
#' @param width             `numeric`, width of iframe (px)
#' @param ratio             `character`, indicates aspect ratio for the `<iframe/>`
#' @param frameborder       `numeric`, size of frame border (px)
#' @param allowfullscreen   `logical`, indicates if to allow fullscreen
#' @param query             `list`, items to include in url-query string
#' @param fragment          `character`, string to include as url-fragment
#'
#' @return Object with S3 class `vembedr_embed`
#'
#' @name embed
#' @family embed
#' @seealso [use_start_time()]
#' @examples
#' embed_youtube("dQw4w9WgXcQ")
#' embed_vimeo("45196609")
#' embed_box("m5do45hvzw32iv2aors3urf5pgkxxazx")
#' embed_msstream("ae21b0ac-4a2b-41f4-b3fc-f1720dd20f48")
#'
NULL

# internal function to create embed div
create_embed <- function(iframe, name, ratio) {

  embed <- htmltools::div(
    class = "vembedr",
    htmltools::div(iframe)
  )

  class(embed) <- c(name,  "vembedr_embed", class(embed))

  attr(embed, "ratio") <- ratio

  # attach html-dependency
  embed <- htmltools::attachDependencies(embed, vembedr_dependency())

  embed
}
