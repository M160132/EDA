library(ggplot2)
library(lubridate)
library(dplyr)

raw = read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
colnames(raw) = raw[1,]
cleaned = raw[-1,]

#Above: read the data, change the column header to the descriptive header and remove the first row
par(mfrow = c(1,1))
subset1 = subset(cleaned, cleaned$Date == "1/2/2007")
subset2 = subset(cleaned, cleaned$Date == "2/2/2007")
filtered = rbind(subset1,subset2)

filtered$Sub_metering_1 = as.numeric(filtered$Sub_metering_1)
filtered$Sub_metering_2 = as.numeric(filtered$Sub_metering_2)
filtered$Sub_metering_3 = as.numeric(filtered$Sub_metering_3)

filtered$Date <- as.Date(filtered$Date,"%d/%m/%Y")
filtered <-mutate(filtered, DateNtime = as.POSIXct(paste(filtered$Date, filtered$Time)))

with(filtered, plot(Sub_metering_1 ~ DateNtime, type="n",xlab = "", ylab = "Energy sub metering"), 
     plot(Sub_metering_2 ~ DateNtime, type="n"), plot(Sub_metering_3 ~ DateNtime, type="n"))
with(filtered, lines(Sub_metering_1 ~ DateNtime))
with(filtered, lines(Sub_metering_2 ~ DateNtime, col="red"))
with(filtered, lines(Sub_metering_3 ~ DateNtime, col="blue"))

legend("topright", col =c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)

dev.copy(png, "plot3.png")
dev.off()