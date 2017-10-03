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
## get subset data from 'Baltimore'
baltimore <- subset(dt, fips == '24510')

## get total emissions by year and type (ebyt)
ebyt <- baltimore[, list(emissions=sum(Emissions)), by=c('year', 'type')]

png('plot3.png', width=480, height=480)
g <- ggplot(data=ebyt, aes(x=year, y=emissions, col=type))
g <- g + geom_line() + geom_point() + xlab("Year") + ylab("Emissions") + ggtitle("Emissions by type in Baltimore City")
print(g)
dev.off()