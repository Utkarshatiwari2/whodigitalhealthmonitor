#' Score GDHI Maturity Phases Across Components and Overall Ecosystem
#'
#' Validates 1--5 indicator scores against [gdhi_indicator_dictionary()] and
#' computes component-level and overall digital health maturity phases.
#'
#' @param data A data frame or tibble containing an entity identifier column and
#'   indicator score columns matching `indicator_id` values from
#'   [gdhi_indicator_dictionary()] (for example `IND_01`, `IND_02`, ..., `IND_19`,
#'   and optional sub-indicators like `IND_09A` or `IND_19A`).
#' @param id_col Name of the entity/country/region identifier column (unquoted).
#' @param round_phase Logical; if `TRUE` (default), rounds component and overall
#'   mean phases upward using [ceiling()], matching GDHI phase aggregation
#'   conventions. If `FALSE`, returns unrounded numeric means alongside raw scores.
#' @param include_subindicators Logical; if `TRUE` (default), includes sub-indicator
#'   columns present in `data` when averaging within their parent indicator or
#'   component. If `FALSE`, uses core indicators only.
#'
#' @return A [tibble][tibble::tibble] with `id_col`, `component_number`,
#'   `component_name`, `component_mean`, `component_phase`, and
#'   `overall_score` (or unrounded `overall_raw_mean` when `round_phase = FALSE`).
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' sample_df <- tibble::tibble(
#'   entity = c("Country_A", "Country_B"),
#'   IND_01 = c(4L, 2L),
#'   IND_02 = c(4L, 3L),
#'   IND_03 = c(3L, 2L),
#'   IND_04 = c(3L, 1L),
#'   IND_13 = c(3L, 2L),
#'   IND_14 = c(3L, 1L),
#'   IND_15 = c(4L, 2L),
#'   IND_16 = c(3L, 2L),
#'   IND_17 = c(4L, 2L)
#' )
#' gdhi_score_maturity(sample_df, id_col = entity)
gdhi_score_maturity <- function(data,
                                id_col,
                                round_phase = TRUE,
                                include_subindicators = TRUE) {
  if (!is.data.frame(data)) {
    cli::cli_abort("{.arg data} must be a data frame or tibble.")
  }

  id_sym <- rlang::ensym(id_col)
  id_name <- rlang::as_string(id_sym)

  if (!id_name %in% names(data)) {
    cli::cli_abort("Column {.val {id_name}} was not found in {.arg data}.")
  }

  dict <- gdhi_indicator_dictionary()
  if (!include_subindicators) {
    dict <- dplyr::filter(dict, !.data$is_subindicator)
  }

  ind_cols <- intersect(names(data), dict$indicator_id)
  if (length(ind_cols) == 0L) {
    cli::cli_abort(
      "No valid GDHI indicator columns found in {.arg data}. Expected IDs like {.val IND_01}..{.val IND_19}."
    )
  }

  # Validate indicator scores are numeric/integer between 1 and 5
  for (col in ind_cols) {
    vals <- data[[col]]
    if (!is.numeric(vals)) {
      cli::cli_abort("Indicator column {.val {col}} must be numeric.")
    }
    bad <- !is.na(vals) & (vals < 1 | vals > 5)
    if (any(bad)) {
      cli::cli_abort("Indicator column {.val {col}} contains values outside 1 to 5.")
    }
  }

  long_df <- data |>
    dplyr::select(dplyr::all_of(c(id_name, ind_cols))) |>
    tidyr::pivot_longer(
      cols = dplyr::all_of(ind_cols),
      names_to = "indicator_id",
      values_to = "score"
    ) |>
    dplyr::left_join(dict, by = "indicator_id")

  comp_df <- long_df |>
    dplyr::group_by(
      !!id_sym,
      .data$component_number,
      .data$component_name
    ) |>
    dplyr::summarise(
      n_indicators = sum(!is.na(.data$score)),
      component_mean = if (all(is.na(.data$score))) NA_real_ else mean(.data$score, na.rm = TRUE),
      .groups = "drop"
    ) |>
    dplyr::mutate(
      component_phase = if (round_phase) {
        as.integer(ceiling(.data$component_mean))
      } else {
        .data$component_mean
      }
    )

  overall_df <- comp_df |>
    dplyr::group_by(!!id_sym) |>
    dplyr::summarise(
      overall_raw_mean = if (all(is.na(.data$component_mean))) NA_real_ else mean(.data$component_mean, na.rm = TRUE),
      .groups = "drop"
    ) |>
    dplyr::mutate(
      overall_score = if (round_phase) {
        as.integer(ceiling(.data$overall_raw_mean))
      } else {
        .data$overall_raw_mean
      }
    )

  comp_df |>
    dplyr::left_join(overall_df, by = id_name) |>
    dplyr::arrange(!!id_sym, .data$component_number)
}
