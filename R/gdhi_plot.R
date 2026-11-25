#' Plot GDHI Component Maturity Scores Across Entities
#'
#' Creates a horizontal bar chart of component-level maturity scores or phases
#' returned by [gdhi_score_maturity()].
#'
#' @param scores A data frame or tibble returned by [gdhi_score_maturity()].
#' @param id_col Name of the entity/country/region identifier column (unquoted
#'   or character string).
#' @param metric Name of the maturity column to plot (character string or
#'   unquoted name); defaults to `"component_phase"` (you can also use
#'   `"component_mean"`).
#' @param title Optional plot title string.
#'
#' @return A [ggplot2::ggplot] object.
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' df <- tibble::tibble(
#'   entity = c("Unit_A", "Unit_B"),
#'   IND_01 = c(4, 2),
#'   IND_02 = c(3, 2),
#'   IND_03 = c(3, 1),
#'   IND_13 = c(2, 1),
#'   IND_15 = c(4, 2),
#'   IND_17 = c(3, 2)
#' )
#' res <- gdhi_score_maturity(df, id_col = entity)
#' gdhi_plot_components(res, id_col = entity)
gdhi_plot_components <- function(scores,
                                 id_col,
                                 metric = "component_phase",
                                 title = "GDHI Component Maturity Profile") {
  if (!is.data.frame(scores)) {
    cli::cli_abort("{.arg scores} must be a data frame or tibble.")
  }

  id_q <- rlang::enquo(id_col)
  id_name <- if (rlang::quo_is_symbol(id_q)) {
    rlang::as_string(rlang::quo_get_expr(id_q))
  } else {
    val <- rlang::eval_tidy(id_q)
    if (!is.character(val) || length(val) != 1L) {
      cli::cli_abort("{.arg id_col} must be an unquoted column name or a single string.")
    }
    val
  }

  metric_q <- rlang::enquo(metric)
  metric_name <- if (rlang::quo_is_symbol(metric_q)) {
    rlang::as_string(rlang::quo_get_expr(metric_q))
  } else {
    val <- rlang::eval_tidy(metric_q)
    if (!is.character(val) || length(val) != 1L) {
      cli::cli_abort("{.arg metric} must be a column name or single string.")
    }
    val
  }

  req_cols <- c(id_name, "component_name", metric_name)
  missing_cols <- setdiff(req_cols, names(scores))
  if (length(missing_cols) > 0L) {
    cli::cli_abort("Missing required column(s) in {.arg scores}: {.val {missing_cols}}.")
  }

  if (!is.numeric(scores[[metric_name]])) {
    cli::cli_abort("Metric column {.val {metric_name}} must be numeric.")
  }

  plot_df <- dplyr::mutate(
    scores,
    component_label = factor(
      .data$component_name,
      levels = rev(unique(.data$component_name))
    )
  )

  ggplot2::ggplot(
    plot_df,
    ggplot2::aes(
      x = .data$component_label,
      y = .data[[metric_name]],
      fill = .data[[id_name]]
    )
  ) +
    ggplot2::geom_col(position = ggplot2::position_dodge(width = 0.75), width = 0.65) +
    ggplot2::coord_flip(ylim = c(0, 5.5)) +
    ggplot2::scale_y_continuous(breaks = 1:5) +
    ggplot2::labs(
      title = title,
      x = NULL,
      y = "Maturity Phase / Score (1--5)",
      fill = id_name
    ) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(face = "bold")
    )
}
