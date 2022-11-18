library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(colmaps)
library(sf)
library(tmap)
library(raster)
library(spData)


caiman_crocodilus <- RSiBCOL::get_specie_records(limit = 300,
                                      offset = 30,
                                      year = 2020,
                                      all.records = T,
                                      specieKey = 8953936)

save(caiman_crocodilus, file="data/caiman_crocodilus.RData")


caiman_crocodilus <- caiman_crocodilus[,c("speciesKey","scientificName","family",
                      "dateIdentified","decimalLongitude",
                      "decimalLatitude","stateProvince",
                      "year","month","day")]
caiman_crocodilus <- dplyr::filter(caiman_crocodilus,
                                   !is.na(decimalLongitude) | !is.na(decimalLatitude))



### learning


map_colombia  <- function(df,
                          coords = c("decimalLongitude","decimalLatitude"),
                          legend.show = FALSE,
                          column) {

  colombia_dep <- st_as_sf(departamentos)
  df <- dplyr::filter(df,
                      !is.na(decimalLongitude) | !is.na(decimalLatitude))

  points <-st_as_sf(df,
                    coords = coords,
                    crs = st_crs(colombia_dep)$proj4string)
  m <- tm_shape(colombia_dep) +
    tm_polygons() +
    tm_compass(type = "8star",
               position = c("left", "top"),
               size = 1.5) +
    tm_scale_bar(
      breaks = c(0, 100, 200),
      text.size = 1,
      position = c("left", "bottom")
    ) +
    tm_layout(bg.color = "lightblue",
              title = "Colombia",
              title.size = 1) +
    tm_shape(points) +
    tm_dots(col = column, shape = "scientificName", size = 0.3) +
    tm_layout(legend.show = legend.show)
  return(m)
}
map_colombia(caiman_crocodilus)

map_depto  <- function(df,
                       depto,
                       coords = c("decimalLongitude", "decimalLatitude"),
                       legend.show = FALSE,
                       column = "scientificName") {

  colombia_dep <- st_as_sf(departamentos[which(as.character(depto) == departamentos$depto),])
  df <- dplyr::filter(df,
                      !is.na(decimalLongitude) | !is.na(decimalLatitude))

  points <-st_as_sf(df,
                    coords = coords,
                    crs = st_crs(colombia_dep)$proj4string)
  m <- tm_shape(colombia_dep) +
    tm_polygons() +
    tm_scale_bar(just = c("RIGHT","BOTTOM"),
      breaks = c(0, 25 ,50),
      text.size = 0.5,
      position = c("left", "bottom"),
    ) +
    tm_layout(bg.color = "lightblue",
              title = departamentos$depto[which(departamentos$depto == depto)],
              title.size = 1) +
    tm_shape(points) +
    tm_dots(
      col = column,
      shape = column,
      legend.shape.show = F,
      shapes.legend	= NULL,
      size = 0.8,
      border.col = "black",
      legend.hist	= F
    ) +
    tm_layout(legend.show = legend.show, legend.outside = legend.show)
  return(m)
}

map_mun  <- function(df,
                       municipio,
                       coords = c("decimalLongitude", "decimalLatitude"),
                       legend.show = FALSE,
                       column = "scientificName") {

  colombia_mun <- st_as_sf(municipios[which(as.character(municipio) == municipios$municipio),])
  df <- dplyr::filter(df,
                      !is.na(decimalLongitude) | !is.na(decimalLatitude))

  points <-st_as_sf(df,
                    coords = coords,
                    crs = st_crs(colombia_mun)$proj4string)
  m <- tm_shape(colombia_mun) +
    tm_polygons() +
    tm_scale_bar(just = c("RIGHT","BOTTOM"),
                 breaks = c(0, 5 ,10),
                 text.size = 0.5,
                 position = c("left", "bottom"),
    ) +
    tm_layout(bg.color = "lightblue",
              title = municipios$municipio[which(municipios$municipio == municipio)],
              title.size = 1) +
    tm_shape(points) +
    tm_dots(
      col = column,
      shape = column,
      legend.shape.show = F,
      shapes.legend	= NULL,
      size = 0.8,
      border.col = "black",
      legend.hist	= F
    ) +
    tm_layout(legend.show = legend.show, legend.outside = legend.show)
  return(m)
}





