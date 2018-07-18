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

par(mfrow=c(1,1))

plot(df$dateTime, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "line")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
