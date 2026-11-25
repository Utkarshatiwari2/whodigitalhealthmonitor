# Plot GDHI Component Maturity Scores Across Entities

Creates a horizontal bar chart of component-level maturity scores or
phases returned by
[`gdhi_score_maturity()`](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/gdhi_score_maturity.md).

## Usage

``` r
gdhi_plot_components(
  scores,
  id_col,
  metric = "component_phase",
  title = "GDHI Component Maturity Profile"
)
```

## Arguments

- scores:

  A data frame or tibble returned by
  [`gdhi_score_maturity()`](https://utkarshatiwari2.github.io/whodigitalhealthmonitor/reference/gdhi_score_maturity.md).

- id_col:

  Name of the entity/country/region identifier column (unquoted or
  character string).

- metric:

  Name of the maturity column to plot (character string or unquoted
  name); defaults to `"component_phase"` (you can also use
  `"component_mean"`).

- title:

  Optional plot title string.

## Value

A [ggplot2::ggplot](https://ggplot2.tidyverse.org/reference/ggplot.html)
object.

## Examples

``` r
df <- tibble::tibble(
  entity = c("Unit_A", "Unit_B"),
  IND_01 = c(4, 2),
  IND_02 = c(3, 2),
  IND_03 = c(3, 1),
  IND_13 = c(2, 1),
  IND_15 = c(4, 2),
  IND_17 = c(3, 2)
)
res <- gdhi_score_maturity(df, id_col = entity)
gdhi_plot_components(res, id_col = entity)
```
