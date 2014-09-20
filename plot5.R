setwd("/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2")
png(filename="/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2/code and graphic/plot5.png",
    width = 480, 
    height = 480)

NEI <- readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

# Subset a data frame that stores that NEI information for Balimore City 
baltimore<-subset(NEI,fips =="24510")

# Find out and subset the data whose value in the EI Sector section 
# contains the word "motor" and "vehicle"
motorvehicle<-c("motor","vehicles")
motor.source<-unique(grep(paste(motorvehicle,collapse="|"),SCC$EI.Sector,value=TRUE,ignore.case=TRUE))
motor.scc<-subset(SCC,EI.Sector %in% motor.source)
# Use the souce code obtain from the last command to subset  
# the data frame with the PM 2.5 emission for Baltimore City 
motor.related<-subset(baltimore,SCC %in% motor.scc$SCC)

# Transform the year data in to strings so it would easier to 
# make a box plox for each year
motor.related$year<-as.character(motor.related$year)

# Since y axis would use log10 scale, here I replace value 0 
# with the mininum non-zero value
non0<-motor.related$Emissions[!motor.related$Emissions==0]
minimum<-min(non0)
motor.related$Emissions[motor.related$Emissions==0]<-minimum

# Create plot with ggplot2
q<-ggplot(motor.related,aes(year,Emissions))+geom_boxplot()+scale_y_log10()
q<-q+labs(title="Motor Vehicle related PM 2.5 Emissions in Baltimore City from 1999 to 2008",x="Year",y="PM 2.5 Emissions")
print(q)

# Close graphic device
dev.off()