NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)
head(SCC)
baltimore <- subset(NEI, fips == '24510')
head(baltimore)
baltimore$year <- as.character(baltimore$year)

sumbyyear2 <- with(baltimore, tapply(Emissions, year, sum))

png("Plot2.png",width=480,height=480)

barplot(sumbyyear2/1000, type = "o", main = expression('Total PM'[2.5]*' emissions at various years in kilotons'), 
     xlab = "Year", ylab=expression('total PM'[2.5]*' emission in kilotons'),col = names(sumbyyear2), ylim = c(0,4))

dev.off()
