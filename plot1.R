## download the dataset 
setwd("/Users/saran/explore1")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="NEI_data.zip",method="curl")
unzip(zipfile="./NEI_data.zip")

##read the dataset

NEI <- readRDS("summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds")  #Source Classification Code

total=aggregate(Emissions ~ year,FUN=sum,data=NEI) ##Sum Emissions by year

##create barplot as part of the base plotting system
png("plot1.png")
barplot(height=total$Emissions,names.arg=total$year, col="red", main="Total Emissions by Year", xlab="Year", ylab="Emissions")
dev.off()
