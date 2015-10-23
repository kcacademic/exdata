# Load the required libraries assuming they are available
library(plyr)
library(dplyr)

# Load the data from RDS files assuming they are present in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset and summarise the data for total emissions from PM2.5 in the Baltimore City 
# from motor vehicle between 1999-2008
data_scc <- SCC[grep("Mobile - On-Road", SCC$EI.Sector),][,1]
data_nei_subset <- subset(NEI, SCC %in% data_scc)
data_final <- plyr::ddply(subset(data_nei_subset, fips == "24510"), .(year), 
                    dplyr::summarise, emissions=sum(Emissions))

# Plot the data using base plotting system with png graphics device
png('plot5.png')
plot(data_final, type="l", 
     col="green",
     main="PM2.5 Emissions in Baltomore City from motor vehicle \nfrom 1999-2008")
dev.off()
