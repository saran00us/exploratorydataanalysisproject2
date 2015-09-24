library(ggplot2)

setwd("/Users/saran/explore1")
NEI <- readRDS("summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds")  #Source Classification Code

## Filter coal word from Short.Name in SCC
coa <- unique(grep("coal", SCC$Short.Name, ignore.case=TRUE, value=TRUE))
coallabel <- subset(SCC, Short.Name %in% coa)

## subset and total by year data related to coal in NEI

coal1 <- subset(NEI ,  SCC %in% coallabel$SCC)
total=aggregate(Emissions ~ year,FUN=sum,data=coal1)

png("plot4.png")
pl <- ggplot(data=total, aes(x=factor(year), y=Emissions))
pl <- pl +  geom_bar(stat="identity", position="dodge")
pl <-  pl + ggtitle("U.S. Coal Related Emissions between 1999 and 2008")
pl <- pl  + xlab("year") + ylab("Total Emissions")
print(pl)
dev.off()
