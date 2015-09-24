library(ggplot2)

setwd("/Users/saran/explore1")
NEI <- readRDS("summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds")  #Source Classification Code
balt <-subset(NEI, NEI$fips==24510)           #Subset Baltimore area

total=aggregate(Emissions ~ year + type,FUN=sum,data=balt) ##Sum Emissions by year

##create ggplot

png("plot3.png")
pl <- ggplot(data=total, aes(x=factor(year), y=Emissions, fill=type))
pl <- pl +  geom_bar(stat="identity", position="dodge")
pl <-  pl + ggtitle("U.S. Vehicle Related Emissions in Baltimore between 1999 and 2008")
pl <- pl  + xlab("year") + ylab("Total Emissions")
print(pl)
dev.off()
