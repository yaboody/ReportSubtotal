#' Column Validation Function
#'
#' @description Handles errors and warnings for subtotal functions.

#' @param col A (non-numeric) column to be validated.
#' @param col_name Name of the column to be validated.
#' @param context_label Determines whether columns in the report or frame are being validated (for warnings).

#' @details Handles factor, logical, or character columns which are meant to be aggregated.

#' @return The column as a numeric object (if possible), an error if not, warnings in cases of changes.
#' @noRd

validate_column <- function(col, col_name, context_label) {
  if (is.factor(col)) {
    col <- as.character(col)
  }

  if (is.logical(col)) {
    warning(paste0("\nIn ", context_label, ": Aggregation Variable '", col_name, "' is logical; coercing to numeric."))
    return(as.numeric(col))
  }

  if (is.character(col)) {
    vals <- suppressWarnings(as.numeric(col))
    if (sum(is.na(vals)) > sum(is.na(col))) {
      stop(paste0("\nError in ", context_label, ":Aggregation variable '", col_name, "' contains character strings, and cannot be summarized properly."), call. = FALSE)
    }
    return(vals)
  }

  return(col)
}

#' Error Handling Function
#'
#' @description Handles errors and warnings for subtotal functions.

#' @param report A data report.
#' @param frame Data frame summarised by the data report.
#' @param vars Names of column(s) in the data frame aggregated in the data report.
#' @param aggregator Function to aggregate the data with.
#' @param exclude Vector of column indices determining which variables require fewer subtotals than usual.
#' @param agg_parameter A named list of optional parameter(s) for the aggregation function to use.
#' @param subtotal_label Label to be used for subtotal rows.

#' @details Handles errors, returning altered parameters where necessary and error messages where not.

#' @return Altered parameters (report, frame, variables, aggregator), plus errors or warnings as needed.
#' @noRd

subtotal_error_handle <- function(report, frame, vars, aggregator, exclude, agg_parameter, subtotal_label){
  final_label <- ncol(report) - length(vars)
  label_cols <- 1:final_label
  label_names <- names(report)[label_cols]
  exclude_length <- length(exclude)

  if (!all(c(label_names, vars) %in% names(frame))){
    stop("\nSome requested variables are not in your data frame.", call. = FALSE)
  }
  if(nrow(report) == 0){
    stop("\nYour data report has zero rows!", call. = FALSE)
  }
  if (ncol(report) == 1){
    stop("\nYour data report has only one column!", call. = FALSE)
  }
  if (ncol(report) == length(vars)){
    stop("\nYour data report has only variable columns!", call. = FALSE)
  }
  if (any(vapply(report, is.list, logical(1)))) {
    stop("\nData report contains list-columns, which are not supported.", call. = FALSE)
  }
  if (any(vapply(frame, is.list, logical(1)))) {
    stop("\nData frame contains list-columns, which are not supported.", call. = FALSE)
  }
  if (ncol(frame) == 1){
    stop("\nYour data report is too small!", call. = FALSE)
  }

  if(!("grouped_df" %in% class(report))){
    warning("\nWarning: Your report isn't grouped. Error handling may fail.")
  }
  if("grouped_df" %in% class(report) & length(label_names) != length(groups(report))){
    if (length(label_names) < length(groups(report))) {
      stop("\nYou're using more aggregation variables than your report can hold!", call. = FALSE)
    } else {
      warning("\nWarning: You may not be using all the aggregation variables in your report.
              Try using .groups = keep in your summarise() call.")
    }
  }

  frame <- ungroup(frame)
  report <- ungroup(report)

  report <- mutate(report, across(where(is.Date) | where(is.POSIXt), as.character))
  frame <- mutate(frame, across(where(is.Date) | where(is.POSIXt), as.character))

  numeric_vars <- vapply(select(frame, all_of(vars)), is.numeric, logical(1))
  char_vars <- vars[!numeric_vars]
  if (length(char_vars) > 0){
    frame[char_vars] <- lapply(char_vars, function(col_name) {
      validate_column(frame[[col_name]], col_name, "data frame")
    })
  }

  report_var_cols <- names(report)[-label_cols]
  numeric_report_var_cols <- vapply(select(report, all_of(report_var_cols)), is.numeric, logical(1))
  char_report_var_cols <- report_var_cols[!numeric_report_var_cols]

  if (length(char_report_var_cols) > 0){
    report[char_report_var_cols] <- lapply(char_report_var_cols, function(col_name) {
      validate_column(report[[col_name]], col_name, "data report")
    })
  }

  if (any(vars %in% label_names)){
    overlaps <- vars[vars %in% label_names]
    frame <- mutate(frame, across(
      all_of(overlaps),
      list(Default_Suffix = identity),
      .names = "{.col}_{.fn}"
    ))
    vars[vars %in% label_names] <- paste0(overlaps, "_Default_Suffix")
    warning("\nWarning: your labels and variables are overlapping.
            The overlapping variables will receive a default suffix to try to fix this.\n")
  }


  if (length(aggregator) > 1){
    stop("\nThis function doesn't accept multiple aggregators", call. = FALSE)
  }
  if (aggregator == "n"){
    warning("\nNote: length() will replace n().")
    aggregator <- "length"
  }

  agg_func <- tryCatch(
    match.fun(aggregator),
    error = function(e) NULL
  )
  if (is.null(agg_func)) {
    stop(paste0("\nThe provided aggregator '", aggregator, "' is not a valid function."), call. = FALSE)
  }
  aggregator <- agg_func

  if (exclude_length > 0) {
    if (!all(exclude %in% label_cols)) {
      stop("\nSome excluded columns are not in the table", call. = FALSE)
    } else if (length(unique(exclude)) < exclude_length) {
      stop("\nSome excluded columns are repeated", call. = FALSE)
    }
  }

  if (exclude_length == length(label_cols)){
    warning("\nAs all labels are excluded, only a single summation row will be added.")
  }

  if (!is.list(agg_parameter)){
    stop("\nAggregation parameters must be named list objects -
           such as list(na.rm = TRUE)")
  } else {
    if (length(agg_parameter) > 0) {
      if (is.null(names(agg_parameter)) || any(names(agg_parameter) == "")) {
        stop("\nAll elements in the aggregator parameter list must be named -
              such as list(na.rm = TRUE)")
      }
    }
  }
  if (is.null(subtotal_label) || is.na(subtotal_label) || subtotal_label == "") {
    stop("subtotal_label must be a valid, non-empty character string.", call. = FALSE)
  }

  if (any(sapply(report, function(x){subtotal_label %in% as.character(x)}))){
    stop(paste0("\nThe chosen subtotal label '", subtotal_label,
                "' exists in your data frame already - choose a new subtotal label."))
  }

  return(list(frame = frame, report = report, vars = vars, aggregator = aggregator))
}
