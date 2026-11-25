#' GDHI Indicator Dictionary (Indicator Guide)
#'
#' Returns a structured tibble of the seven WHO/ITU eHealth Strategy components,
#' core indicators (1--19), and sub-indicators from the Global Digital Health
#' Index (GDHI) Indicator Guide[span_3](start_span)[span_3](end_span)[span_4](start_span)[span_4](end_span)[span_5](start_span)[span_5](end_span).
#'
#' @return A [tibble][tibble::tibble] with columns `indicator_id`, `parent_id`,
#'   `is_subindicator`, `component_number`, `component_name`, and
#'   `indicator_title`.
#' @export
#'
#' @examples
#' dict <- gdhi_indicator_dictionary()
#' head(dict)
gdhi_indicator_dictionary <- function() {
  tibble::tribble(
    ~indicator_id, ~parent_id, ~is_subindicator, ~component_number, ~component_name, ~indicator_title,
    "IND_01", NA_character_, FALSE, 1L, "Leadership and Governance", "Digital health prioritized at the national level through dedicated bodies / mechanisms for governance",
    "IND_02", NA_character_, FALSE, 1L, "Leadership and Governance", "Digital health prioritized at the national level through planning",
    "IND_03", NA_character_, FALSE, 2L, "Strategy and Investment", "National eHealth / Digital Health Strategy or Framework",
    "IND_04", NA_character_, FALSE, 2L, "Strategy and Investment", "Public funding for digital health",
    "IND_05", NA_character_, FALSE, 3L, "Legislation, Policy, and Compliance", "Legal Framework for Data Protection (Security)",
    "IND_06", NA_character_, FALSE, 3L, "Legislation, Policy, and Compliance", "Laws or Regulations for privacy, confidentiality and access to health information (Privacy)",
    "IND_07", NA_character_, FALSE, 3L, "Legislation, Policy, and Compliance", "Protocol for regulating or certifying devices and/or digital health services",
    "IND_08", NA_character_, FALSE, 3L, "Legislation, Policy, and Compliance", "Cross-border data security and sharing",
    "IND_09", NA_character_, FALSE, 4L, "Workforce", "Digital health integrated in health and related professional pre-service training (prior to deployment)",
    "IND_09A", "IND_09", TRUE, 4L, "Workforce", "Pre-service training: doctors/physicians",
    "IND_09B", "IND_09", TRUE, 4L, "Workforce", "Pre-service training: nurses",
    "IND_09C", "IND_09", TRUE, 4L, "Workforce", "Pre-service training: community health workers",
    "IND_10", NA_character_, FALSE, 4L, "Workforce", "Digital health integrated in health and related professional in-service (continuing education)",
    "IND_10A", "IND_10", TRUE, 4L, "Workforce", "In-service training: doctors/physicians",
    "IND_10B", "IND_10", TRUE, 4L, "Workforce", "In-service training: nurses",
    "IND_10C", "IND_10", TRUE, 4L, "Workforce", "In-service training: community health workers",
    "IND_11", NA_character_, FALSE, 4L, "Workforce", "Training of digital health work force",
    "IND_11A", "IND_11", TRUE, 4L, "Workforce", "Training of health and/or biomedical informatics specialists",
    "IND_12", NA_character_, FALSE, 4L, "Workforce", "Maturity of public sector digital health professional careers",
    "IND_13", NA_character_, FALSE, 5L, "Standards and Interoperability", "National digital health architecture and/or health information exchange",
    "IND_14", NA_character_, FALSE, 5L, "Standards and Interoperability", "Health information standards",
    "IND_15", NA_character_, FALSE, 6L, "Infrastructure", "Network readiness (WEF Network Readiness Index)",
    "IND_16", NA_character_, FALSE, 6L, "Infrastructure", "Planning and support for ongoing digital health infrastructure maintenance",
    "IND_17", NA_character_, FALSE, 7L, "Services and Applications", "Nationally scaled digital health systems",
    "IND_18", NA_character_, FALSE, 7L, "Services and Applications", "Digital identity management of service providers, administrators, and facilities (including GIS location data)",
    "IND_19", NA_character_, FALSE, 7L, "Services and Applications", "Digital identity management of individuals for health",
    "IND_19A", "IND_19", TRUE, 7L, "Services and Applications", "Individual registry: master patient index",
    "IND_19B", "IND_19", TRUE, 7L, "Services and Applications", "Individual registry: birth registry",
    "IND_19C", "IND_19", TRUE, 7L, "Services and Applications", "Individual registry: death registry",
    "IND_19D", "IND_19", TRUE, 7L, "Services and Applications", "Individual registry: immunization registry"
  )
}

#' Convert WEF Network Readiness Index Score to GDHI Indicator 15 Phase (1--5)
#'
#' Maps numeric WEF Network Readiness Index scores (`1.0` to `7.0`) onto the
#' 1--5 maturity scale defined for Indicator 15 in the GDHI Indicator Guide[span_6](start_span)[span_6](end_span).
#'
#' @param score Numeric vector of WEF Network Readiness Index scores (`1.0`--`7.0`)[span_7](start_span)[span_7](end_span).
#'
#' @return An integer vector with values from `1L` to `5L` (or `NA_integer_` for `NA` inputs).
#' @export
#'
#' @examples
#' wef_to_phase15(c(2.5, 3.3, 3.7, 4.5, 5.2, 6.1))
wef_to_phase15 <- function(score) {
  if (!is.numeric(score)) {
    cli::cli_abort("{.arg score} must be a numeric vector.")
  }

  out_of_range <- !is.na(score) & (score < 1.0 | score > 7.0)
  if (any(out_of_range)) {
    cli::cli_abort("{.arg score} values must be between 1.0 and 7.0.")
  }

  dplyr::case_when(
    is.na(score) ~ NA_integer_,
    score <= 3.3 ~ 1L,
    score <= 4.0 ~ 2L,
    score <= 5.0 ~ 3L,
    score <= 5.4 ~ 4L,
    score <= 7.0 ~ 5L
  )
}
