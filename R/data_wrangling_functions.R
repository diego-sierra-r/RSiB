#' Filter a data.frame using regex

#' @description This function is a wrapper of [dplyr::filter()] and [stringr::str_detect()] that makes partial matching easier.
#' @param df A data.frame.
#' @param column A string with the column name to filter.
#' @param terms A vector with a pattern to match or regular expressions.
#' @param exclude Logical,
#' * `TRUE`: Keep values that does not match terms.
#' * `FALSE`(the default): Keep just those values whose match terms.
#' @returns A data.frame
#' @examples
#' filter_if_match(iris,"Species",terms = "ica", exclude = FALSE)
#' filter_if_match(iris,"Species",terms = "^s\\w+a$", exclude = FALSE)
#' @export
#'

filter_if_match <- function(df,column,terms, exclude = FALSE) {
  if (!is.data.frame(df)) {
    stop("You must provide an object of class data.frame ", "not a ", class(df))
  }
  output <- df
  if (!is.character(column)) {
    column <- as.character(column)
  }
  if (exclude == FALSE) {
    for (i in terms) {
      output <- dplyr::filter(output,
                              stringr::str_detect(output[[column]],
                                                  pattern = as.character(i))
      )
    }

  } else {
    for (i in terms) {
      output <- dplyr::filter(output,
                              !stringr::str_detect(output[[column]],
                                                  pattern = as.character(i))
      )
    }
  }
  if (nrow(df) == nrow(output)) warning("All rows in your data.frame match the terms, nothing to do.")
  if (nrow(output) == 0 ) message("Your terms excluded all rows")

  return(output)
}

#' Pick slices of a data.frame
  #' @description With [slicer()] it's possible subset rows choosing how wide you want the resulting data.drame and which slice you want to pick.
  #' @param df A data.frame.
  #' @param slice An integer or an object which can be coerced to such, the slice number to keep.
  #' @param wide An integer or an object which can be coerced to such, the number of rows the slice is going to have.
  #' @returns a data.frame
  #' @examples
  #' slicer(iris,1,4)
  #' slicer(iris,6,2)
  #' @export
  #'
slicer <- function(df, slice, wide) {
  if (!is.data.frame(df)) {
    stop("You must provide an object of class data.frame ", "not a ", class(df))
  }

  if (slice == 1) {
    keeper = c(1,wide)
  } else if (slice == 2) {
    keeper = c((wide + 1), (wide *2))

  } else if (slice >2) {
    keeper = c((wide*(slice -1)+ 1), (wide*slice))
    if (keeper[2] > nrow(df)) warning("slice out of index, NAs introduced to fill spaces")
  }

  output <- df[(keeper[1]):(keeper[2]),]
  return(output)
}

#' Select relevant variables from GBIF data.frame
#' @description Select most revant columns from a data.frame generated by [get_specie_records()], . Also this function drop NAs from  "decimalLongitude", "decimalLatitude" columns.
#' @param df A data.frame generated by [get_specie_records()].
#' @param drop.coor.na Logical TRUE (The deault) drop NA values from "decimalLongitude", "decimalLatitude" columns. FALSE keep NAs.
#' @returns A data.frame.
#' @examples
#' relevant_vars(caiman_crocodilus)
#' @export
#'
relevant_vars  <- function(df, drop.coor.na = TRUE) {
  df <- df[, c("speciesKey", "scientificName","family", "dateIdentified",
               "decimalLongitude", "decimalLatitude", "stateProvince",  "year",
               "month",  "day" )]
  if (drop.coor.na == TRUE) {
    df <- dplyr::filter(df,!is.na(decimalLongitude) | !is.na(decimalLatitude))
  }
  return(df)
}
