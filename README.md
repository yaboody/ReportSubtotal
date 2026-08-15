The goal of ReportSubtotal is to adds subtotal rows / sections (a la SAS's Proc Tabulate) to a Group By output.

## Installation

You can install the released version of ReportSubtotalFinal from [CRAN](https://CRAN.R-project.org) (once I successfully upload it!) with:

``` r
install.packages("ReportSubtotal")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(dplyr)

group_by(iris, Species, Petal.Width) %>%
summarise(mean(Sepal.Width), .groups = "keep") %>%
subtotal_row(iris, vars = "Sepal.Width", aggregator = "mean")

group_by(mtcars, cyl, gear, carb) %>%
summarise(median(wt), median(hp), .groups = "keep") %>%
subtotal_row(mtcars, vars = c("wt", "hp"), aggregator = "median")

```
