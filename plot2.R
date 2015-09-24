


##read the dataset as the dataset is already loaded as part of Plot1.R script running


setwd("/Users/saran/explore1")
NEI <- readRDS("summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds")  #Source Classification Code
balt <-subset(NEI, NEI$fips==24510)           #Subset Baltimore area

total=aggregate(Emissions ~ year,FUN=sum,data=balt) ##Sum Emissions by year

##create barplot as part of the base plotting system
png("plot2.png")
barplot(height=total$Emissions,names.arg=total$year, col="blue", main="Total Emissions by Year for Baltimore", xlab="Year", ylab="Emissions")
dev.off()