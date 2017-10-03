## read R datasets
## This first line will likely take a few seconds. Be patient!
if (!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

library('data.table')
dt <- data.table(NEI)
## get total emissions by year
eby <- dt[, list(emissions=sum(Emissions)), by=year]

png('plot1.png')
barplot(height=eby$emissions, names.arg=eby$year, xlab="Year", ylab="Emissions", main="Total PM2.5 at various years")
dev.off()
