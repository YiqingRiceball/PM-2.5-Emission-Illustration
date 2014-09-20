# Set working directory
setwd("/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2")

# Create a PNG file to store the plot
png(filename="/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2/code and graphic/plot6.png",
    width = 480, 
    height = 480)

# Read in NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Read in Source Classification Code
SCC<-readRDS("Source_Classification_Code.rds")

# Load dplyr for subsetting
library(dplyr)

# Subset a data frame that stores that NEI information for both
# Balimore City and L.A
bal.la<-subset(NEI,fips =="24510"|fips=="06037")


# Find out and subset the data whose value in the EI Sector section 
# contains the word "motor" and "vehicle"
motorvehicle<-c("motor","vehicles")
motor.source<-unique(grep(paste(motorvehicle,collapse="|"),SCC$EI.Sector,value=TRUE,ignore.case=TRUE))
motor.scc<-subset(SCC,EI.Sector %in% motor.source)
# Use the souce code obtain from the last command to subset  
# the data frame with the PM 2.5 emission for Baltimore City and L.A
motor.bal.la<-subset(bal.la,SCC %in% motor.scc$SCC)

# Replace the fips number with city names so that city names 
# would appear on the top of each facet
motor.bal.la$fips[motor.bal.la$fips=="24510"]<-"Balitmore"
motor.bal.la$fips[motor.bal.la$fips=="06037"]<-"Los Angeles"
# Transform the year data in to strings so it would easier to 
# make a box plox for each year
motor.bal.la$year<-as.character(motor.bal.la$year)

# Since y axis would use log10 scale, here I replace value 0 
# with the mininum non-zero value
non0<-motor.bal.la$Emissions[!motor.bal.la$Emissions==0]
minimum<-min(non0)
motor.bal.la$Emissions[motor.bal.la$Emissions==0]<-minimum

# Create a plot with ggplot2
library(ggplot2)
q<-ggplot(motor.bal.la,aes(year,Emissions))+geom_boxplot()+geom_smooth(method="lm",aes(group = 1))+scale_y_log10()
q<-q+labs(title="Comparision of Motor Vehicle related PM 2.5 Emissions in Baltimore City and Los Angeles from 1999 to 2008",x="Year",y="PM 2.5 Emissions")
q<-q+facet_grid(.~fips)
print(q)

# Close graphic device
dev.off()