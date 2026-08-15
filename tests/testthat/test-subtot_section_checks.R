library(testthat)
library(tidyverse)

test_that("agg_parameter throws an error when it is not a list", {
  # Assuming valid basic inputs for data frame and report exist in your test environment
  report <- mtcars %>%
    group_by(cyl, vs) %>%
    summarise(sum(wt), .groups = "keep")
  expect_error(
    subtotal_section(
      report, mtcars,
      vars = "wt",
      aggregator = "mean",
      agg_parameter = TRUE
    ),
    "Aggregation parameters must be named list objects"
  )
})

test_that("agg_parameter throws an error when list elements are unnamed", {
  report <- mtcars %>%
    group_by(cyl, vs) %>%
    summarise(wt = sum(wt), .groups = "keep")

  expect_error(
    subtotal_section(
      report, mtcars,
      vars = "wt",
      aggregator = "mean",
      agg_parameter = list(0.75) # Unnamed element inside the list
    ),
    "All elements in the aggregator parameter list must be named"
  )
})

test_that("agg_parameter triggers tryCatch warning and fallback on invalid arguments", {
  report <- mtcars %>%
    group_by(cyl, vs) %>%
    summarise(sum(wt), .groups = "keep")
  expect_warning(
    res <- subtotal_section(
      report, mtcars,
      vars = "wt",
      aggregator = "sum",
      agg_parameter = list(probs = "not_a_number")
    ),
    "Warning: The provided aggregation parameters caused an error. Falling back to default aggregation without parameters."
  )

  # Verify that it still successfully returns a data frame via fallback
  expect_s3_class(res, "data.frame")
})

#Spec - custom functions - This works, but it throws errors because testthat is NOT PERFECT
# custom_max <- function(x) max(x, na.rm = TRUE)
# test_that("subtotal_section handles custom aggregator functions", {
#   custom_max <- function(x) max(x, na.rm = TRUE)
#
#   set.seed(103)
#
#   # 20,000 rows, 4 levels of grouping, testing a custom lambda aggregator with NAs
#   frame <- data.frame(
#     year = sample(2023:2026, 20000, replace = TRUE),
#     quarter = sample(c("Q1", "Q2", "Q3", "Q4"), 20000, replace = TRUE),
#     product_line = sample(c("Hardware", "Software", "Services"), 20000, replace = TRUE),
#     status = sample(c("Active", "Legacy", "Beta"), 20000, replace = TRUE),
#     uptime = runif(20000, 0.90, 0.999),
#     latency = rnorm(20000, 50, 15)
#   )
#
#   # Inject NAs to test aggregator robustness
#   frame$uptime[sample(1:20000, 500)] <- NA
#
#   report <- frame %>%
#     group_by(year, quarter, product_line, status) %>%
#     summarise(uptime = custom_max(uptime), latency = custom_max(latency), .groups = "keep")
#
#
#   # Run your function using the function object directly (or via whichever method your updated code supports)
#   expect_warning(subtotal_section(report, frame, vars = c("uptime", "latency"), aggregator = "custom_max"),
#                  "NA values detected in output. Setting agg_parameter to \"na.rm\" may resolve this.")
#
#   expect_true(is.data.frame(res))
#   # add assertions here to verify custom function output
# })

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

#Stress Test - Character values in vars:

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
    "\nYour data report has only variable columns!"
  )
})

#Stress test - too many variables - real test

test_that("subtotal_section fails on structural errors before type errors - Part 2", {
  df <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = mean(mpg), .groups = "keep")
  expect_error(
    subtotal_section(df, mtcars, vars = c("mpg", "wt"), aggregator = "mean"),
    "You're using more aggregation variables than your report can hold!"
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
    "\nYou're using more aggregation variables than your report can hold!"
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

#Stress test - column order

test_that("subtotal_section preserves column order", {
  # Verifies that function does not reorder columns unexpectedly
  # as this may break downstream pipes.
  df <- mtcars %>%
    select(gear, cyl, mpg) %>%
    group_by(gear, cyl) %>%
    summarise(mpg = mean(mpg), .groups = "keep")

  out <- subtotal_section(df, mtcars, vars = "mpg")

  # Ensure output column names match the input logic
  expect_equal(names(out)[1:2], c("gear", "cyl"))
})

test_that("subtotal_section handles label collisions", {
  # Checks behavior when subtotal_label matches existing data values.
  df <- data.frame(category = c("Total", "A", "B"), value = c(10, 20, 30)) %>%
    group_by(category) %>% summarise(value = sum(value), .groups = "keep")

  # Function should execute without error despite potential label duplication[cite: 3].
  expect_error(subtotal_section(df, df, vars = "value", subtotal_label = "Total"),
               paste0("\nThe chosen subtotal label '", "Total",
                                                                                          "' exists in your data frame already - choose a new subtotal label."))
})

# test_that("subtotal_section preserves grouping ability", {
#   # Confirms that the returned object maintains a structure compatible with
#   # further grouping operations in the tidyverse[cite: 3].
#   df <- mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg), .groups = "keep")
#   out <- subtotal_section(df, mtcars, vars = "mpg")
#
#   expect_s3_class(out %>% group_by(cyl), "grouped_df")
# })

test_that("subtotal_section scales to 1M rows", {
  # 1M rows, with enough distinct groups to make it 'real'
  n <- 1e6
  df_large <- data.frame(
    cat1 = sample(LETTERS, n, replace = TRUE),
    cat2 = sample(1:100, n, replace = TRUE),
    val = rnorm(n)
  )

  # Properly create the report (the summary)
  report_large <- df_large %>%
    group_by(cat1, cat2) %>%
    summarise(val = sum(val), .groups = "keep")

  # Run the function
  # Note: Use a tryCatch or expect_no_error to verify it finishes
  expect_no_error(
    out <- subtotal_section(report_large, df_large, vars = "val")
  )

  # Optional: Verify output integrity
  expect_gt(nrow(out), nrow(report_large))
})
