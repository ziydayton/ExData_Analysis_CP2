## This code was developed to for the Coursera Exploratory Data Analysis course.
## Author:  Dayton, Jeff
## Date: 24 August 2019
## Assignment #4 (week 4), Course Project #2, Part #6 (plot 6).  This code generates plot 6 only.

## Question 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?

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
#Ensuring png is 480x480pixels - Although defealt; included for specificity
png(filename = "plot6.png",
    width = 480,
    height = 480,
    units = "px")

#Set plot pallette
par(mfrow = c(1, 1))

#sort and prepare df; than make ggplot
NEI %>% 
   select(year, Emissions, SCC, fips) %>%
   filter(fips %in% c("24510", "06037")) %>%
   rename(Year = year) %>%
   subset(SCC %in% MVEm$SCC) %>% 
   group_by(Year, fips) %>%
   summarise(Total_Emissions = sum(Emissions)) %>% 
   ggplot(aes(x = Year, y = Total_Emissions)) +
   geom_point(aes(color = fips)) +
   geom_line(aes(color = fips)) +
   labs(x = "Year", 
        y = "Total PM2.5 Emissions [tons]",
        title ="Yearly Motor Vehicle PM2.5 Emissions",
        subtitle = "for Baltimore City, MD, and Los Angeles County, CA") +
   scale_color_discrete(name = "Locations",
                        labels = c("06037" = "Los Angeles County, CA", 
                                   "24510" = "Baltimore City, MD"))

#Turn off png device
dev.off()
