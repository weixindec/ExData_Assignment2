## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#calculate sum of emission by year
library(dplyr)
sum_by_year = group_by(NEI,year) %>% summarize(sum = sum(Emissions, na.rm = TRUE))

#plot figure
par(mgp=c(5,1,0), mar=c(5,6,4,2)+0.1)
png(file="plot1.png")
plot(sum_by_year, type = "l", col = "red", lwd = "4", las = 1, xaxp=c(1999,2008,9), ylab = "Total Emission of PM2.5", main = "Total Emission of PM2.5 for Year 1999, 2002, 2005 and 2008")
dev.off()
