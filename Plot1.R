## set directory, library lubridate
setwd("~/Exploratory-Data-Analysis")
library("lubridate")

## Download data and read into R
powerurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(powerurl, temp, mode="wb")
unzip(temp, "household_power_consumption.txt")
power <- (read.table("./household_power_consumption.txt", sep = ";" , na.strings = "?" , colClasses = "character"))

## Format data
power$V1 <- as.Date(power$V1, format="%d/%m/%Y")
power_feb <- subset(power, V1 == "2007-02-01" | V1 == "2007-02-02")
names(power_feb) <- c("date" , "time" , "global_active_power_kw", "global_reactive_power_kw", "voltage" , "global_intensity_amps" , "sub_metering_kitchen_wh" , "sub_metering_laundry_wh" , "sub-metering_utilities-wh")
power_feb[, 3:9] <- sapply(power_feb[, 3:9], as.numeric)
power_feb <- na.omit(power_feb)

##Create histogram for Plot 1
par(mfrow = c(1,1))
hist(power_feb$global_active_power_kw, col = "red" , ylab = "Frequency", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## copy Plot 1 to PNG file
dev.copy(png, file = "plot1.png") 
dev.off()
