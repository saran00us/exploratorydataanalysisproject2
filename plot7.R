library(ggplot2)
library(dplyr)
library(plyr)


setwd("/Users/saran/explore1")
NEI <- readRDS("../summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("../Source_Classification_Code.rds")  #Source Classification Code

## Filter vehicle word from Short.Name in SCC
vehi <- unique(grep("vehicle", SCC$Short.Name, ignore.case=TRUE, value=TRUE))
vehiclelabel <- filter(SCC, Short.Name %in% vehi)

## subset and total by year data related to vehicle in NEI

vehicle <- filter(NEI ,  SCC %in% vehiclelabel$SCC,fips %in% c("24510","06037"))
vehicle$fips <- revalue(vehicle$fips, c("24510"="Baltimore","06037"="Los Angeles"))


total1=aggregate(Emissions ~ year+fips,FUN=sum,data=vehicle)


png("plot6.png")
pl <- ggplot(data=total1, aes(x=factor(year), y=Emissions, fill=fips))
pl <- pl +  geom_bar(stat="identity", position="dodge")
pl <-  pl + ggtitle("Emission for Baltimore & Los Angeles bet. 1999 & 2008")
pl <- pl  + xlab("year") + ylab("Total Emissions")
pl + scale_fill_manual(values=c("red","green"), labels=c("Baltimore", "Los Angeles"))
print(pl)
dev.off()
