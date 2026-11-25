# Score GDHI Maturity Phases Across Components and Overall Ecosystem

Validates 1–5 indicator scores against
[`gdhi_indicator_dictionary()`](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/gdhi_indicator_dictionary.md)
and computes component-level and overall digital health maturity phases.

## Usage

``` r
gdhi_score_maturity(
  data,
  id_col,
  round_phase = TRUE,
  include_subindicators = TRUE
)
```

## Arguments

- data:

  A data frame or tibble containing an entity identifier column and
  indicator score columns matching `indicator_id` values from
  [`gdhi_indicator_dictionary()`](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/gdhi_indicator_dictionary.md)
  (for example `IND_01`, `IND_02`, ..., `IND_19`, and optional
  sub-indicators like `IND_09A` or `IND_19A`).

- id_col:

  Name of the entity/country/region identifier column (unquoted).

- round_phase:

  Logical; if `TRUE` (default), rounds component and overall mean phases
  upward using [`ceiling()`](https://rdrr.io/r/base/Round.html),
  matching GDHI phase aggregation conventions. If `FALSE`, returns
  unrounded numeric means alongside raw scores.

- include_subindicators:

  Logical; if `TRUE` (default), includes sub-indicator columns present
  in `data` when averaging within their parent indicator or component.
  If `FALSE`, uses core indicators only.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
`id_col`, `component_number`, `component_name`, `component_mean`,
`component_phase`, and `overall_score` (or unrounded `overall_raw_mean`
when `round_phase = FALSE`).

## Examples

``` r
sample_df <- tibble::tibble(
  entity = c("Country_A", "Country_B"),
  IND_01 = c(4L, 2L),
  IND_02 = c(4L, 3L),
  IND_03 = c(3L, 2L),
  IND_04 = c(3L, 1L),
  IND_13 = c(3L, 2L),
  IND_14 = c(3L, 1L),
  IND_15 = c(4L, 2L),
  IND_16 = c(3L, 2L),
  IND_17 = c(4L, 2L)
)
gdhi_score_maturity(sample_df, id_col = entity)
#> # A tibble: 10 × 8
#>    entity    component_number component_name         n_indicators component_mean
#>    <chr>                <int> <chr>                         <int>          <dbl>
#>  1 Country_A                1 Leadership and Govern…            2            4  
#>  2 Country_A                2 Strategy and Investme…            2            3  
#>  3 Country_A                5 Standards and Interop…            2            3  
#>  4 Country_A                6 Infrastructure                    2            3.5
#>  5 Country_A                7 Services and Applicat…            1            4  
#>  6 Country_B                1 Leadership and Govern…            2            2.5
#>  7 Country_B                2 Strategy and Investme…            2            1.5
#>  8 Country_B                5 Standards and Interop…            2            1.5
#>  9 Country_B                6 Infrastructure                    2            2  
#> 10 Country_B                7 Services and Applicat…            1            2  
#> # ℹ 3 more variables: component_phase <int>, overall_raw_mean <dbl>,
#> #   overall_score <int>
```
