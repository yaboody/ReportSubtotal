#' Duplicate Subtotal Row Removal Function

#' @description Removes duplicate subtotal rows,
#' which may be created by totalling a variable with only one level.
#' In tables with many variables, some may have only one level within one section and many in other sections.

#' @param data Data report or data frame to remove duplicate row labels from.
#' @param column Column containing duplicate row labels.
#' @param iterator Minimum number of rows meant to be between each section. Usually two.
#' @param skip Number of rows to skip removing rows from. Usually zero. Can be used to dodge NA values.
#' @param remove Label of subtotals to be removed. Usually "Total".
#' @param lead_name Default name for lead column used to filter duplicates.

#' @details Adds a leading version of the requested column,
#' which places each observation in the same row as the next observation.
#' This is usually the observation 2 rows on, and is determined by the iterator parameter.
#' Then, if both the original and leading column equal the value to be removed,
#' then the row is considered a duplicate subtotal and is removed.
#' Note: Columns named Lead will receive a temporary suffix.

#' @return The data report without duplicate subtotal rows.
#' @export

#' @examples
#' library(dplyr)
#'
#' group_by(mtcars, cyl, vs) %>% summarise(sum(wt), .groups = "keep") %>%
#' subtotal_row(mtcars, "wt") %>%
#' subtotal_dupe_removal(2)

#' group_by(mtcars, cyl, vs, am) %>% summarise(mean(hp), .groups = "keep") %>%
#' subtotal_row(mtcars, "hp", "mean") %>%
#' subtotal_dupe_removal(3, skip = 1)

#' group_by(mtcars, cyl, vs, am) %>% summarise(mean(hp), .groups = "keep") %>%
#' subtotal_row(mtcars, "hp", "mean") %>%
#' subtotal_dupe_removal(3, skip = 1)

subtotal_dupe_removal <- function(data, column, iterator = 2, skip = 0,
                                  remove = "Total", lead_name = "Lead_Column"){
  if(length(column) > 1){
    stop("This function only accepts one column")
  }
  if(nrow(data) <= iterator | nrow(data) <= skip){
    warning(ifelse(nrow(data) <= iterator,
                   "Your iterator is too big for this data report.",
                   "You're skipping through too many rows."))
  }

  data <- ungroup(data)
  column_name <- names(data)[column]
  i <- 1

  while(lead_name %in% names(data) & i < 1000){
    lead_name <- paste0(lead_name, letters[sample(1:length(letters), 1)])
    i <- i + 1
  }
  if(i == 1000){
    stop("Please designate an unused name in your data frame in the lead_name parameter
         and try again.")
  }

  lead_data <- mutate(data, !!sym(lead_name) := lead(.data[[column_name]], n = iterator))

  lead_data_filter <- filter(lead_data,
                          !(row_number() > skip & .data[[lead_name]] == remove & .data[[column_name]] == remove) &
                            !(row_number() > (nrow(data) - iterator) & .data[[column_name]] == remove)
  )

  select(lead_data_filter, -all_of(lead_name))
}
