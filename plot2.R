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

filtered$Global_active_power = as.numeric(filtered$Global_active_power)
filtered$Date <- as.Date(filtered$Date,"%d/%m/%Y")
filtered <-mutate(filtered, DateNtime = as.POSIXct(paste(filtered$Date, filtered$Time)))

plot(filtered$Global_active_power ~ filtered$DateNtime, type = "l", xlab="",
     ylab = "Global Active Power (Kilowatts)")

dev.copy(png, "plot2.png")
dev.off()