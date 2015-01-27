#Loads packages

library(ggplot2)
library(dplyr)

#Reads in data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Creates a vector for only coal combustion sources
#Subsets for only the coal data
#Merges the 2 datasets and only keeps the coal related data
#Groups by year
#Calculates the total emissions based on the groups

coalVector<-grep("[Cc]omb.*[Cc]oal", SCC$Short.Name)
SCCCoalSubset<-SCC[coalVector,]
mergedCoalData<-inner_join(SCCCoalSubset, NEI)%>%
        group_by(year)%>%
        summarize(Total=sum(Emissions))

#Creates image

png("plot4.png", width=480, height=480)
qplot(factor(year), Total, data=mergedCoalData,geom="bar",stat="identity", xlab="Year",ylab="Emissions from Coal Combustion-related Sources (tons)", main="Emissions from Coal Combustion-related Sources \n in the United States between 1999 and 2008")
dev.off()