# Load the required libraries assuming they are available
library(plyr)
library(dplyr)

# Load the data from RDS files assuming they are present in the working directory
NEI <- readRDS("summarySCC_PM25.rds")

# Subset and summarise the data for total emissions from PM2.5 in the US 
# from 1999-2008
data <- plyr::ddply(NEI, .(year), 
                    dplyr::summarise, emissions=sum(Emissions)) 

# Plot the data using base plotting system with png graphics device
png('plot1.png')
plot(data, type="l",
     col="green",
     main = "PM2.5 Emissions in the US from 1999-2008")
dev.off()
