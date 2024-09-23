xc_lst <- search_xeno_canto(species_vect = c("troglodytes+troglodytes", "icterus+abeillei"))
test_that("search xeno canto works", {
  expect_length(xc_lst, 2)
})
