The goal of ReportSubtotal is to adds subtotal rows / sections (a la SAS's Proc Tabulate) to a Group By output.

## Installation

You can install the released version of ReportSubtotalFinal from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ReportSubtotal")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(dplyr)

group_by(mtcars, cyl, gear) %>% summarise(Average_Miles = mean(mpg)) %>% subtotal_row(mtcars, "mpg")

group_by(mtcars, cyl, gear, carb) %>% summarise(Average_Miles = mean(mpg)) %>% subtotal_section(mtcars, "mpg")

```
