# Set working directory
setwd("/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2")

# Create a PNG file to store the plot
png(filename="/Users/defaultuser/Desktop/Exploratory Data Analysis/project 2/code and graphic/plot2.png",
    width = 480, 
    height = 480)

# Read in NEI data
NEI <- readRDS("summarySCC_PM25.rds")


# Create a list of each year
ls<-seq(1999,2008,3)

# Create an empty vector to store the sum of 
# PM 2.5 emission of Baltimore City each year
Total<-vector()

# Load library dplyr for subsetting
library(dplyr)

# Calculate the the sum of PM 2.5 emission 
# each year and store the result in Total
for (i in ls){   
    tmp<-subset(NEI,fips =="24510"&year==i)   
    tmpSum<-sum(tmp[,4])
    Total<-c(Total,tmpSum)    
} 

# Plot the sum against each year
plot(ls,Total/1000,
     xlab="Year",
     ylab="Total Emission (thousand tons)",
     axes=FALSE,
     main="P.M2.5 Emission of Baltimore")
axis(side=1,at=ls)
axis(side=2,at=seq(1,4,0.5))

# Close the graphic device
dev.off()
