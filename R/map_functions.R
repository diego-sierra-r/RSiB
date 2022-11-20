# usar funcion de https://r-pkgs.org/dependencies.html 11.2.1 para indcar la instalacion de colmaps


### learning

map_colombia  <- function(df,
                          coords = c("decimalLongitude", "decimalLatitude"),
                          legend.show = FALSE,
                          column) {
  colombia_dep <- sf::st_as_sf(departamentos)
  df <- dplyr::filter(df,!is.na(decimalLongitude) |
                        !is.na(decimalLatitude))

  points <- sf::st_as_sf(df,
                     coords = coords,
                     crs = sf::st_crs(colombia_dep)$proj4string)
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
    tm_dots(col = column,
            shape = "scientificName",
            size = 0.3) +
    tm_layout(legend.show = legend.show)
  return(m)
}

map_depto  <- function(df,
                       depto,
                       coords = c("decimalLongitude", "decimalLatitude"),
                       legend.show = FALSE,
                       column = "scientificName") {
  if (is.null(depto)) stop("depto is NULL, you must provide it")
  colombia_dep <-
    sf::st_as_sf(municipios[which(as.character(depto) == municipios$depto), ])
  df <- dplyr::filter(df,!is.na(decimalLongitude) |
                        !is.na(decimalLatitude))

  points <- sf::st_as_sf(df,
                     coords = coords,
                     crs = sf::st_crs(colombia_dep)$proj4string)
  m <- tm_shape(colombia_dep) +
    tm_polygons() +
    tm_scale_bar(
      just = c("RIGHT", "BOTTOM"),
      breaks = c(0, 12 , 24),
      text.size = 0.5,
      position = c("left", "bottom"),
    ) +
    tm_layout(bg.color = "white",
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
  colombia_mun <-
    sf::st_as_sf(municipios[which(as.character(municipio) == municipios$municipio), ])
  df <- dplyr::filter(df,!is.na(decimalLongitude) |
                        !is.na(decimalLatitude))

  points <- sf::st_as_sf(df,
                     coords = coords,
                     crs = sf::st_crs(colombia_mun)$proj4string)
  m <- tm_shape(colombia_mun) +
    tm_polygons() +
    tm_scale_bar(
      just = c("RIGHT", "BOTTOM"),
      breaks = c(0, 4 , 8),
      text.size = 0.5,
      position = c("left", "bottom"),
    ) +
    tm_layout(
      bg.color = "white",
      title = municipios$municipio[which(municipios$municipio == municipio)],
      title.size = 1
    ) +
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
