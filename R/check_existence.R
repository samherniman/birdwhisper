#' Check the existence of the supplied address
#'
#' @param address Character vector of locations to check
#'
#' @return Invisible. Error if address does not exist
check_existence <- function(address) {
  if (stringr::str_detect(address, "(B|b)ielefeld")) {
    cli::cli_abort(c("I'm sorry, but Bielefeld does not exist"))
  }
}
