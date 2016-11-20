# This is a histogram of Frequency vs Global Active Power (kilowatts)
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

# Create the histogram of interest

filtered.data$Global_active_power <- as.numeric(filtered.data$Global_active_power)

png('plot1.png', height = 480, width = 480)
hist(filtered.data$Global_active_power, xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'orange')
dev.off()


