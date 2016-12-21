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

## format data/time
dates <- power_feb$date
times <- power_feb$time
date_time <- paste(dates, times)
date_time <- strptime(date_time, "%Y-%m-%d %H:%M:%S")
power_feb <- cbind(date_time , power_feb)
power_feb$date <- NULL
power_feb$time <- NULL

##Create line chart for Plot 2
par(mfrow = c(1,1))
plot(power_feb$date_time , power_feb$global_active_power_kw, type = "n" , xlab = "", ylab = "Global Active Power (kilowatts)")
lines(power_feb$date_time , power_feb$global_active_power_kw, xlab = "", ylab = "Global Active Power (kilowatts)")

## copy Plot 2 to PNG file
dev.copy(png, file = "plot2.png") 
dev.off()
