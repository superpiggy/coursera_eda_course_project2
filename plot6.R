## read R datasets
if (!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

library('data.table')
library('ggplot2')

dt <- data.table(NEI)
## get subset data from 'Baltimore' & 'Los Angeles' and motor vehicles
twoCities <- subset(dt, fips %in% c('06037', '24510') & type == 'ON-ROAD')

## get total emissions by year and fips (ebyf)
ebyf <- twoCities[, list(emissions=sum(Emissions)), by=c('year', 'fips')]

## replace fips strings for better legend
ebyf$fips[ebyf$fips == '24510'] <- "Baltimore"
ebyf$fips[ebyf$fips == '06037'] <- "Los Angeles"

png('plot6.png', width=480, height=480)
g <- ggplot(data=ebyf, aes(x=year, y=emissions, col=fips))
g <- g + geom_line() + geom_point() + xlab("Year") + ylab("Emissions") + ggtitle("Emissions from motor vehicles in Baltimore and Los Angeles")
print(g)
dev.off()
