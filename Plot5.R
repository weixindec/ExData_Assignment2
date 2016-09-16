## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

#Filter and Merge Data
Motor_SCC = filter(SCC, Data.Category == "Onroad")
Baltimore_NEI = filter(NEI, fips=="24510")
merged = merge(Baltimore_NEI, Motor_SCC, by = "SCC")

#calculate sum by year and type in Baltimore City
Motor_Baltimore_sum_by_year_type = group_by(merged, year, type) %>% summarize(sum = sum(Emissions, na.rm = TRUE))

#plot figure
png(file= "plot5.png", width = 800)
plot5 = ggplot(Motor_Baltimore_sum_by_year_type, aes(year, sum, col = type)) + geom_line() + labs(y = "Total Emission of PM2.5") + labs(title = "Total Emission of PM2.5 by Motor Vehicle Sources in Baltimore City from 1999-2008")
print(plot5)
dev.off()