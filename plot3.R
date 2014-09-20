# Set working directory
setwd("/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2")

# Create a PNG file to store the plot
png(filename="/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2/code and graphic/plot3.png",
    width = 480, 
    height = 480)

# Read in NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Create a list of each year
ls<-seq(1999,2008,3)

# Load library dplyr for subsetting
library(dplyr)

# Select the data from Baltimore City
baltimore<-subset(NEI,fips =="24510")

library(ggplot2)
q<-ggplot(baltimore,aes(year,Emissions))+geom_point()+geom_smooth(method="lm")         
q<-q+facet_grid(.~type)
q<-q+scale_x_continuous(breaks=ls)
q<-q+labs(title="PM 2.5 Emissions of Baltimore City from 1999 to 2008",x="Year",y="PM 2.5 Emissions")
library(grid)
q<-q+theme(panel.margin = unit(1,"lines"))
print(q)

dev.off()