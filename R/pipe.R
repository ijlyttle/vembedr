#' Pipe functions
#'
#' Like dplyr, vembedr also uses the pipe function, `\%>\%` to turn
#' function composition into a series of imperative statements.
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
#' @param lhs,rhs An embed object and a function to apply to it
#'
#' @keywords internal
#'
#' @examples
#' # Instead of
#' use_start_time(rickroll_youtube(), "1m35s")
#' # you can write
#' rickroll_youtube() %>% use_start_time("1m35s")
NULL
