#' Query GBIF for a list of bird species found in a location
#'
#' @param location Character vector of location names passed to tidygeocoder or sf_POLYGON
#'
#' @return List of bird species recorded in GBIF within the area of interest
#' @export
collect_species_list <- function(location) {
  if (is.character(location)) {
    location <- find_geometry(location)
  }

  if (!"sf" %in% class(location) || !sf::st_is_valid(location)) {
    cli::cli_abort(c('Location is not a valid sf object or character vector
         To fix this, supply a valid sf polygon, or specify a
         location as a character string ex "Vancouver, BC"')
    )
  }
  location <-
  location |>
    sf::st_geometry() |>
    sf::st_bbox()

  location <- rgbif::gbif_bbox2wkt(bbox = location)

  occ_lst <- rgbif::occ_search(geometry = location,
                               classKey = 212
                               # limit = 10
  )

  spp_lst <-
    occ_lst$data$species |>
    unique()

  return(spp_lst)
}
