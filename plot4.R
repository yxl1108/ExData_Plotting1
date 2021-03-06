# assignment 1, plot 4

## make sure the folder exists
if (!file.exists("R_data")) { dir.create("R_data") }
## download the zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = ".\\R_data\\powerconsumption.zip", mode="wb")
## unzip the file
unzip(".\\R_data\\powerconsumption.zip", exdir = ".\\R_data")

## read the txt file into data frame, only the data needed
hps <- subset(read.table(".\\R_data\\household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE), Date == '1/2/2007' | Date == '2/2/2007')

# create a POXIS date
hps$DateTime<-strptime(paste(hps$Date, hps$Time), "%d/%m/%Y %T")

# data clean up, convert to numeric 
hpsclean <- transform(hps, Voltage = as.numeric(Voltage), Global_reactive_power=as.numeric(Global_reactive_power), Global_active_power = as.numeric(Global_active_power), Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))
                 
# plot 4
library(datasets)
png(file=".\\R_data\\plot4.png",width=480,height=480)
par(mfrow = c(2, 2))
with(hpsclean, {
    plot(DateTime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power")
    plot(DateTime, Voltage, type="l", main="", xlab="datetime", ylab="Voltage")
	plot(DateTime, Sub_metering_1, type="l", main="", xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", bty="n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	plot(DateTime, Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()

