plot4 <- function() {
  #Load the sqldf package to selectively load the data
  library(sqldf)
  
  #Read the data assuming the datafile is located in the present working directory in unzipped form
  data <- read.csv.sql("household_power_consumption.txt", sql="select * from file where Date='1/2/2007' OR Date='2/2/2007'", header=TRUE, sep=";")
  
  #Change the class of date and time columns from factor to Date and Posixt
  data$Time <- paste(data$Date, data$Time)
  data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")

	#Open the graphics device and plot the required data
	png('plot4.png')
	par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(0,0,0,0))
	with(set, {
	  plot(set$Time, set$Global_active_power, type="l", xlab="", ylab="Global Active Power")
	  plot(set$Time, set$Voltage, type="l", xlab="datetime", ylab="Voltage")
	  plot(set$Time, set$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	  points(set$Time, set$Sub_metering_2, type="l", col="red")
	  points(set$Time, set$Sub_metering_3, type="l", col="blue")
	  legend("topright", lty=1, cex=0.8, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	  plot(set$Time, set$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
	})
	dev.off()
}