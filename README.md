The goal of ReportSubtotal is to adds subtotal rows / sections (a la SAS's Proc Tabulate) to a Group By output.

## Installation

You can install the released version of ReportSubtotal from [CRAN](https://CRAN.R-project.org) with:

```{r}
install.packages("ReportSubtotal")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(dplyr)
library(ReportSubtotal)

group_by(iris, Species, Petal.Width) %>%
summarise(Mean_Width = mean(Sepal.Width), .groups = "keep") %>%
subtotal_row(iris, vars = "Sepal.Width", aggregator = "mean")

group_by(mtcars, cyl, gear, carb) %>%
summarise(Med_Wt = median(wt), Med_Hp = median(hp), .groups = "keep") %>%
subtotal_row(mtcars, vars = c("wt", "hp"), aggregator = "median")

```
