NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)
head(SCC)
baltimore <- subset(NEI, fips == '24510')
LA <- subset(NEI, fips == "06037")
blatandLA <- subset(NEI, fips == "24510" | fips == "06037")
head(baltimore)

SCCv <- SCC[grepl("vehicle" , SCC$SCC.Level.Two, ignore.case=TRUE), ]
blatandLA <-  blatandLA[blatandLA$SCC %in% SCCv$SCC, ]
blatandLA
blatandLA$fips[which(blatandLA$fips == '24510')] <- 'Baltimore'
blatandLA$fips[which(blatandLA$fips == '06037')] <- 'LA'
unique(blatandLA$fips)
head(blatandLA)
BLA <- aggregate(Emissions ~ year+ fips, blatandLA, sum)
BLA
BLA <- rename(BLA, city = fips)

png(filename = "Plot6.png")
g <- ggplot(BLA, aes(x = factor(year), y = Emissions/1000,label=round(Emissions/1000,2), fill = year))

g + geom_bar(stat = "identity") + facet_grid(. ~ city) +
    ylab(expression('PM'[2.5]*' Emissions in Kilotons')) + xlab("Year") +
    ggtitle("Los Angeles vs Baltimore Vehicle Emissions.")

dev.off()
