#Loads packages

library(ggplot2)
library(dplyr)

#Reads in data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filters for Baltimore data
#Groups data based on type and year for the Baltimore data
#Calculates the total emissions based on the groups

groupTypeData<-filter(NEI, fips=="24510")%>%
        group_by(type, year)%>%
        summarize(Total=sum(Emissions))

#Creates image

png("plot3.png", width=480, height=480)
qplot(factor(year), Total, data=groupTypeData,fill=type, geom="bar",stat="identity", facets=.~type,xlab="Year",ylab="PM2.5 Emissions (tons)", main="PM2.5 Emissions in Baltimore between 1999 and 2008") + guides(fill=FALSE)
dev.off()