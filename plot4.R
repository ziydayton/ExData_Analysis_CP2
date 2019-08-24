## This code was developed to for the Coursera Exploratory Data Analysis course.
## Author:  Dayton, Jeff
## Date: 24 August 2019
## Assignment #4 (week 4), Course Project #2, Part #4 (plot 4).  This code generates plot 4 only.

## Question 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

##Clear environment
rm(list = ls())

##Call libraries
library(dplyr)
library(ggplot2)

## Read in the data files (Files unzipped and in working directory.)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Determine the approapriate SCC's for Coal Combustion
CoalComb <- SCC[grep("Comb", SCC$SCC.Level.One), ]
CoalComb <- CoalComb[grep("Coal", CoalComb$Short.Name), ]

##Generate plot
#Ensuring png is 480x480pixels - Although defealt; included for specificity
png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px")

#Set plot pallette
par(mfrow = c(1, 1))

#sort and prepare df; than make ggplot
NEI %>% 
   select(year, Emissions, SCC) %>%
   rename(Year = year) %>%
   subset(SCC %in% CoalComb$SCC) %>% 
   group_by(Year) %>%
   summarise(Total_Emissions = sum(Emissions)) %>% 
   ggplot(aes(x = Year, y = Total_Emissions)) +
   geom_point() +
   geom_line() +
   labs(x = "Year", 
        y = "Total PM2.5 Emissions [tons]",
        title ="Total Coal Combustion PM2.5 Emissions for the US",
        subtitle = "Sum of All Yearly Coal Combustion-Related Sources") 

#Turn off png device
dev.off()
