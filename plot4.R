## read R datasets
if (!exists("NEI")) {
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

library('data.table')
library('ggplot2')

## filter records which contains 'coal' in Short.Name
coals <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coalSCC <- SCC[coals,]
## NOTE: 'merge' after 'filter' on purpose for better performance 
##        (it's like predicate pushdown before join in relational database)
##        if 'filter' were done after 'merge', it would take much longer time
merged <- merge(NEI, coalSCC, by="SCC")

dt <- data.table(merged)
eby <- dt[, list(emissions=sum(Emissions)), by=c('year')]

png('plot4.png', width=480, height=480)
g <- ggplot(data=eby, aes(x=year, y=emissions))
g <- g + geom_line() + geom_point() + xlab("Year") + ylab("Emissions") + ggtitle("Total emissions from coal sources")
print(g)
dev.off()
