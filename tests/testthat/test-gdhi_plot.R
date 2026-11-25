test_that("gdhi_plot_components returns a ggplot object for valid scored data", {
  df <- tibble::tibble(
    entity = c("E1", "E2"),
    IND_01 = c(4, 2),
    IND_02 = c(3, 2),
    IND_03 = c(3, 1)
  )
  scored <- gdhi_score_maturity(df, id_col = entity)
  p <- gdhi_plot_components(scored, id_col = entity)

  expect_s3_class(p, "ggplot")
})

test_that("gdhi_plot_components errors when required columns are missing", {
  bad_scores <- tibble::tibble(entity = "E1", other_col = 1)
  expect_error(gdhi_plot_components(bad_scores, id_col = entity))
})
