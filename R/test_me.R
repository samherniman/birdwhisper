#' Test your song knowledge
#'
#' @param records_df dataframe from download_recordings
#' @param test_type function describing how you would like to be tested. See details
#' @param ... parameters passed to the test_type functions
#'
#' @return nothing
#' @export
#'
#' @examples
#' \dontrun{
#' spp_lst <- collect_species_list("Vancouver, BC")
#' resps <- search_xeno_canto(spp_lst)
#' recs <- download_recordings(resps, save_directory = here::here())
#' test_me(recs)
#' }
test_me <- function(records_df, test_type = c(true_false, multiple_choice, free_choice, flashcard), ...) {
  keep_going <- 0
  min_num <- 1
  max_num <- 5
  while (keep_going != "1") {
    rand_num <- stats::runif(1, min = min_num, max = nrow(records_df)) |> round()
    secret_record <- records_df[rand_num,]
    play_recording(secret_record$recording_location)
    flashcard(secret_record)
    min_num <- ifelse(
      max_num >= nrow(records_df),
      1,
      min_num + 0.9
    )
    max_num <- ifelse(
      max_num >= nrow(records_df),
      10,
      max_num + 1
      )
    readline(prompt = "Press [enter] for the next recording")
  }

}

#' Test type: true or false
#' @param secret_record a row from records_df
#'
#' @return invisible
#' @export
#'
#' @examples
#' \dontrun{true_false(records_df[1])}
true_false <- function(secret_record) {
  cli::cli_abort(c("Not implemented yet"))
}

#' Test type: multiple choice
#' @param secret_record a row from records_df
#'
#' @return invisible
#' @export
#'
#' @examples
#' \dontrun{multiple_choice(records_df[1])}
multiple_choice <- function(secret_record) {
  cli::cli_abort(c("Not implemented yet"))
}

#' Test type: free choice
#' @param secret_record a row from records_df
#'
#' @return invisible
#' @export
#'
#' @examples
#' \dontrun{free_choice(records_df[1])}
free_choice <- function(secret_record) {
  cli::cli_abort(c("Not implemented yet"))
}

#' Test type: flashcard
#'
#' @param secret_record a row from records_df
#'
#' @return invisible
#' @export
#'
#' @examples
#' \dontrun{flashcard(records_df[1])}
flashcard <- function(secret_record) {
  readline(prompt="Press [enter] to reveal answer")
  message(glue::glue("{secret_record$en} ({secret_record$species})"))
}


