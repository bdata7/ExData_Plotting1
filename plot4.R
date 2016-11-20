# This script will generate 4 plots together as a .png file from Power Consumption data
# over 2007-02-01 and 2007-02-02

# Read in the data of interest 

require(data.table)
require(dplyr)
raw.data <- read.table('household_power_consumption.txt', sep = ";", na.strings = '?')

# Assign column names

names(raw.data) <- as.matrix(raw.data[1,])
raw.data <- raw.data[-1,]
raw.data[] <- lapply(raw.data, function(x) type.convert(as.character(x)))

# Extract dates of interest

raw.data <- tbl_df(raw.data)
filtered.data <- filter(raw.data, Date == '1/2/2007' | Date == '2/2/2007')

# Organize date/time data for plotting

filtered.data$dt <- with(filtered.data, as.POSIXct(paste(filtered.data$Date, filtered.data$Time), format = '%d/%m/%Y %H:%M:%S'))

# Plot the data

png('plot4.png', height = 480, width = 480)
par(mfrow = c(2,2))
plot(x = filtered.data$dt, y = filtered.data$Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatts)', type = 'l')
plot(x = filtered.data$dt, y = filtered.data$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
plot(x = filtered.data$dt, y = filtered.data$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
lines(filtered.data$dt, filtered.data$Sub_metering_2, col = 'orange')
lines(filtered.data$dt, filtered.data$Sub_metering_3, col = 'blue')
legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lwd = c(2.5,2.5), col=c('black','orange','blue'), bty = 'n')
plot(filtered.data$dt, filtered.data$Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')
dev.off()


