# TODO cambiar el for loop con una lsita en lugar de dataframes, esta muy lento
# quitar in "An integer" from documentation, to a number
#- Comparar tiempos con benchmarch
#- Poner cocos 2020 como dataset default
#- hide print_counter
# ponerle una clase al output de get_specie_records y testearlo
# despues de docuemntar ver si citation() sirve

#' Print a simple counter
#' @description Simple counter printer used in [RSiBCOL::get_specie_records()] to give information to the user.
#' @param counter An integer, The counter's startpoint.
#' @param offset An integer, the page number from SiB API.
#' @return An integer.
#' @export
#'

print_counter <- function(counter,offset) {
  counter <- counter + 1
  cat( "Processing ",counter,"of", offset, "pages\r")
  flush.console()
  return(counter)
}

#' Get record from SiB API
#' @description Create queries and generate a data.frame with information from
#' SiB databases using the GIBF API.
#' @details With this function is possible create queries to the GIBF API to get
#' a dataframe with all records registered in Colombia in SiB databases for a
#' specie during a particular year.
#'
#' The output data.fame include relevant information such as taxonomy details,
#' coordinates, states/province where the specimens where collected and dates.
#' @param limit An integer. The number of rows you want to get by offset.
#' Maximum possible number is 300 because of API limitations.
#' @param offset An integer. If there are more that 300 records GIFB API release
#' additional records in a different offset (page), this parameter is useful to
#' select an specific page, when all.records = TRUE offset is recalculated internally.
#' @param year numeric vector representing a single year.
#' @param all.records Boolean, when TRUE (default) this function calculate the max offset number and return all records on GBIF databases. Use FALSE to get just some records specified by limit and offset.
#' @param specieKey A numeric vector with a single GBIF taxon ID, you can search those IDs in GBIF Backbone Taxonomy database visiting [GBIF Backbone Taxonomy](https://www.gbif.org/species/search)
#' @return A dataframe.
#' @examples
#' get_specie_records(limit = 1,offset = 1, year = 2020, all.records = F,specieKey = 8953936)
#' get_specie_records(limit = 300,offset = NULL, year = 2020, all.records = T,specieKey = 8953936)
#' @export
#'

get_specie_records <- function(limit = 300,
                            offset,
                            year,
                            all.records = T,
                            specieKey) {
  counter <- 0
  output <- data.frame()
  if (all.records == FALSE) {
    for (i in 1:offset) {
      path <- paste0("https://api.gbif.org/v1/occurrence/search?country=CO&speciesKey=",
                     specieKey,"&","limit=",limit,"&","offset=",i,"&","year=",year)
      res <- GET(path)# crear una funcion para no repetri esta parte
      x <- fromJSON(rawToChar(res$content), flatten = TRUE)
      try(output <- rbind(output,x$results), silent = T)
      counter <- RSiBCOL::print_counter(counter,offset)
    }
  } else {
    path <- paste0("https://api.gbif.org/v1/occurrence/search?country=CO&speciesKey=",
                   specieKey,"&","limit=",limit,"&","offset=","1","&","year=",year)
    res <- res <- GET(path)
    x <- fromJSON(rawToChar(res$content), flatten = TRUE)
    offset <- x$count
    for (i in 1:offset) {
      path <- paste0("https://api.gbif.org/v1/occurrence/search?country=CO&speciesKey=",
                     specieKey,"&","limit=",limit,"&","offset=",i,"&","year=",year)
      res <- res <- GET(path)
      x <- fromJSON(rawToChar(res$content), flatten = TRUE)
      try(output <- rbind(output,x$results), silent = T)
      counter <- RSiBCOL::print_counter(counter,offset)
    }
  }
  return(output)
}

