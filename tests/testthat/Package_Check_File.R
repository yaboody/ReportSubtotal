#.libPaths(c("C:/R_Libraries", .libPaths()))

library(devtools)
library(dplyr)
library(bench)

#do.call was benchmarked, seems fine
load_all()
# Passing the legacy string should pass the type check smoothly
data <- mtcars %>%
  group_by(cyl, vs) %>%
  summarise(sum(wt), .groups = "keep")

subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = "na.rm")
# Passing a proper list should pass the type check smoothly
subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = list(na.rm = TRUE))
# Passing an invalid type (like a vector or scalar) should trigger your error message
subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = TRUE)
subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = c(na.rm = TRUE))

load_all()
subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = list(na.rm = TRUE))
subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = list(TRUE))
subtotal_section(data, mtcars, vars = "wt", aggregator = "mean", agg_parameter = list(na.rm = TRUE, 0.1))


list(na.rm  = TRUE)

library(rlang)

# Sample vector with some NA values
test_vector <- c("A", "A", "B", NA, "A", NA)

# Set up the aggregator function and the extra arguments list
aggregator <- "table"
extra_args <- list(useNA = "ifany")

# Test the dynamic execution
exec(aggregator, test_vector, !!!extra_args)


library(rlang)

# Sample data with a missing value
my_data <- c(10, 20, NA, 40)

# Define an aggregator and extra arguments dynamically
aggregator <- "mean"
extra_args <- list(na.rm = TRUE, trim = 0.1)

# Execute dynamically
exec(aggregator, my_data, !!!extra_args)



library(dplyr)
library(rlang)

df <- tibble(
  group = c("A", "A", "B", "B"),
  val1 = c(10, NA, 30, 40),
  val2 = c(5, 15, NA, 25)
)

aggregator <- "mean"
extra_args <- list(na.rm = TRUE)
vars_to_agg <- c("val1", "val2")
group_cols <- "group"

# Scaled-up tidyverse execution
df %>%
  group_by(across(all_of(group_cols))) %>%
  summarise(
    across(
      all_of(vars_to_agg),
      ~ exec(aggregator, .x, !!!extra_args)
    ),
    .groups = "drop"
  )



















data1 <- mtcars %>%
  group_by(cyl, vs) %>%
  summarise(sum(wt), .groups = "keep") %>%
  subtotal_section(mtcars, vars = "wt")

# We expect the output to be identical to what it was before
subtotal_dupe_removal(data1, 1, iterator = 2)

expect_snapshot(subtotal_dupe_removal(data1, 1, iterator = 3))


group_by(mtcars, cyl, vs) %>% summarise(sum(wt), .groups = "keep") %>%
  subtotal_row(mtcars, "wt") %>%
  subtotal_dupe_removal(2)

group_by(mtcars, cyl, vs, am) %>% summarise(mean(hp), .groups = "keep") %>%
  subtotal_row(mtcars, "hp", "mean") %>%
  subtotal_dupe_removal(3, skip = 1)

group_by(mtcars, cyl, vs, am) %>% summarise(mean(hp), .groups = "keep") %>%
  subtotal_row(mtcars, "hp", "mean") %>%
  subtotal_dupe_removal(3, skip = 1)

#devtools::submit_cran()

check()

library(testthat)

# Test for small data report
df_small <- data.frame(a = 1)
report_small <- group_by(df_small, a) %>% summarise(b = sum(a))

expect_error(subtotal_row(report_small, df_small, vars = "b"),
             "Your data report is too small!")

# Test for non-grouped report warning
df <- iris
report_ungrouped <- summarise(df, mean_len = mean(Petal.Length))

expect_warning(subtotal_row(report_ungrouped, df, vars = "mean_len"),
               "Warning: Your report isn't grouped")





library(testthat)
library(dplyr)

load_all()

#Error Handling Tests--------------------------------------

context("Testing subtotal_section functionality")

test_that("subtotal_section enforces single aggregator constraint", {
  df <- mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg), .groups = "keep")

  # Ensure passing multiple aggregators triggers the error handler
  expect_error(
    subtotal_section(df, mtcars, vars = "mpg", aggregator = c("sum", "mean")),
    "This function doesn't accept multiple aggregators"
  )
})

test_that("subtotal_section handles overlapping label/variable names", {
  # Create a scenario where the variable name collides with a label
  df_collide <- mtcars %>% group_by(cyl, mpg) %>% summarise(cyla = sum(cyl), .groups = "keep")
  # Expect a warning regarding the suffix and verify the function still executes
  expect_warning(
    out <- subtotal_section(df_collide, mtcars, vars = "cyl"),
    "overlapping"
  )
})

test_that("subtotal_section maintains factor levels for subtotal_label", {
  df <- iris %>% group_by(Species) %>% summarise(len = sum(Petal.Length), .groups = "keep")
  out <- subtotal_section(df, iris, vars = "Petal.Length", subtotal_label = "Total")

  # Ensure the subtotal label exists in the factor levels of the grouping column
  expect_true("Total" %in% levels(out$Species))
  # Ensure it's the first level so it appears at the top
  expect_equal(levels(out$Species)[1], "Total")
})

test_that("subtotal_section structural integrity (dimensionality)", {
  # Test that the output is larger than the input due to added subtotal rows
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")
  out <- subtotal_section(df, mtcars, vars = "mpg")

  expect_gt(nrow(out), nrow(df))
})

test_that("subtotal_section handles invalid exclude indices", {
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")

  # Expect error for out-of-bounds exclude
  expect_error(
    subtotal_section(df, mtcars, vars = "mpg", exclude = 99),
    "Some excluded columns are not in the table"
  )
})

test_that("subtotal_section generates correct number of rows", {
  # Setup: 3 grouping variables (cyl, gear, carb)
  # Total combinations = 2^3 - 1 = 7 subtotal variations
  df <- mtcars %>%
    group_by(cyl, gear, carb) %>%
    summarise(mpg = mean(mpg), .groups = "keep")

  # 1. No exclusion: Should generate all combinations
  out_all <- subtotal_section(df, mtcars, vars = "mpg")
  # Original rows + 7 combinations * (some number of rows)
  # This is harder to predict exactly without knowing the data distribution,
  # but we can at least assert it grew.
  expect_gt(nrow(out_all), nrow(df))

  # 2. Total exclusion: If you exclude all labels, you get 0 subtotals (or just 1 row)
  # Based on your code, this should trigger your "adding nothing" warning.
  expect_warning(
    out_none <- subtotal_section(df, mtcars, vars = "mpg", exclude = 1:3),
    "As all labels are excluded, only a single summation row will be added."
  )
  expect_equal(nrow(out_none), nrow(df) + 1)
})


load_all()

#Stress Test: Empty report

test_that("Empty report returns zero-row warning", {
df <- mtcars %>%
  group_by(cyl, gear, carb) %>%
  summarise(mpg = mean(mpg), .groups = "keep") |> filter(mpg < 0)
expect_error(
  out <- subtotal_section(df, mtcars, vars = "mpg", aggregator = "mean"),
  "Your data report has zero rows!"
  )
})

#Currently it just supplies...ah, interesting. I guess the levels become All and NA,
#so the subgroups become...NA if impossible? Very interesting.
#What happens if some of the levels are just
#missing from the report for whatever reason?

#Stress Test: NA Report

test_that("NA values in grouping variables handled", {
  na_mtcars <- mutate(mtcars, cyl = ifelse(cyl == 4, NA, cyl))
  df <- na_mtcars %>%
    group_by(cyl, gear) %>%
    summarise(mpg = mean(mpg), .groups = "keep")

  # Expect no errors during processing
  expect_error(subtotal_section(df, na_mtcars, vars = "mpg", aggregator = "mean"), NA)
})

#Fine so far...
load_all()

subtotal_section(group_by(fact_df, cyl), fact_mtcars, vars = "mpg", aggregator = "mean")

#Stress Test - Character values in vars:
load_all()
# 2. Stress Test: Coercion Logic
test_that("Coercing column types correctly", {

  # Factor -> Character (Should succeed, no warning needed if you removed it)
  fact_mtcars <- mutate(mtcars, cyl = as.factor(cyl))
  fact_report <- fact_mtcars %>%
    group_by(cyl) %>%
    summarise(mpg = mean(mpg), .groups = "keep")
  expect_error(subtotal_section(fact_report, fact_mtcars, vars = "mpg", aggregator = "mean"), NA)

  # Logical -> Numeric (Should trigger warning)
  log_mtcars <- mutate(mtcars, mpg = (mpg > 20))
  log_df <- log_mtcars %>%
    group_by(cyl) %>%
    summarise(mpg = mean(mpg), .groups = "keep")

  expect_warning(
    subtotal_section(log_df, log_mtcars, vars = "mpg", aggregator = "mean"),
    "is logical; coercing to numeric"
  )

  # Invalid Character -> Error (Should stop)
  char_mtcars <- mutate(mtcars, mpg = "oops")
  char_df <- char_mtcars %>%
    group_by(cyl) %>%
    summarise(mpg = first(mpg), .groups = "keep")

  expect_error(
    subtotal_section(char_df, char_mtcars, vars = "mpg", aggregator = "mean"),
    "Aggregation variable 'mpg' contains character strings, and cannot be summarized properly"
  )
})

#Another one - for character values in vars

test_that("validate_column catches mixed numeric/character vectors", {
  mixed_mtcars <- mutate(mtcars, mpg = as.character(mpg))
  mixed_mtcars$mpg[1] <- "bad_value" # One bad value in a sea of numbers

  df <- mixed_mtcars %>% group_by(cyl) %>% summarise(mpg = first(mpg), .groups = "keep")

  expect_error(
    subtotal_section(df, mixed_mtcars, vars = "mpg", aggregator = "mean"),
    "Aggregation variable 'mpg' contains character strings"
  )
})


#Stress Test - One-column report:

test_that("Stopping on one-column reports", {
  # This matches your note about the warning for ungrouped reports
  onecol_df <- mtcars %>%
    group_by(cyl) %>%
    summarise(cyl = mean(cyl), .groups = "keep")

  expect_error(
    subtotal_section(onecol_df, mtcars, vars = "cyl", aggregator = "mean"),
    "Your data report has only one column!"
  )
})

#Stress Test - Variable Existence?

test_that("subtotal_section errors on missing variables", {
  # Mock a missing variable scenario
  df <- mtcars %>%
    group_by(cyl) %>%
    summarise(mpg = mean(mpg), .groups = "keep")
  expect_error(
    subtotal_section(df, mtcars, vars = "nonexistent_variable", aggregator = "mean"),
    "Some requested variables are not in your data frame."
  )
})

#Stress Test - Fake Aggregator?

test_that("subtotal_section errors on invalid aggregator", {
  df <- mtcars %>%
    group_by(cyl) %>%
    summarise(mpg = mean(mpg), .groups = "keep")
  expect_error(
    subtotal_section(df, mtcars, vars = "mpg", aggregator = "not_a_real_function"),
    "The provided aggregator 'not_a_real_function' is not a valid function."
  )
})

#Stress test - repeated excluded columns?

test_that("subtotal_section errors on repeated exclude indices", {
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")

  # 1 and 1 are repeated
  expect_error(
    subtotal_section(df, mtcars, vars = "mpg", exclude = c(1, 1)),
    "Some excluded columns are repeated"
  )
})

#Stress test - too many variables? Update - tests for nvars = ncols in report

test_that("subtotal_section fails on structural errors before type errors", {

  df <- mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg), .groups = "keep")

  expect_error(
    subtotal_section(df, mtcars, vars = c("mpg", "wt"), aggregator = "mean"),
    "Your data report has only variable columns!"
  )
})

#Stress test - too many variables - real test

test_that("subtotal_section fails on structural errors before type errors", {
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")
  expect_error(
    subtotal_section(df, mtcars, vars = c("mpg", "wt"), aggregator = "mean"),
    "You're using more variables than your report can hold"
  )
})

#Stress test - too many variables AND character columns

test_that("Structural errors take precedence over type validation", {
  # Fix: Use a report with 2 groups, but pass 0 or 1 variables,
  # or manipulate the label names to be smaller than the groups.
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")

  # Trigger the error by forcing a mismatch (conceptually)
  # You need 'label_names' to be shorter than 'groups(report)'
  # If you modify the report to effectively 'hide' a label, it will fail.
  # Simplest way: just pass a variable that doesn't correspond to the groupings.

  expect_error(
    subtotal_section(df, mtcars, vars = c("mpg", "gear")),
    "You're using more variables than your report can hold"
  )
})

#Stress test - Inf or NaN values

test_that("Infinite or NaN values trigger warnings", {
  df <- mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg), .groups = "keep")
  df$mpg[1] <- Inf # Inject a bad value

  expect_warning(
    subtotal_section(df, mtcars, vars = "mpg"),
    "Infinite or NaN values detected"
  )
})

#Stress test - ungrouping after I check groups

test_that("Ungrouping occurs only after structural checks", {

  # Use a multi-column report that is NOT grouped
  df_ungrouped <- iris %>% summarise(Petal.Width = mean(Petal.Length), len = mean(Petal.Length), width = mean(Sepal.Width))

  # Now this should pass the 'one column' check and trigger the 'ungrouped' warning
  expect_warning(
    subtotal_section(df_ungrouped, iris, vars = c("Petal.Length", "Sepal.Width")),
    "Your report isn't grouped. Error handling may fail"
  )
})

#Stress test - Exclude error hierarchy?? Sure.

test_that("Exclude error hierarchy is maintained", {
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")

  # Both errors exist in this input, but "not in table" should trigger first due to logic order
  expect_error(
    subtotal_section(df, mtcars, vars = "mpg", exclude = c(99, 1, 1)),
    "Some excluded columns are not in the table"
  )
})

#Non-current test - grouped output (it's not currently)
#
# test_that("subtotal_section preserves grouped_df class", {
#   df <- mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg), .groups = "keep")
#   out <- subtotal_section(df, mtcars, vars = "mpg")
#
#   expect_s3_class(out, "grouped_df")
# })
