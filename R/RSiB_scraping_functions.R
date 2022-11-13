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
get_onthophagus <- function(limit, offset, year, all.records = FALSE) {
  counter <- 0
  output <- data.frame()
  if (all.records == FALSE) {
    for (i in 1:offset) {
      path <- paste0("https://api.gbif.org/v1/occurrence/search?country=CO&speciesKey=1089875",
                     "&","limit=",limit,"&","offset=",i,"&","year=",year)
      res <- res <- GET(path)
      x <- fromJSON(rawToChar(res$content), flatten = TRUE)
      try(output <- rbind(output,x$results), silent = T)
      counter <- counter + 1
      cat(counter,"\r")
      flush.console()
    }
  } else {
    path <- paste0("https://api.gbif.org/v1/occurrence/search?country=CO&speciesKey=1089875",
                   "&","limit=",limit,"&","offset=","1","&","year=",year)
    res <- res <- GET(path)
    x <- fromJSON(rawToChar(res$content), flatten = TRUE)
    offset <- x$count
    for (i in 1:offset) {
      path <- paste0("https://api.gbif.org/v1/occurrence/search?country=CO&speciesKey=1089875",
                     "&","limit=",limit,"&","offset=",i,"&","year=",year)
      res <- res <- GET(path)
      x <- fromJSON(rawToChar(res$content), flatten = TRUE)
      try(output <- rbind(output,x$results), silent = T)
      counter <- counter + 1
      cat(counter,"\r")
      flush.console()
    }

  }


  return(output)
}
