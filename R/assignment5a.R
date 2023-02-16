# Importing an excel file - lecture 5a
# 
# February 14, 2023
# Abiola Adesanya


install.packages(c("tidycensus", "tidyverse", plotly"))

install.packages(c("googlesheets4"))

library(tidyverse)

```{r}

```

install.packages("tidyverse")
library(tidyverse)


library(readxl)
disability_data <- read_excel('2017-2021 disability data.xlsx')

Disability_data <-

cDisabilityList <- cDisability %>&
  group_by(COUNTY) %>%
 

# add value  across two columns

Totalmale <- disability_data %>% mutate(sum='35-64M' + '65-74M' + '75+M')

gimpse(disability_data) %>% 
names()




