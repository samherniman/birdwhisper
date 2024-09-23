
#' Geocode and buffer a location
#'
#' @param address Character vector of locations to geocode
#' @param buffer_radius Numeric radius to buffer location in metres (default is 100000)
#'
#' @return sfc_POLYGON of buffered locations
#' @export
#'
#' @examples
#' find_geometry("Christmas Island, Australia")
#' find_geometry("France", buffer_radius = 1000000)
find_geometry <- function(address, buffer_radius = 100000) {

  check_existence(address)

  location_tb <- tibble::tibble(address = address) |>
    tidygeocoder::geocode(address = address)

  if (all(is.na(location_tb$lat), is.na(location_tb$long))) {
    cli::cli_abort(c("{address} was not found in the geocoding database, please try a different location"))
  }

  location_tb <-
  location_tb |>
    sf::st_as_sf(
      coords = c("long", "lat"),
      crs = sf::st_crs(4326)
    ) |>
    # sf::st_transform(sf::st_crs(3857)) |>
    sf::st_buffer(buffer_radius)
}
