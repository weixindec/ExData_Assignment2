## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#calculate sum of emission by year
library(dplyr)

Baltimore_NEI = filter(NEI, fips == "24510")
Sum_by_type_year = group_by(Baltimore_NEI,year, type) %>% summarize(sum = sum(Emissions, na.rm = TRUE))

#plot figure
png(file="plot3.png")
plot3= ggplot(Sum_by_type_year, aes(year, sum, col = type)) + geom_line() + labs(y = "Total Emission of PM2.5") + labs(title = "Total Emission of PM2.5 by Baltimore City")
print(plot3)
dev.off()