NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
head(NEI)
str(SCC)
head(SCC)
names(SCC)
unique(SCC$Short.Name)
SCC[grepl("Coal" , SCC$Short.Name), ]

SCCcoal <- SCC[grepl("Coal" , SCC$Short.Name), ]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC, ]
emi.coal.rltd <- summarise(group_by(NEIcoal, year), Emissions=sum(Emissions))

png("Plot4.png",width=480,height=480)
g <- ggplot(emi.coal.rltd, aes(x = factor(year), y = Emissions/1000, fill = year, label = round(Emissions/1000,2)))
g + geom_bar(stat="identity") + xlab("year") + ylab(expression("total PM"[2.5]*" emissions in kilotons")) +ggtitle("Emissions from coal combustion-related sources in kilotons")+geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.off()
