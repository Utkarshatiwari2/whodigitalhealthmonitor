test_that("gdhi_score_maturity computes component and overall phases", {
  df <- tibble::tibble(
    country = c("C1", "C2"),
    IND_01 = c(3, 2),
    IND_02 = c(4, 2),
    IND_03 = c(2, 1),
    IND_13 = c(3, 3)
  )

  res_rounded <- gdhi_score_maturity(df, id_col = country, round_phase = TRUE)
  expect_s3_class(res_rounded, "data.frame")
  expect_equal(res_rounded$component_phase[res_rounded$country == "C1" & res_rounded$component_number == 1L], 4L)

  res_unrounded <- gdhi_score_maturity(df, id_col = country, round_phase = FALSE)
  expect_equal(res_unrounded$component_phase[res_unrounded$country == "C1" & res_unrounded$component_number == 1L], 3.5)
})

test_that("gdhi_score_maturity rejects out-of-range scores", {
  bad_df <- tibble::tibble(
    country = "C1",
    IND_01 = 6
  )
  expect_error(gdhi_score_maturity(bad_df, id_col = country))
})
