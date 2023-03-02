# Assignment 3
# 
# March 01, 2023
# Abiola Adesanya

#Load API keys

census_api_key("2736ef8695756790e2cc8dbc73fcc6398115ea2f", install = TRUE)
readRenviron("~/.Renviron")

#Install Packages

install.packages(c("tidycensus", "tidyverse"))
library(tidycensus)
library(tidyverse)

#working with American Community Survey (ACS) Data
# create a table of the ACS Variables

vars <- load_variables(2021, "acs5")
View(vars)

Food_stamps <- get_acs(
  geography = "county",
  state = "Texas",
  variables = "B22003_004",
  summary_var = "B22003_001",
  year = 2021,
  geometry = TRUE
)
View(Food_stamps)

plot(Food_stamps["estimate"])


Food_stamps <- Food_stamps %>%
  mutate(fs_percent = round(estimate/ summary_est, 3)*100)

plot(Food_stamps["fs_percent"]) 



plot1 <- ggplot(data = Food_stamps) +
  geom_sf(aes(fill = fs_percent)) + 
  scale_colour_brewer(palette = "Spectral") +
  coord_sf(crs = "+init=epsg:3081") +
  labs(title = "Percent households that received food stamps", fill="percent") +
  theme(rect = element_blank(), axis.ticks = element_blank(), 
        axis.text.x = element_blank(), axis.text.y = element_blank())
plot1

#Plot 2
Population_by_Race <- get_acs(
  geography = "county",
  state = "Texas",
  variables = "B02001_003",
    year = 2021,
  geometry = TRUE
)
View(Population_by_Race)

#selecting top 5 counties
top_counties <- filter(Population_by_Race, estimate >=100000)

top_counties

#creating a pie chart

library(ggplot2)

mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF", "#33658A", "#55dde0", "#F26419")
pie(top_counties$estimate, labels = top_counties$NAME, main = "Top Counties with Population above 100000", col = mycols)
  
#Plot 3
library(readxl)
setwd("C:/Users/Adesanya Aminat A/Desktop/LA 558/LA558_Abiola_Adesanya/Assignment3")

BIPOC_MN <- read_excel('race3.xlsx')
View(BIPOC_MN)

# Bringing in a shapefile

library("sf")
setwd("C:/Users/Adesanya Aminat A/Desktop/LA 558/LA558_Abiola_Adesanya/Assignment3")
Minnesota <- st_read("mn.shp")

#Plotting the shapefile
ggplot() +
  geom_sf(data = Minnesota, size = 3, color = "black", fill = "grey") + 
  ggtitle("Spatial Distribution of Blacks, Indigenous and People of Color in Minnesota") +
  coord_sf()

#to join 
myMap <- left_join(Minnesota, BIPOC_MN, by = "GISJOIN")

#Plotting

ggplot(myMap) + 
  geom_sf(aes(fill = BIPOC_PER))+
  ggtitle("Spatial Distribution of Blacks, Indigenous and People of COlor in Minnesota")

#remove the background and center the title
ggplot(myMap) + 
  geom_sf (aes(fill = BIPOC_PER))+
  ggtitle("Spatial Distribution of Blacks, Indigenous and People of COlor in Minnesota")+
  theme_void() + 
  # move the title text to the middle
  theme(plot.title=element_text(hjust=0.5))

plot3 <- ggplot(data = myMap) +
  geom_sf(aes(fill = BIPOC_PER)) + 
  scale_colour_brewer(palette = "Spectral") +
  coord_sf(crs = "+init=epsg:26849") +
  labs(title = "Spatial Distribution of Blacks, Indigenous and People of COlor in Minnesota", fill="BIPOC_PER") +
  theme(rect = element_blank(), axis.ticks = element_blank(), 
        axis.text.x = element_blank(), axis.text.y = element_blank())
