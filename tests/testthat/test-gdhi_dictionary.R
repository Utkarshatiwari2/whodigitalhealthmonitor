test_that("gdhi_indicator_dictionary returns all 7 components and 19 core indicators", {
  dict <- gdhi_indicator_dictionary()

  expect_s3_class(dict, "data.frame")
  expect_equal(length(unique(dict$component_number)), 7L)
  expect_equal(sum(!dict$is_subindicator), 19L)
})

test_that("wef_to_phase15 maps cutoffs according to GDHI Indicator Guide", {
  expect_equal(
    wef_to_phase15(c(1.0, 3.3, 3.31, 4.0, 4.01, 5.0, 5.01, 5.4, 5.41, 7.0)),
    c(1L, 1L, 2L, 2L, 3L, 3L, 4L, 4L, 5L, 5L)
  )
  expect_error(wef_to_phase15(c(0.5, 3.0)))
  expect_error(wef_to_phase15(c(3.0, 7.5)))
})
