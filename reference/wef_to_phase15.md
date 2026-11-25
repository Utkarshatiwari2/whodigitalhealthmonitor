# Convert WEF Network Readiness Index Score to GDHI Indicator 15 Phase (1–5)

Maps numeric WEF Network Readiness Index scores (`1.0` to `7.0`) onto
the 1–5 maturity scale defined for Indicator 15 in the GDHI Indicator
Guide[span_6](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/start_span)[span_6](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/end_span).

## Usage

``` r
wef_to_phase15(score)
```

## Arguments

- score:

  Numeric vector of WEF Network Readiness Index scores
  (`1.0`–`7.0`)[span_7](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/start_span)[span_7](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/end_span).

## Value

An integer vector with values from `1L` to `5L` (or `NA_integer_` for
`NA` inputs).

## Examples

``` r
wef_to_phase15(c(2.5, 3.3, 3.7, 4.5, 5.2, 6.1))
#> [1] 1 1 2 3 4 5
```
