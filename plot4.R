library(lubridate)
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                 na.strings = "?", colClasses = c('character','character',
                                                  'numeric','numeric','numeric',
                                                  'numeric','numeric','numeric','numeric'))

df$Date <- as.Date(df$Date, "%d/%m/%Y")

df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dateTime <- as.data.frame(paste(df$Date, df$Time, sep = " ", collapse = NULL))
colnames(dateTime) <- "dateTime"
dateTime$dateTime <- as.character(dateTime$dateTime)

dateTime$dateTime <- ymd_hms(dateTime$dateTime)
df <- cbind(dateTime, df)
df <- df[,c(1,4:10)]

par(mfrow=c(2,2))

# plot 1
plot(df$dateTime, df$Global_active_power, xlab = "", ylab = "Global Active Power", type = "line")

# plot 2
plot(df$dateTime, df$Voltage, xlab = "datetime", ylab = "Voltage", type = "line")

# plot 3
plot(df$dateTime, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "line")
lines(df$dateTime, df$Sub_metering_2, type = "line", col = "red")
lines(df$dateTime, df$Sub_metering_3, type = "line", col = "blue")
legend("topright", inset = 0.01, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, box.lty = 0)

# plot 4
plot(df$dateTime, df$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "line")

# create image file
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

