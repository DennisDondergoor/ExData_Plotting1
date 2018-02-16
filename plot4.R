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

# Make plot4.png

# Open the graphics device
png(file = "plot4.png",
    width = 480,
    height = 480)

# Set up the canvas
par(mfrow = c(2, 2))

# Create the 4 plots
with(power, {
    plot(
        Global_active_power ~ DateTime,
        type = "l",
        xlab = "",
        ylab = "Global Active Power"
    )
    plot(Voltage ~ DateTime,
         type = "l",
         xlab = "datetime",
         ylab = "Voltage")
    plot(
        Sub_metering_1 ~ DateTime,
        type = "n",
        xlab = "",
        ylab = "Energy sub metering"
    )
    lines(Sub_metering_1 ~ DateTime, col = "black")
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
    legend(
        "topright",
        col = c("black", "red", "blue"),
        lty = 1,
        box.lwd = 1,
        bty = "n",
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    )
    plot(Global_reactive_power ~ DateTime,
         type = "l",
         xlab = "datetime")
})

# Close the graphics device
dev.off()
