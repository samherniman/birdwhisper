test_that("Vancouver, BC exists", {
  expect_invisible(check_existence("Vancouver, BC"))
})

test_that("Bielefeld does not exist", {
  expect_error(check_existence("Bielefeld"))
})
