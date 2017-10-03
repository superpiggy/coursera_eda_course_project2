## read R datasets
if (!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

library('data.table')
dt <- data.table(NEI)
## get subset data from 'Baltimore'
baltimore <- subset(dt, fips == '24510')

eby <- baltimore[, list(emissions=sum(Emissions)), by=year]

png('plot2.png')
barplot(height=eby$emissions, names.arg=eby$year, xlab="Year", ylab="Emissions", main="Total PM2.5 in Baltimore")
dev.off()