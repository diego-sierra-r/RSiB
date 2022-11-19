#res <- GET("https://api.gbif.org/v1/occurrence/search?year=1800,2023&limit=3&country=AF")
library(httr)
library(jsonlite)
library(rvest)

# TODO cambiar el for loop con una lsita en lugar de dataframes, esta muy lento
#- Comparar tiempos con benchmarch
#- Poner cocos 2020 como dataset default

print_counter <- function(counter,offset) {
  counter <- counter + 1
  cat( "Processing ",counter,"of", offset, "pages\r")
  flush.console()
  return(counter)
}

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

