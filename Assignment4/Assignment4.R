# Leaflet mapping: adding multiple markers to slippy map
# March 18, 2023
# Abiola Adesanya

#Installing packages
install.packages("leaflet", "leaflet.providers", "tidyverse")
library(leaflet)
library(leaflet.providers)
library(tidyverse)


# reading csv file
cartype200 <- read.csv("Cartypes_200.csv", header = TRUE)
cartype500 <- read.csv("cartypes_500.csv", header = TRUE)
cartype1000 <-read.csv("cartypes_1000.csv", header = TRUE)
myData <- cartype200

# Adding markers from the CSV to this map
map <- leaflet(myData) %>% 
  addTiles() %>%
  addMarkers(~Longitude, ~Latitude)
map


# Changing markers to circles
map <- leaflet(myData) %>% 
  addTiles() %>%
  addCircles(~Longitude, ~Latitude, label = myData$Vehicle_Type)
map

# adding popup of the individual's car type
map <- leaflet(myData) %>% 
  addTiles() %>%
  addCircles(~Longitude, ~Latitude, popup = paste("<strong>", 
                                                  myData$last_name, "</strong><br>", "vehicle type: ", 
                                                  myData$Vehicle_Type))
map

# Changing the size and colors of the circles
map <- leaflet(myData) %>% 
  addTiles() %>%
  addCircles(~Longitude, ~Latitude, popup= paste("<strong>", 
                                                 myData$last_name, "</strong><br>", "Vehicle type: ", 
                                                 myData$Vehicle_Type), weight = 4, radius=1000, 
             color="purple", stroke = TRUE, fillOpacity = 0.8)

map
?addsquare

# Time to add some options for the base map
# See the complete set of Leaflet providers 
# http://leaflet-extras.github.io/leaflet-providers/preview/index.html
# Running the following should display the map layers in the console.
names(providers)


# We now have an button containing a group of background layers
map <- leaflet(myData) %>% 
  addTiles(group = "OSM", options = providerTileOptions(minZoom = 4, maxZoom = 10)) %>%
  addProviderTiles("Esri.WorldImagery", group = "Imagery", 
                   options = providerTileOptions(minZoom = 8, maxZoom = 10)) %>%
  addProviderTiles("Thunderforest.Neighbourhood", group = "Neighbourhood") %>%
  addProviderTiles("Stamen.TonerLite", group = "Lite") %>%
  addProviderTiles("OpenStreetMap.HOT", group = "HOT") %>%
  addProviderTiles("TomTom.Basic", group = "Basic") %>%
  addLayersControl(baseGroups = c("OSM", "Imagery", "Neighbourhood", "Lite", "HOT", "Basic"),
                   options = layersControlOptions(collapsed = TRUE)) %>%
  addCircles(~Longitude, ~Latitude, popup= paste("<strong>", 
                                                 myData$last_name, "</strong><br>", "Vehicle type: ", 
                                                 myData$Vehicle_Type), weight = 4, radius=40, 
             color="purple", stroke = TRUE, fillOpacity = 1.2)
map

# Adding markers from the CSV with 1000 to this map. 
myData <-cartype1000
map <- leaflet(myData) %>% 
  addProviderTiles("Stamen.TonerLite", 
                   options = providerTileOptions(minZoom = 4, maxZoom = 10)) %>%
  addMarkers(~Longitude, ~Latitude)
map

# Making clusters
map <- leaflet(myData[1:500,]) %>% 
  addProviderTiles("Stamen.TonerLite", 
                   options = providerTileOptions(minZoom = 4, maxZoom = 10))%>%
  addMarkers(~Longitude, ~Latitude, clusterOptions = markerClusterOptions())
map

# On all 1,000 locations
map <- leaflet(myData) %>% 
  addProviderTiles("Stamen.TonerLite", 
                   options = providerTileOptions(minZoom = 4, maxZoom = 10))%>%
  addMarkers(~Longitude, ~Latitude, clusterOptions = markerClusterOptions())
map