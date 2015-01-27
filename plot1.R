#Reads in data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculates total emissions grouped by year

totalE<-tapply(NEI$Emissions, NEI$year, sum)

#Creates image

png("plot1.png", width=480, height=480)
barplot(totalE,xlab="Year", ylab="Total PM2.5 Emissions (tons)", main="Total PM2.5 Emissions in the United States \n between 1999 and 2008")
dev.off()