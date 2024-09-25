# library(httr2)
# search_xeno_canto <- function(species_vect = c("troglodytes+troglodytes", "icterus+abeillei")) {
#   lapply(species_vect, req_xeno_perform)
# }
#
# req_xeno <- function(species_name = "troglodytes+troglodytes") {
#   httr2::request("https://xeno-canto.org/api/2/recordings") |>
#     httr2::req_url_query(query = I(species_name))
# }
#
# req_xeno_perform <- function(species_name = "troglodytes+troglodytes") {
#   Sys.sleep(runif(1, 1.1, 3))
#   req_xeno(species_name) |>
#     httr2::req_perform() |>
#     httr2::resp_body_json()
# }
#
# xc_1 <- xc_l[[1]]
# download_recordings <- function(xc_l, out_dir, n_per_sp = 1) {
#   xc_l
# }
#
# filter_recordings <- function(x, n_per_sp = 1) {
#   file_vec <-
#     x |>
#     purrr::pluck("recordings") |>
#     purrr::keep(\(x) x$lic == "//creativecommons.org/licenses/by-nc-sa/4.0/")
#   sample_index <- runif(n_per_sp, 1, length(file_vec)) |> floor()
#   file_sample <-
#     file_vec |>
#     purrr::keep_at(sample_index)
#   return(file_sample)
# }
#
# xc_f <- filter_recordings(xc_1, 5)
# out_dir <- "/Users/samherniman/Downloads/temp/"
# xc_d <- xc_f |>
#   purrr::pluck(1)# |>
#   # purrr::map2()
#
# m_path <- download_xeno(xc_d, out_dir)
#
# download_xeno <- function(x, out_dir) {
#   fs::dir_create(out_dir)
#   out_path <- fs::path(out_dir, x$`file-name`)
#   curl::curl_download(x$file, destfile = out_path)
#
#   sound_path <- fs::path(out_dir, stringr::str_extract(x$sono$large, "[:alpha:]{2}\\d+-large\\.png$"))
#   sound_url <- paste0("https:", x$sono$large)
#   curl::curl_download(sound_url, destfile = sound_path)
#
#   return(out_path)
# }
#
# if (Sys.info()["sysname"] == "Darwin") {
#   setWavPlayer('/usr/bin/afplay')
# }
# library(tuneR)
# m_tune <- tuneR::readMP3(m_path)
# tuneR::play(m_tune)
# plot(m_tune)
