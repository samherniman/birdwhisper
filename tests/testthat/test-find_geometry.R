test_that("finding geometry works", {
  expect_snapshot(find_geometry("Christmas Island, Australia"))
  expect_error(find_geometry("bielefeld"))
  expect_no_error(find_geometry("Treborth Botanic Garden"))
  expect_error(find_geometry("Really New Zealand"))
})
