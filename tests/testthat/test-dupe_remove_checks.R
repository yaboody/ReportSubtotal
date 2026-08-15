library(tidyverse)
#Dupe Removal Tests

test_that("subtotal_dupe_removal output matches historical baseline", {

  # Example 1: Standard usage based on your original documentation
  data1 <- mtcars %>%
    group_by(cyl, vs) %>%
    summarise(sum(wt), .groups = "keep") %>%
    subtotal_section(mtcars, vars = "wt")

  # We expect the output to be identical to what it was before
  expect_snapshot(subtotal_dupe_removal(data1, 2))

  # Example 2: Usage with skipping logic
  data2 <- mtcars %>%
    group_by(cyl, vs, am) %>%
    summarise(mean(hp), .groups = "keep") %>%
    subtotal_section(mtcars, vars = "hp", "mean")

  expect_snapshot(subtotal_dupe_removal(data2, 3, iterator = 3, skip = 1))
})

