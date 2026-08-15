library(testthat)
library(tidyverse)

test_that("subtotal_section outputs are consistent", {

  # 1. Standard Case: Basic grouping
  df_simple <- mtcars %>% group_by(cyl) %>% summarise(mpg = mean(mpg), .groups = "keep")
  expect_snapshot(subtotal_section(df_simple, mtcars, vars = "mpg"))

  # 2. Multi-column case
  df_multi <- mtcars %>% group_by(cyl, gear, vs) %>% summarise(hp = sum(hp), .groups = "keep")
  expect_snapshot(subtotal_section(df_multi, mtcars, vars = "hp"))

  # 3. Handling bad inputs (expecting errors)
  # Snapshots can also capture errors to ensure the error message doesn't change
  df_bad <- mtcars %>% summarise(mpg = mean(mpg))
  expect_snapshot(error = TRUE, subtotal_section(df_bad, mtcars, vars = "mpg"))
})

test_that("subtotal_section advanced scenarios", {

  # 1. Iris dataset (Numeric focus)
  # Verifies handling of non-mtcars data and multiple numeric columns
  df_iris <- iris %>%
    group_by(Species) %>%
    summarise(Sepal.Length = sum(Sepal.Length),
              Sepal.Width = sum(Sepal.Width), .groups = "keep")
  expect_snapshot(subtotal_section(df_iris, iris, vars = c("Sepal.Length", "Sepal.Width")))

  # 2. Diamonds dataset with 'exclude' argument
  # Verifies that we can selectively exclude a grouping variable from subtotaling
  # We group by cut, color, and clarity, but exclude 'cut' (index 1)
  df_dia <- ggplot2::diamonds %>%
    group_by(cut, color, clarity) %>%
    summarise(price = mean(price), .groups = "keep")
  expect_snapshot(subtotal_section(df_dia, ggplot2::diamonds, vars = "price", aggregator = "mean", exclude = 1))

  # 3. Custom Subtotal Label, Aggregation Parameter, Max Aggregator
  # Verifies the parameter passing for the text label
  df_cars <- mtcars %>% group_by(cyl, gear) %>% summarise(mpg = max(mpg), .groups = "keep")
  expect_snapshot(subtotal_section(df_cars, mtcars, vars = "mpg",
                                   aggregator = "max", subtotal_label = "Grand Total", agg_parameter = list(na.rm = TRUE)))

  # 4. Handling NAs (Robustness Test)
  # Verifies that if the data frame contains NAs, it doesn't crash the function
  df_na <- airquality %>%
    group_by(Month) %>%
    summarise(Ozone = mean(Ozone, na.rm = TRUE), .groups = "keep")
  expect_snapshot(subtotal_section(df_na, airquality, vars = "Ozone"))

  # 5. Multi-Variable, Multi-Group, Multi-Exclusion (Stress Test)
  # Verifies that subtotaling works when summarizing multiple columns
  # AND when excluding multiple grouping variables (indices 2 and 3)
  df_complex <- mtcars %>%
    group_by(cyl, gear, carb) %>%
    summarise(mpg = median(mpg),
              disp = median(disp), .groups = "keep")

  expect_snapshot(subtotal_section(df_complex, mtcars,
                                   vars = c("mpg", "disp"),
                                   aggregator = "median",
                                   exclude = c(2, 3)))

  # 6. Exotic Aggregator (Standard Deviation) on Factor-Heavy Data
  # Verifies robustness using 'warpbreaks' (a classic R dataset)
  # Uses 'sd' as the aggregator and ensures it respects the grouping structure
  df_breaks <- warpbreaks %>%
    group_by(wool, tension) %>%
    summarise(breaks = sd(breaks), .groups = "keep")
  expect_snapshot(subtotal_section(df_breaks, warpbreaks,
                                   vars = "breaks",
                                   aggregator = "sd"))

  # 6. Data Type Edge Case (Dates and Logicals)
  # Verifies that subtotaling doesn't accidentally convert Date classes to raw
  # numeric values (a very common bug in custom aggregation tools) or mess up logicals.
  df_dates <- data.frame(
    report_date = as.Date(c("2026-07-01", "2026-07-01", "2026-08-01", "2026-08-01")),
    is_active = c(TRUE, TRUE, FALSE, TRUE),
    revenue = c(100, 200, 150, 300)
  ) %>%
    group_by(report_date, is_active) %>%
    summarise(revenue = sum(revenue), .groups = "keep")

  expect_snapshot(subtotal_section(df_dates,
                                   data.frame(report_date = as.Date(c("2026-07-01", "2026-07-01", "2026-08-01", "2026-08-01")), is_active = c(TRUE, TRUE, FALSE, TRUE), revenue = c(100, 200, 150, 300)),
                                   vars = "revenue"))

  # 7. Data Shape Edge Case (Grouped by NA and Single-Row Groups)
  # Verifies behavior when the grouping variable itself contains an NA value,
  # and when groups only contain a single row (does it crash if n=1?).
  df_weird_groups <- data.frame(
    category = c("A", "A", NA, "B"),
    value = c(10, 15, 20, 25)
  ) %>%
    group_by(category) %>%
    summarise(value = sum(value), .groups = "keep")

  expect_snapshot(subtotal_section(df_weird_groups,
                                   data.frame(category = c("A", "A", NA, "B"), value = c(10, 15, 20, 25)),
                                   vars = "value"))

})

test_that("Snapshot: High cardinality, multiple variables, default aggregator", {
  set.seed(101)

  # 10,000 rows, 3 label columns with varying levels, 2 variable outputs
  frame <- data.frame(
    region = sample(paste0("Region_", 1:5), 10000, replace = TRUE),
    store_id = sample(paste0("Store_", 1:50), 10000, replace = TRUE),
    category = sample(LETTERS[1:10], 10000, replace = TRUE),
    sales = round(runif(10000, 10, 1000), 2),
    profit = round(rnorm(10000, 50, 20), 2)
  )

  report <- frame %>%
    group_by(region, store_id, category) %>%
    summarise(sales = sum(sales), profit = sum(profit), .groups = "drop")

  expect_warning({
    out <- subtotal_section(report, frame, vars = c("sales", "profit"))
  }, "Your report isn't grouped. Error handling may fail.")

  # Using as.data.frame to bypass dplyr metadata drift in snapshots
  expect_snapshot(as.data.frame(out))
})

#General Tests

test_that("Snapshot: Exclude parameter, median aggregator, uneven distribution", {
  set.seed(102)

  # 15,000 rows, focused on testing the 'exclude' logic and a non-sum aggregator
  frame <- data.frame(
    department = sample(c("HR", "IT", "Sales", "Marketing", "Executive"), 15000, replace = TRUE, prob = c(0.1, 0.3, 0.4, 0.15, 0.05)),
    role = sample(c("Junior", "Mid", "Senior", "Lead"), 15000, replace = TRUE),
    salary = round(rlnorm(15000, meanlog = 11, sdlog = 0.5), 0)
  )

  report <- frame %>% group_by(department, role) %>%
    summarise(salary = median(salary), .groups = "keep")

  # Applying exclude parameter (assuming syntax based on standard implementations)
  out <- subtotal_section(report, frame, vars = "salary", aggregator = "median")

  expect_snapshot(as.data.frame(out))
})

test_that("Snapshot: Deep grouping (4 levels), custom function, missing values", {
  set.seed(103)

  # 20,000 rows, 4 levels of grouping, testing a custom lambda aggregator with NAs
  frame <- data.frame(
    year = sample(2023:2026, 20000, replace = TRUE),
    quarter = sample(c("Q1", "Q2", "Q3", "Q4"), 20000, replace = TRUE),
    product_line = sample(c("Hardware", "Software", "Services"), 20000, replace = TRUE),
    status = sample(c("Active", "Legacy", "Beta"), 20000, replace = TRUE),
    uptime = runif(20000, 0.90, 0.999),
    latency = rnorm(20000, 50, 15)
  )

  # Inject NAs to test aggregator robustness
  frame$uptime[sample(1:20000, 500)] <- NA

  report <- frame %>%
    group_by(year, quarter, product_line, status) %>%
    summarise(uptime = max(uptime), latency = max(latency), .groups = "keep")

  expect_warning({
    out <- subtotal_section(report, frame, vars = c("uptime", "latency"), aggregator = "max")
  }, "NA values detected in output. Setting agg_parameter to \"na.rm\" may resolve this.")


  expect_snapshot(as.data.frame(out))
})


test_that("subtotal_section snapshot tests for default and na.rm behavior", {

  # Test 1: Default run snapshot
  res_default <- group_by(mtcars, cyl, gear, carb) %>%
    summarise(median(wt), .groups = "keep") %>%
    subtotal_section(mtcars, vars = "wt", aggregator = "median")

  expect_snapshot(res_default)

  # Test 2: Using the supported agg_parameter = "na.rm" branch
  res_narm_param <- group_by(mtcars, cyl, gear, carb) %>%
    summarise(mean(wt), .groups = "keep") %>%
    subtotal_section(mtcars, vars = "wt", aggregator = "mean", agg_parameter = list(na.rm = TRUE))

  expect_snapshot(res_narm_param)

  # Test 3: Comparing default vs na.rm on data with zero NAs (mtcars data has no NAs in wt)
  res_plain_mean <- group_by(mtcars, cyl, gear, carb) %>%
    summarise(mean(wt), .groups = "keep") %>%
    subtotal_section(mtcars, vars = "wt", aggregator = "mean")

  # They should be identical since there are no NAs to remove
  expect_equal(res_plain_mean, res_narm_param)

  # Test 4: Complex Scenario 1 - Multiple variables with trimmed mean (trim parameter)
  # Test 4: Complex Scenario 1 - Multiple variables with trimmed mean (trim parameter)
  res_complex_trim <- group_by(mtcars, cyl, gear, carb) %>%
    summarise(mean(wt), mean(hp), .groups = "keep") %>%
    subtotal_section(
      mtcars,
      vars = c("wt", "hp"),
      aggregator = "mean",
      agg_parameter = list(trim = 0.1, na.rm = TRUE)
    )

  expect_snapshot(res_complex_trim)
  # Test 5: Complex Scenario 2 - Multiple variables with quantile (probs parameter)

  res_complex_quantile <- group_by(mtcars, cyl, gear, carb) %>%
    summarise(quantile(wt, 0.75), quantile(hp, 0.75), .groups = "keep") %>%
    subtotal_section(
      mtcars,
      vars = c("wt", "hp"),
      aggregator = "quantile",
      agg_parameter = list(probs = 0.75, names = FALSE)
    )

  expect_snapshot(res_complex_quantile)
})

#
# subtotal_section(report, frame, vars = c("uptime", "latency"), aggregator = "max")
# subtotal_section(report, frame, vars = c("uptime", "latency"), aggregator = "custom_max")
