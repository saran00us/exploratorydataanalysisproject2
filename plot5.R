library(ggplot2)

setwd("/Users/saran/explore1")
NEI <- readRDS("summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds")  #Source Classification Code

## Filter vehicle word from Short.Name in SCC
vehi <- unique(grep("vehicle", SCC$Short.Name, ignore.case=TRUE, value=TRUE))
vehiclelabel <- subset(SCC, Short.Name %in% vehi)

## subset and total by year data related to vehicle in NEI

vehicle1 <- subset(NEI ,  SCC %in% vehiclelabel$SCC & NEI$fips==24510)
total=aggregate(Emissions ~ year,FUN=sum,data=vehicle1)


png("plot5.png")
pl <- ggplot(data=total, aes(x=factor(year), y=Emissions))
pl <- pl +  geom_bar(stat="identity", position="dodge")
pl <-  pl + ggtitle("U.S. Vehicle Related Emissions in Baltimore between 1999 and 2008")
pl <- pl  + xlab("year") + ylab("Total Emissions")
print(pl)
dev.off()
