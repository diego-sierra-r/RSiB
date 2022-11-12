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
  if (nrow(df) == nrow(output)) warning("All rows if your data.frame match the terms, nothing to do.")
  if (nrow(output) == 0 ) message("Your terms excluded all rows")

  return(output)
}



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
