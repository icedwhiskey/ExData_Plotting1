# Preparatory stage

## Download and read data

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

library(archive)

## Check if data downloaded if not download and unzip with archive package

if (!file.exists("household_power_consumption.txt")) { 
  archive_extract(fileurl, dir = "./") 
}

## Check if data read if not read table and subset only for 1/2/2007 and 2/2/2007
## convert Date variables into date classe, create new time variable

if (!exists("hpc")) {
  hpc <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
  hpc <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007", ] 
  hpc[, 1] <- as.Date(hpc[, 1], format = "%d/%m/%Y")
  time_var <- as.POSIXct(paste(hpc[, 1], hpc[, 2]))
}


# Plot 4

## Set parameter for 2x2 configuration of plots

par(mfrow = c(2,2), mar = c(2,2,2,2))

## Plot time in weekdays against Global active power, name x (blank) and y-axis

plot(time_var, hpc[, 3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

## Plot time against Voltage, name x and y-axis

plot(time_var, hpc$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

## Plot time against sub metering, name x (blank) and y-axis
## scale legend, remove legend box

plot(time_var, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(time_var, hpc$Sub_metering_1, col = "black")
lines(time_var, hpc$Sub_metering_2, col = "red")
lines(time_var, hpc$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col = c("black","red","blue"), 
       bty = "n", lty = 1, cex = 0.7)

## Plot time against global reactive power, name x and y-axis

plot(time_var, hpc$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")


# Copy device

## Copy PNG device, set a width of 480 pixels and a height of 480 pixels

dev.copy(png,filename="plot4.png", width = 480, height = 480)


# Close device

## Close PNG device

dev.off()