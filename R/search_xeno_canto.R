#' Perform multiple requests to Xeno Canto
#'
#' @param species_vect A character vector of species to request from Xeno Canto
#'
#' @return A list of http responses from Xeno Canto
#' @export
#'
#' @examples
#' \dontrun{
#' search_xeno_canto("troglodytes+troglodytes")
#' }
search_xeno_canto <- function(species_vect = c("troglodytes+troglodytes", "icterus+abeillei")) {
  species_vect <- stringr::str_replace_all(species_vect, " ", "+")

  lapply(species_vect, req_xeno_perform) |>
    tibblify::tibblify()

}

#' Build a request to Xeno Canto for a single species
#'
#' @param species_name Character. The name of the species to send to Xeno Canto. See details for more. "troglodytes+troglodytes"
#'
#' @details
#' species_name can be any character string accepted by the Xeno Canto API.
#' See https://xeno-canto.org/help/search for details.
#' Known options include:
#'   - Genus species "troglodytes+troglodytes" or "troglodytes troglodytes"
#'
#' @return A modified HTTP request
#' @export
#'
#' @examples
#' req_xeno()
req_xeno <- function(species_name = "troglodytes+troglodytes") {
  httr2::request("https://xeno-canto.org/api/2/recordings") |>
    httr2::req_url_query(query = I(species_name))
}

#' Perform a request to Xeno Canto
#'
#' @param species_name Character. The name of the species to send to Xeno Canto. See details for more. "troglodytes+troglodytes"
#'
#' @details
#' species_name can be any character string accepted by the Xeno Canto API.
#' See https://xeno-canto.org/help/search for details.
#' Known options include:
#'   - Genus species "troglodytes+troglodytes" or "troglodytes troglodytes"
#'
#' NB that it will wait for a short time (between 1.1 and 3 seconds) between
#' requests so as not to overwhelm Xeno Canto
#'
#' @return The json body of an http request
#' @export
#'
#' @examples
#' req_xeno_perform()
req_xeno_perform <- function(species_name = "troglodytes+troglodytes") {
  Sys.sleep(stats::runif(1, 1.1, 3))
  req_xeno(species_name) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
