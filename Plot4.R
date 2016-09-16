## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

#calculate sum of emission by year
library(dplyr)
SCC_Coal = filter(SCC, grepl("[cC]oal", Short.Name))
merged = merge(NEI, SCC_Coal, by = "SCC")
Coal_sum_by_year_type = group_by(merged, year, type) %>% summarize(sum = sum(Emissions, na.rm = TRUE))

png(file="plot4.png", width = 800)
plot3= ggplot(Coal_sum_by_year_type, aes(year, sum, col = type)) + geom_line() + labs(y = "Total Emission of PM2.5") + labs(title = "Total Emission of PM2.5 by Coal Combustion-related sources from 1999-2008")
print(plot3)
dev.off()