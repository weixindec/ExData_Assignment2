## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

#Filter and Merge Data
Motor_SCC = filter(SCC, Data.Category == "Onroad")
Baltimore_LA_NEI = filter(NEI, fips=="24510" | fips == "06037")
merged = merge(Baltimore_LA_NEI, Motor_SCC, by = "SCC")

#calculate sum by year and type in Baltimore City
Motor_Baltimore_LA_sum_by_year_fips = group_by(merged, year, fips) %>% summarize(sum = sum(Emissions, na.rm = TRUE))

#plot figure
png(file= "plot6.png", width = 800)
plot6 = ggplot(Motor_Baltimore_LA_sum_by_year_fips, aes(year, sum, color = factor(fips, labels = c("Baltimore City", "Los Angeles County")))) + geom_point() + geom_smooth(method = "lm") + theme(legend.title = element_blank()) + ylab('Total Emissions') + labs(title = "Total Emission of PM2.5 by Motor Vehicle Sources in Baltimore City and Los Angeles County from 1999-2008")
print(plot6)
dev.off()