# Load the required libraries assuming they are available
library(plyr)
library(dplyr)

# Load the data from RDS files assuming they are present in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset and summarise the data for total emissions from PM2.5 in the US 
# from coal based combustion between 1999-2008
data_scc <- SCC[grep("Coal", SCC$EI.Sector),][,1]
data_nei_subset <- subset(NEI, SCC %in% data_scc)
data_final <- plyr::ddply(data_nei_subset, .(year), 
                    dplyr::summarise, emissions=sum(Emissions))

# Plot the data using base plotting system with png graphics device
png('plot4.png')
plot(data_final, type="l", 
     col="green",
     main="PM2.5 Emissions in the US from coal based combustion \nfrom 1999-2008")
dev.off()
