#Loads packages

library(ggplot2)
library(dplyr)

#Reads in data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Creates a vector for only the vehicle sources
#Subsets based on vehicle vector
#Merges 2 datasets and only keeps the vehicle related data
#Filters for Baltimore data
#Groups by year
#Calculates total emissions based on groups

vehicleVector<-grep("Veh", SCC$SCC.Level.Two)
SCCVehSubset<-SCC[vehicleVector,]
mergedVehData<-inner_join(SCCVehSubset, NEI)%>%
        filter(fips=="24510")%>%
        group_by(year)%>%
        summarize(Total=sum(Emissions))

#Creates image

png("plot5.png", width=480, height=480)
qplot(factor(year), Total, data=mergedVehData, geom="bar",stat="identity",xlab="Year",ylab="Motor Vehicle Emissions (tons)", main="Motor Vehicle Emissions in Baltimore between 1999 and 2008")
dev.off()
