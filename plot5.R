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
## get subset data from 'Baltimore' and motor vehicles
baltimore <- subset(dt, fips == '24510' & type == 'ON-ROAD')

## get total emissions by year (eby)
eby <- baltimore[, list(emissions=sum(Emissions)), by=year]

png('plot5.png', width=480, height=480)
g <- ggplot(data=eby, aes(x=year, y=emissions))
g <- g + geom_line() + geom_point() + xlab("Year") + ylab("Emissions") + ggtitle("Emissions from motor vehicles in Baltimore")
print(g)
dev.off()