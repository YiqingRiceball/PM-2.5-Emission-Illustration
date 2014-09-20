setwd("/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2")
png(filename="/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2/code and graphic/plot4.png",
    width = 480, 
    height = 480)

NEI <- readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

# Find out and subset the data whose value in the EI Sector section 
# contains the word "coal"
# I decided to use the EI sector to locate coal combustion related 
# source code because though SCC.Level.Three and SCC.Level.Four also
# have values containing the word "coal", them also include non-combustion 
# sources.One the other hand, the values in the EI Sector containing the
# word "coal" are  "Fuel Comb - Electric Generation - Coal",
# "Fuel Comb - Industrial Boilers, ICEs - Coal"and "Fuel Comb - Comm/Institutional - Coal",
# which are all combustion related (Here I understand "Fuel Comb" as abbreviation for "Fuel Combustion",
# because "Fuel Combustion" is the first autofill option in google search when I type "fuel comb").
coal.source<-unique(grep("coal",SCC$EI.Sector,value=TRUE,ignore.case=TRUE))
coal.scc<-subset(SCC,EI.Sector %in% coal.source)
coal.related<-subset(NEI,SCC %in% coal.scc$SCC)

# Transform the year data in to strings so it would easier to 
# make a box plox for each year
coal.related$year<-as.character(coal.related$year)

# Since y axis would use log10 scale, here I replace value 0 
# with the mininum non-zero value
non0<-coal.related$Emissions[!coal.related$Emissions==0]
minimum<-min(non0)
coal.related$Emissions[coal.related$Emissions==0]<-minimum

# Create a plot with ggplot2
q<-ggplot(coal.related,aes(year,Emissions))+geom_boxplot()+scale_y_log10()
q<-q+labs(title="Coal Combustion related PM 2.5 Emissions from 1999 to 2008",x="Year",y="PM 2.5 Emissions")
print(q)

# Turn off graphic device
dev.off()