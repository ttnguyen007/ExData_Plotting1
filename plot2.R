library(data.table)
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","project.zip")
unzip("project.zip")
data <- fread("household_power_consumption.txt")
data <- mutate(data,Date=as.Date(Date, "%d/%m/%Y"))
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-03")
data <- filter(data, Date>=date1&Date<date2)
data <- mutate(data, DateTime=paste(Date,Time), Global_active_power=as.numeric(Global_active_power))
data <- mutate(data, Global_reactive_power=as.numeric(Global_reactive_power), Voltage=as.numeric(Voltage))
data <- mutate(data, Sub_metering_1=as.numeric(Sub_metering_1), Sub_metering_2=as.numeric(Sub_metering_2), Sub_metering_3=as.numeric(Sub_metering_3))


datedata <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")

#plot2
plot(datedata, data$Global_active_power, col="white",ylab = "Global Active Power (kilowatts)", xlab="")
lines(datedata[order(datedata)], data$Global_active_power[order(datedata)], xlim=range(datedata), ylim=range(data$Global_active_power), pch=16)
dev.copy(png, file = "plot2.png")
dev.off()