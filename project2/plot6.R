# Load the required libraries assuming they are available
library(ggplot2)
library(plyr)
library(dplyr)

# Load the data from RDS files assuming they are present in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset and summarise the data for total emissions from PM2.5 in the Baltimore 
# City and Los Angeles from motor vehicle between 1999-2008
data_scc <- SCC[grep("Mobile - On-Road", SCC$EI.Sector),][,1]
data_nei_subset <- subset(NEI, SCC %in% data_scc)
data_select <- plyr::ddply(subset(data_nei_subset, fips=="24510" | fips=="06037"), 
                           c("fips","year"), dplyr::summarise, emissions=sum(Emissions))
data_select$fips <- ordered(data_select$fips, levels = c("06037","24510"), 
                            labels = c("Los Angeles","Baltimore City"))

# Plot the data using ggplot2 plotting system with png graphics device
png('plot6.png', width = 600)
g <- ggplot(aes(x=year, y=emissions, color=fips), data=data_select) + 
                            geom_point() + geom_line()
g <- g + ggtitle("Comparison of PM2.5 Emissions in Baltomore City &\n Los Angeles from motor vehicle between 1999-2008")
print(g)
dev.off()
