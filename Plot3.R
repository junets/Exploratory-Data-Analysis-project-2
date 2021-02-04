NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)
head(SCC)
baltimore <- subset(NEI, fips == '24510')
head(baltimore)
unique(baltimore$type)

library(ggplot2)
library(dplyr)
baltimore_type_year <- aggregate(Emissions ~ year+ type, baltimore, sum)
baltimore_type_year
g <- ggplot(data = baltimore_type_year, aes(year, Emissions))
summary(g)

png("Plot3.png",width=480,height=480)
g + geom_point(color = 'blue', size = 4 , alpha=.6) + facet_grid(.~type) + xlab('Year') + ylab('Total Emissions') + ggtitle("Total Annual Emissions in Baltimore by Year")

dev.off()
