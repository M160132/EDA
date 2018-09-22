library(ggplot2)
library(lubridate)
library(dplyr)

raw = read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
colnames(raw) = raw[1,]
cleaned = raw[-1,]

#Above: read the data, change the column header to the descriptive header and remove the first row

subset1 = subset(cleaned, cleaned$Date == "1/2/2007")
subset2 = subset(cleaned, cleaned$Date == "2/2/2007")
filtered = rbind(subset1,subset2)

filtered$Sub_metering_1 = as.numeric(filtered$Sub_metering_1)
filtered$Sub_metering_2 = as.numeric(filtered$Sub_metering_2)
filtered$Sub_metering_3 = as.numeric(filtered$Sub_metering_3)

with(filtered, plot(Sub_metering_1, type="n",xlab = "Number of Minutes from the first Minute of Thursday", ylab = "Energy sub metering"), 
     plot(Sub_metering_2, type="n"), plot(Sub_metering_3, type="n"))
with(filtered, lines(Sub_metering_1))
with(filtered, lines(Sub_metering_2, col="red"))
with(filtered, lines(Sub_metering_3, col="blue"))

legend("topright", col =c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)

dev.copy(png, "plot3.png")
dev.off()