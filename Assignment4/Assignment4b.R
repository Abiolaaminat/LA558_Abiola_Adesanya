# Leaflet mapping: Taking the Chloroplet map and adding it to a web page.
# 
# March 18, 2023
# Abiola Adesanya

install.packages("leaflet", "leaflet.providers", "tidyverse", "readxl", "sf")
library(leaflet)
library(leaflet.providers)
library(tidyverse)
library(readxl)
library(sf)

vehicletype <- st_read("county_vehicles.shp")
vehicletype <- st_transform(vehicletype, crs = 4326)
vehicletype <- vehicletype %>% rename(count = id_count)

map <-leaflet()%>%
  setView(-97.5, 49.5, 9) %>%
  addTiles() %>%
  addPolygons(data = vehicletype, color = "red", fill = NA, weight = 1)
map

# Special selection
vehicletype_selection1 <- vehicletype %>%
  filter(COUNTY_NAM %in% c("Stearns", "Olmsted"))

#Display filtered counties
map <-leaflet()%>%
  setView(-97.5, 49.5, 9) %>%
  addTiles() %>%
  addPolygons(data = vehicletype_selection1, color = "blue", fillColor = "yellow", weight = 4, opacity = 0.8)
map

?leaflet::addPolygons

# Special selection 2
vehicletype_selection2 <- vehicletype %>%
  filter(is.na(count) | !count > 0)

# Replacing NA with 0
vehicletype <- vehicletype %>%
  replace(is.na(.), 0)

# Selecting color scheme from Color Brewer
library("RColorBrewer")
display.brewer.all()


bins <-c(0, 50, 100, 150, 200, 250, 300, Inf)
pal <-colorBin("Spectral", domain = vehicletype$count, bins = bins)

map <- leaflet() %>%
  setView(-97.5, 49.5, 9)  %>%
  addTiles() %>%
    addPolygons(data = vehicletype,
              fillColor = ~pal(count),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "1",
              fillOpacity = 0.8)
map


# Add interactions
map <- leaflet() %>%
  setView(-97.5, 49.5, 9)  %>%
  addTiles() %>%
  addPolygons(data = vehicletype,
              fillColor = ~pal(count),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "4",
              fillOpacity = 0.8,
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE)
              )
map
             
labels <- sprintf(
  "<strong>%s</strong><br/>%g carusers",
  vehicletype$COUNTY_NAM, vehicletype$count
) %>% lapply(htmltools::HTML)

#adding markers

longitude<- c(-93.362357, -94.723649, -94.19837)
latitude<- c(44.971331, 45.376846, 46.34936)
df <- data.frame(longitude, latitude)

#convert to spatial data frame
df_sf = st_as_sf(df, coords = c("longitude", "latitude"), crs = 4326)


map <- leaflet() %>%
  setView(-97.5, 49.5, 9) %>%
  addTiles() %>%
  addMarkers(data = df_sf) %>%
  #fitBounds(bounds[1], bounds[2], bounds[3], bounds[4]) %>%
  addPolygons(data = vehicletype,
              fillColor = ~pal(count),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "4",
              fillOpacity = 0.8,
              highlightOptions = highlightOptions(
                weight = 2,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "10px",
                direction = "auto"))
map
                             

bounds <- vehicletype %>%
  st_bbox() %>%
  as.character()
fitBounds(map, bounds[1], bounds[2], bounds[3], bounds[4])

# adding legend
map %>% addLegend(pal = pal, values = count, opacity = 0.7, title = "CarUsers",
                  position = "bottomright")