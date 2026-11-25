# whodigitalhealthmonitor

`whodigitalhealthmonitor` provides standardized tools for structuring,
validating, scoring, and visualizing digital health ecosystem maturity
across the seven WHO/ITU eHealth Strategy Framework components and 19
core indicators (plus sub-indicators) defined in the Global Digital
Health Index (GDHI) / Global Digital Health Monitor framework.

## Installation

Install the development version of `whodigitalhealthmonitor` from
GitHub:

``` r

# install.packages("remotes")
remotes::install_github("<your-github-username>/whodigitalhealthmonitor")
```

## Quick Start with Your Own Data

``` r

library(whodigitalhealthmonitor)

# 1. Inspect the 7 components, 19 core indicators, and sub-indicators
dict <- gdhi_indicator_dictionary()
head(dict)

# 2. Convert raw WEF Network Readiness Index scores (1.0-7.0) to Indicator 15 phases (1-5)
wef_to_phase15(c(2.8, 3.6, 4.5, 5.2, 6.0))

# 3. Map custom column names from an imported CSV/Excel table to canonical GDHI IDs
raw_survey <- tibble::tibble(
  entity = c("Region_A", "Region_B"),
  q1_governance = c(4, 2),
  q2_planning = c(3, 2),
  q3_strategy = c(4, 2),
  q13_architecture = c(3, 1),
  q15_network = c(4, 3),
  q17_scaled_apps = c(4, 2)
)

clean_data <- gdhi_map_columns(
  raw_survey,
  mapping = c(
    IND_01 = "q1_governance",
    IND_02 = "q2_planning",
    IND_03 = "q3_strategy",
    IND_13 = "q13_architecture",
    IND_15 = "q15_network",
    IND_17 = "q17_scaled_apps"
  )
)

# 4. Compute component-level and overall maturity phases
scores <- gdhi_score_maturity(clean_data, id_col = entity)
scores

# 5. Visualize component maturity profile
gdhi_plot_components(scores, id_col = entity)
```

## Vignette

See
[`vignette("getting-started", package = "whodigitalhealthmonitor")`](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/articles/getting-started.md)
for an end-to-end walkthrough using user-supplied tables.
