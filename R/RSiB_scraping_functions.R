#res <- GET("https://api.gbif.org/v1/occurrence/search?year=1800,2023&limit=3&country=AF")
library(httr)
library(jsonlite)
res <- GET("https://api.gbif.org/v1/occurrence/search?facetcountry=CO&speciesKey=1089875&limit=300&offset=171&year=2017")
res$status_code
x <- fromJSON(rawToChar(res$content), flatten = TRUE)
View(x$results)

# TODO cambiar el for loop con una lsita en lugar de dataframes, esta muy lento
#- comparar tiempos con benchmarch
#- modificar funcion parque te indique que especie estas descargando data
#- cambiar nombra de la funcion a get_specie_records

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
      res <- res <- GET(path)# crear una funcion para no repetri esta parte
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
