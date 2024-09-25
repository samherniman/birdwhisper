#' Play a recording from xeno canto
#'
#' @param x path to a MP3 file
#'
#' @return nothing
#' @export
play_recording <- function(x) {
  if (Sys.info()["sysname"] == "Darwin") {
    tuneR::setWavPlayer('/usr/bin/afplay')
  }

  m_tune <- tuneR::readMP3(x)
  tuneR::writeWave(m_tune, filename = fs::path_ext_set(x, "wav"))
  m_tune <- tuneR::readWave(fs::path_ext_set(x, "wav"), to = 20, units =  "seconds")
  tuneR::play(m_tune)
}

# # if (Sys.info()["sysname"] == "Darwin") {
# #   setWavPlayer('/usr/bin/afplay')
# # }
# # library(tuneR)
# # m_tune <- tuneR::readMP3(m_path)
# # tuneR::play(m_tune)
#
# m_path <- recs$recording_location[1]
#
# warbleR::mp32wav(path = save_directory)
# tuneR::writeWave(m_tune, filename = fs::path_ext_set(m_path, "wav"))
# m_wav <- fs::path_ext_set(m_path, "wav") |> tuneR::readWave()
# seewave::listen(m_wav, f=48000)
# install.packages("dynaSpec")
# dynaSpec::scrolling_spectro(wave = m_wav, wl = 300,
#                   t.display = 1.7, pal = viridis,
#                   grid = FALSE, flim = c(1, 9),
#                   width = 1000, height = 500,
#                   res = 120, fastdisp=TRUE, file.name = "default.mp4")
