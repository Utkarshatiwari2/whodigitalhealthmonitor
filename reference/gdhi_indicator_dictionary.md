# GDHI Indicator Dictionary (Indicator Guide)

Returns a structured tibble of the seven WHO/ITU eHealth Strategy
components, core indicators (1–19), and sub-indicators from the Global
Digital Health Index (GDHI) Indicator
Guide[span_3](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/start_span)[span_3](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/end_span)[span_4](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/start_span)[span_4](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/end_span)[span_5](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/start_span)[span_5](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/end_span).

## Usage

``` r
gdhi_indicator_dictionary()
```

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
columns `indicator_id`, `parent_id`, `is_subindicator`,
`component_number`, `component_name`, and `indicator_title`.

## Examples

``` r
dict <- gdhi_indicator_dictionary()
head(dict)
#> # A tibble: 6 × 6
#>   indicator_id parent_id is_subindicator component_number component_name        
#>   <chr>        <chr>     <lgl>                      <int> <chr>                 
#> 1 IND_01       NA        FALSE                          1 Leadership and Govern…
#> 2 IND_02       NA        FALSE                          1 Leadership and Govern…
#> 3 IND_03       NA        FALSE                          2 Strategy and Investme…
#> 4 IND_04       NA        FALSE                          2 Strategy and Investme…
#> 5 IND_05       NA        FALSE                          3 Legislation, Policy, …
#> 6 IND_06       NA        FALSE                          3 Legislation, Policy, …
#> # ℹ 1 more variable: indicator_title <chr>
```
