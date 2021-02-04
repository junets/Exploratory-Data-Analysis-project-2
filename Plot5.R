NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)
head(SCC)
baltimore <- subset(NEI, fips == '24510')
head(baltimore)

SCCv <- SCC[grepl("vehicle" , SCC$SCC.Level.Two, ignore.case=TRUE), ]
baltimorev <-  baltimore[baltimore$SCC %in% SCCv$SCC, ]

sumvi <- with(baltimorev, aggregate(Emissions, by = list(year), FUN = sum))
sumvi
colnames(sumvi) <- c("year", "Emissions")
png(filename = "Plot5.png")

g <- ggplot(data = sumvi, 
            aes(x = factor(year), y = Emissions/1000), 
            fill = factor(year) , label = round(Emissions/1000,2))
g + geom_bar(stat="identity") + 
    xlab("year") + 
    ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City in kilotons") 

dev.off()