library(lubridate)

# Import the “Individual household electric power consumption” data set
url <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power.zip")
unzip("power.zip")
power_large <- read.table(
    "household_power_consumption.txt",
    sep = ";",
    header = TRUE,
    na.strings = "?"
)

# Keep only dates February 1-2, 2007
power <-
    subset(power_large, Date %in% c("1/2/2007", "2/2/2007"))

# Create DateTime variable
power$DateTime <- paste(power$Date, power$Time)
power$DateTime <- dmy_hms(power$DateTime)

# Make plot2.png

# Open the graphics device
png(file = "plot2.png",
    width = 480,
    height = 480)

# Create the plot
plot(
    Global_active_power ~ DateTime,
    data = power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)

# Close the graphics device
dev.off()
