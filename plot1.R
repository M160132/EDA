library(ggplot2)
library(lubridate)
library(dplyr)

raw = read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
colnames(raw) = raw[1,]
cleaned = raw[-1,]
subset1 = subset(cleaned, cleaned$Date == "1/2/2007")
subset2 = subset(cleaned, cleaned$Date == "2/2/2007")
#Above: read the data, change the column header to the descriptive header and remove the first row

filtered = rbind(subset1,subset2)
filtered$Global_active_power = as.numeric(filtered$Global_active_power)

hist(filtered$Global_active_power, breaks = 24, main = "Global Active Power", 
     xlab="Global Active Power (Kilowatts)",ylab="Frequency", col = "red", xlim = c(0,6))

dev.copy(png, "plot1.png")
dev.off()