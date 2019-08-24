## This code was developed to for the Coursera Exploratory Data Analysis course.
## Author:  Dayton, Jeff
## Date: 24 August 2019
## Assignment #4 (week 4), Course Project #2, Part #1 (plot 1).  This code generates plot 1 only.

## Question 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##Clear environment
rm(list = ls())

##Call libraries
library(dplyr)

## Read in the data files (Files unzipped and in working directory.)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##sort and prepare df
df <- NEI %>% 
   select(year, Emissions) %>% 
   rename(Year = year) %>%
   group_by(Year) %>%
   summarise(Total_Emissions = sum(Emissions))

##Generate plot
##Ensuring png is 480x480pixels - Although defealt; included for specificity
png(filename = "plot1.png",
    width = 480,
    height = 480,
    units = "px")

##Set plot pallette
par(mfrow = c(1, 1))

##Create plot
plot(x = df$Year,
     y = df$Total_Emissions,
     type = "b",
     main = "Total PM2.5 Emissions by Year (All Sources)",
     xlab = "Year",
     ylab = "Total PM2.5 Emissions [tons]",
     ylim = c(0, max(df$Total_Emissions, na.rm = TRUE)))

##Turn off png device
dev.off()
