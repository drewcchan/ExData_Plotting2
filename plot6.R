#Loads packages

library(ggplot2)
library(dplyr)

#Reads in data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Creates a vector for only the vehicle sources
#Subsets based on vehicle vector
#Merges 2 datasets and only keeps the vehicle related data
#Filters for Baltimore  and Los Angeles data
#Groups by city code and year
#Calculates total emissions based on groups

vehicleVector<-grep("[Vv]ehicle", SCC$SCC.Level.Two)
SCCVehSubset<-SCC[vehicleVector,]
mergedVehData2<-inner_join(SCCVehSubset, NEI)%>%
        filter(fips=="24510"|fips=="06037")%>%
        group_by(fips, year)%>%
        summarize(Total=sum(Emissions))

#Creates a new City variable based on the city code

mergedVehData2$City<-as.factor(mergedVehData2$fips)
levels(mergedVehData2$City)<-c("Los Angeles", "Baltimore")

#Creates image

png("plot6.png", width=480, height=480)
qplot(factor(year), Total, data=mergedVehData2, fill=City,geom="bar",stat="identity", facets=.~City, xlab="Year",ylab="Motor Vehicle Emissions (tons)", main="Motor Vehicle Emissions in Los Angeles and Baltimore \n between 1999 and 2008") + guides(fill=FALSE)
dev.off()