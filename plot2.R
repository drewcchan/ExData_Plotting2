#Reads in data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsets the Baltimore data and calculates total emissions grouped by year

baltSubset<-NEI[which(NEI$fips=="24510"),]
totalBalt<-tapply(baltSubset$Emissions, baltSubset$year, sum)

#Creates image

png("plot2.png", width=480, height=480)
barplot(totalBalt,xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Total PM2.5 Emissions in Baltimore between 1999 and 2008")
dev.off()