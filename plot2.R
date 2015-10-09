plot2 <- function() {
  #Load the sqldf package to selectively load the data
  library(sqldf)
  
  #Read the data assuming the datafile is located in the present working directory in unzipped form
  data <- read.csv.sql("household_power_consumption.txt", sql="select * from file where Date='1/2/2007' OR Date='2/2/2007'", header=TRUE, sep=";")
  
	#Change the class of date and time columns from factor to Date and Posixt
	data$Time <- paste(data$Date, data$Time)
	data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")
	data$Date <- as.Date(data$Date, "%d/%m/%Y")

	#Open the graphics device and plot the required data
	png('plot2.png')
	with(set, plot(set$Time, set$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
	dev.off()
}