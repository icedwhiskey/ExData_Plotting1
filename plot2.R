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


# Plot 2

## Plot time in weekdays against Global active power, name x (blank) and y-axis

plot(time_var, hpc[, 3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")


# Copy device

## Copy PNG device, set a width of 480 pixels and a height of 480 pixels

dev.copy(png,filename="plot2.png", width = 480, height = 480)


# Close device

## Close PNG device

dev.off()