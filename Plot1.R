NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)
head(SCC)
unique(NEI$year)

sumbyyear <- with(NEI, aggregate(Emissions, by = list(year), FUN = 'sum'))
sumbyyear

png("Plot1.png",width=480,height=480)

barplot(height=sumbyyear$x/1000, names.arg=sumbyyear$Group.1, type = "o", main = expression('Total PM'[2.5]*' emissions at various years in kilotons'), 
        xlab = "Year", ylab=expression('total PM'[2.5]*' emission in kilotons'),col = sumbyyear$Group.1, ylim=c(0,8000))

dev.off()
