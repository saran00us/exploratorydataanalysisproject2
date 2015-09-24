library(ggplot2)

setwd("/Users/saran/explore1")
NEI <- readRDS("../summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("../Source_Classification_Code.rds")  #Source Classification Code

## Filter vehicle word from Short.Name in SCC
vehi <- unique(grep("vehicle", SCC$Short.Name, ignore.case=TRUE, value=TRUE))
vehiclelabel <- subset(SCC, Short.Name %in% vehi)

## subset and total by year data related to vehicle in NEI

 vehicleb <- subset(NEI ,  SCC %in% vehiclelabel$SCC & NEI$fips==24510)


vehiclela <- subset(NEI ,  SCC %in% vehiclelabel$SCC & NEI$fips==06037)

vehicle2 <- rbind(vehiclela, vehicleb)
total1=aggregate(Emissions ~ year+fips,FUN=sum,data=vehicle2)


png("plot6.png")
pl <- ggplot(data=total1, aes(x=factor(year), y=Emissions, fill=fips))
pl <- pl +  geom_bar(stat="identity", position="dodge")
pl <-  pl + ggtitle("U.S. Emission Comparison between Baltimore and Los Angeles between 1999 and 2008")
pl <- pl  + xlab("year") + ylab("Total Emissions")
print(pl)
dev.off()