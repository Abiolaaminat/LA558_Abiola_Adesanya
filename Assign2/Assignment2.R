# Importing an excel file - lecture 5a
# 
# February 14, 2023
# Abiola Adesanya

install.packages("tidyverse")
library(tidyverse)

library(readxl)
setwd("C:/Users/Adesanya Aminat A/Desktop/LA 558/LA558_Abiola_Adesanya/R")

disability_data <- read_excel('Copy of 2017-2021 disability data.xlsx')


# add values across the two columns

#Total male: m+o+q
disability_data1 <- disability_data %>% 
  mutate(
    Total_male = as.numeric(`35to64_M`) + as.numeric(`65to74_ M`) + as.numeric(`75_M`)
  )

#Total male with disability: n + p+ r
disability_data2 <- disability_data1 %>% 
  mutate(
    Total_male_with_disability = as.numeric(`35to64_M(With disability)`) + as.numeric(`65to74_M(with disability)`) + as.numeric(`75_M(with disability)`)
  )

#Total female: s+u+w
disability_data3 <- disability_data2 %>% 
  mutate(
    Total_female = as.numeric(`35to64_F`) + as.numeric(`65to74_F`) + as.numeric(`75_F`)
  )

#Total female with disability: t+v+x
disability_data4 <- disability_data3 %>% 
  mutate(
    Total_female_with_disability = as.numeric(`35to64_F(With disability)`) + as.numeric(`65to74_F(with disability)`) + as.numeric(`75toF_(with disability)`)
  )

#Total: total male+ total female 
disability_data5 <- disability_data4 %>% 
  mutate(
    Total_population= Total_male + Total_female
  )

#Total disability: total male with disabikity + total female with disability
disability_data6 <- disability_data5 %>% 
  mutate(
    Total_disability = Total_male_with_disability + Total_female_with_disability
  )

# remove columns with NA

disability_data7  <- select(disability_data6 , -BTTRA,-...12)

#Total %: total male+ total female 
disability_data8 <- disability_data7 %>% 
  mutate(
    Totalmale_percentage= (Total_male_with_disability/Total_male)*(100)
  )

disability_data9 <- disability_data8 %>% 
  mutate(
    Totalfemale_percentage= (Total_female_with_disability/Total_female)*(100)
  )

disability_data10 <- disability_data9 %>% 
  mutate(
    Totaldisability_percentage= (Total_disability/ Total_population)*(100)
  )



# To create barchart

library(ggplot2)


# Filter the data to include only the observations you want to plot

filtered_data <- disability_data10 %>% filter(COUNTY %in% c("Lucas County", "Emmet County", "Fayette County", "Clarke County", "Wapello County"))

data_chart <- filtered_data %>% select(COUNTY,Totalmale_percentage,Totalfemale_percentage, Totaldisability_percentage)


library(ggplot2)

# Create a bar chart of COUNTY against Totaldisability_percentage
myplot1 <- ggplot(data = data_chart, aes(x = COUNTY, y = Totaldisability_percentage)) +
  geom_bar(stat = "identity", width = 0.5) +
  xlab("County") +
  ylab("Total Disability Percentage") +
  ggtitle("Total Disability Percentage by County")


#  create a bar chart of county against Totalmale_percentage and Totalfemale_percentage
# plot using ggplot2


ggplot(data = data_chart, aes(x = COUNTY)) +
  geom_bar(aes(y = Totalmale_percentage, fill = "Male"), stat = "identity", position = "dodge") +
  geom_bar(aes(y = Totalfemale_percentage, fill = "Female"), stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("Male" = "blue", "Female" = "red")) +
  xlab("COUNTY") +
  ylab("PERCENTAGE") +
  ggtitle("Gender Distribution in Top Five Counties")






