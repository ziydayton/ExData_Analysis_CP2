## This code was developed to for the Coursera Exploratory Data Analysis course.
## Author:  Dayton, Jeff
## Date: 24 August 2019
## Assignment #4 (week 4), Course Project #2, Part #5 (plot 5).  This code generates plot 5 only.

## Question 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##Clear environment
rm(list = ls())

##Call libraries
library(dplyr)
library(ggplot2)

## Read in the data files (Files unzipped and in working directory.)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Determine the approapriate SCC's for motor vehicle sources
MVEm <- SCC[grep("Mobile", SCC$EI.Sector), ]

##Generate plot
##Ensuring png is 480x480pixels - Although defealt; included for specificity
png(filename = "plot5.png",
    width = 480,
    height = 480,
    units = "px")

##Set plot pallette
par(mfrow = c(1, 1))

##sort and prepare df; than make ggplot
NEI %>% 
   select(year, Emissions, SCC, fips) %>%
   filter(fips == 24510) %>%
   rename(Year = year) %>%
   subset(SCC %in% MVEm$SCC) %>% 
   group_by(Year) %>%
   summarise(Total_Emissions = sum(Emissions)) %>% 
   ggplot(aes(x = Year, y = Total_Emissions)) +
   geom_point() +
   geom_line() +
   labs(x = "Year", 
        y = "Total PM2.5 Emissions [tons]",
        title ="Motor Vehicle PM2.5 Emissions for Baltimore City, MD",
        subtitle = "Yearly Sum of All  Motor Vehicle-Related Sources") 

##Turn off png device
dev.off()
