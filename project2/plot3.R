# Load the required libraries assuming they are available
library(ggplot2)
library(plyr)
library(dplyr)

# Load the data from RDS files assuming they are present in the working directory
NEI <- readRDS("summarySCC_PM25.rds")

# Subset and summarise the data for total emissions from PM2.5 in the Baltimore City 
# grouped by type from 1999-2008
data <- subset(NEI, fips == "24510") %>% 
  group_by(type, year) %>% 
  dplyr::summarise(emissions=sum(Emissions))
data_final <- as.data.frame(data)

# Plot the data using ggplot2 plotting system with png graphics device
png('plot3.png', width = 1000)
qplot(year, emissions, data=data_final, facets=.~type, geom=c("point","line"), 
      main="PM2.5 Emissions in Baltimore City per type from 1999-2008")
dev.off()
