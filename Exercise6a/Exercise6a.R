# Abiola Adesanya

# 2/23/2023

#Load API keys

census_api_key("2736ef8695756790e2cc8dbc73fcc6398115ea2f",  overwrite = FALSE, install = TRUE)

readRenviron("~/.Renviron")

#Install Packages

install.packages(c("tidycensus", "tidyverse", "mapview", "leafsync", "ggspatial"))

# Brand-new Features

install.packages("remotes")
remotes::install_github("walkerke/tidycensus")

#ACS
library(tidycensus)

census_api_key("2736ef8695756790e2cc8dbc73fcc6398115ea2f", install = TRUE)

#Checking for Variables
vars <-load_variables(2020, "pl")

View(vars)

(tigris_use_cache = TRUE)

#Map Creation
Mn_population <- get_decennial(
  geography = "county",
  variables = "P1_004N",
  state = "MN",
  year = 2020,
  geometry = TRUE
)

View(Mn_population) 

plot(Mn_population["value"])

library(tidyverse)

#Editing Map

Mn_map <- ggplot(Mn_population, aes(fill = value)) + geom_sf()+
  ggtitle("Spatial Distribution of Black or African American")+
  theme_void()

Mn_map

 
