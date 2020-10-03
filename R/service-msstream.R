
.parse.vembedr_msstream <- function(url_parsed, ...) {

  path_split <- stringr::str_split(url_parsed$path, "/")[[1]]

  list(
    service = "msstream",
    id = path_split[[2]],
    start_time = url_parsed$query$st
  )
}
