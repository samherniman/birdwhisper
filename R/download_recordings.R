#' Download recordings from multiple species
#'
#' @param x list of responses from search_xeno_canto()
#' @param save_directory directory to save the recordings
#' @param n_per_sp number of recordings to select from each species
#'
#' @return list of xeno canto records
#' @export
#'
download_recordings <- function(x, save_directory, n_per_sp = 4) {
  id <- sono_large <-  NULL
  x_filtered <- filter_recordings(x, n_per_sp = n_per_sp) |>
    dplyr::rowwise() |>
    dplyr::mutate(
      recording_location = download_xeno_recording(id, file, save_directory),
      sono_location = download_xeno_sonogram(id, sono_large, save_directory)
    )
    return(x_filtered)
}


#' Get the large vector from sono
#'
#' @param sono Sonogram vector in Xeno Canto record
#'
#' @return sono$large
get_sono_large <- function(sono) {
  return(sono$large)
}

#' Filter the list of recordings for a species to a given number
#'
#' @param x species record from Xeno Canto
#' @param n_per_sp number of recordings to keep from each species
#'
#' @return recording records
#' @export
#'
filter_recordings <- function(x, n_per_sp = 1) {
  recordings <- lic <- also <- sono <- species <- NULL
  file_vec <-
    x |>
    tidyr::unnest_longer(col = recordings) |>
    purrr::pluck("recordings") |>
    dplyr::filter(
      lic == "//creativecommons.org/licenses/by-nc-sa/4.0/"
      ) |>
    dplyr::rowwise() |>
    dplyr::filter(length(also) == 0) |> # only one species
    dplyr::mutate(
      species = glue::glue("{gen} {sp}"),
      sono_large = get_sono_large(sono)
      ) |>
    dplyr::group_by(species) |>
    dplyr::slice_sample(n = n_per_sp)
}

#' Download a single Xeno Canto recording and image
#'
#' @param x a Xeno Canto record from search_xeno_canto()
#' @param save_directory directory to save the recordings
#'
#' @return local path to the recording
#' @export
#'
download_xeno <- function(x, save_directory) {
  cli::cli_abort(c("download_xeno has been depricated.
          please use download_xeno_recording"))
#   fs::dir_create(save_directory)
#   out_path <- fs::path(save_directory, x$id, ext = "mp3")
#   curl::curl_download(x$file, destfile = out_path)
#
#   # sound_path <- fs::path(save_directory, stringr::str_extract(x$sono$large, "[:alpha:]{2}\\d+-large\\.png$"))
#   sound_path <- fs::path(save_directory, x$id, ext = "png")
#   sound_url <- paste0("https:", x$sono$large)
#   curl::curl_download(sound_url, destfile = sound_path)
#   x$recording_location <- out_path
#   x$image_location <- sound_path
#   return(x)
}

#' Download a single Xeno Canto recording
#'
#' @param x_id a Xeno Canto id number
#' @param x_file the url of a Xeno Canto file
#' @param save_directory the directory to save it in
#'
#' @return the local location of the file
#' @export
download_xeno_recording <- function(x_id, x_file, save_directory) {
  fs::dir_create(save_directory)
  out_path <- fs::path(save_directory, x_id, ext = "mp3")
  curl::curl_download(x_file, destfile = out_path)

  return(out_path)
}

#' Download a single Xeno Canto sonogram
#'
#' @param x_id a Xeno Canto id number
#' @param x_sono_col the url of a Xeno Canto sonogram
#' @param save_directory the directory to save it in
#'
#' @return the local location of the sonogram
#' @export
download_xeno_sonogram <- function(x_id, x_sono_col, save_directory) {
  sono_path <- fs::path(save_directory, x_id, ext = "png")
  sono_url <- paste0("https:", x_sono_col)
  curl::curl_download(sono_url, destfile = sono_path)

  return(sono_path)
}
