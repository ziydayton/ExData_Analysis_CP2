## This code was developed to for the Coursera Exploratory Data Analysis course.
## Author:  Dayton, Jeff
## Date: 24 August 2019
## Assignment #4 (week 4), Course Project #2, Part #3 (plot 3).  This code generates plot 3 only.

## Question 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

##Clear environment
rm(list = ls())

##Call libraries
library(dplyr)
library(ggplot2)

## Read in the data files (Files unzipped and in working directory.)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Generate plot
#Ensuring png is 480x480pixels - Although defealt; included for specificity
png(filename = "plot3.png",
    width = 480,
    height = 480,
    units = "px")

#Set plot pallette
par(mfrow = c(1, 1))

#sort and prepare df; than make ggplot
NEI %>% 
   select(year, Emissions, type, fips) %>%
   filter(fips == 24510) %>%
   rename(Year = year, Type = type) %>%
   group_by(Year, Type) %>%
   summarise(Total_Emissions = sum(Emissions)) %>% 
ggplot(aes(x = Year, y = Total_Emissions)) +
   geom_point(aes(color = Type)) +
   geom_line(aes(color = Type)) +
   labs(x = "Year", 
        y = "Total PM2.5 Emissions [tons]",
        title ="Total Baltimore City, MD, PM2.5 Emissions",
        subtitle = "By Sum for Each Type of Source",
        color = "Source Type") 

#Turn off png device
dev.off()
