text_map <- function(lng, lat, place){
  glue::glue(
    "
```{{r echo = FALSE}}
library(leaflet)
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng={lng}, lat={lat}, popup='{place}')
m
```
"
    )
}