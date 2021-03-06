## Getting dataset file
file <- 'household_power_consumption.txt'
if(!file.exists("exdata_data_household_power_consumption.zip")) {
	temp <- tempfile()
	download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
	file <- unzip(temp)
	unlink(temp)
}

## Loading complete data
comp_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")
comp_data$Date <- as.Date(comp_data$Date, format="%d/%m/%Y")

## Subsetting the data based on date
data <- subset(comp_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove full data to save memory
rm(comp_data)

## Creating a new column based on both date-time
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Prepare the plot providing row/column, margins
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Plotting all 4 plots arranged in row/column space
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global_rective_power",xlab="datetime")
})

## Saving plot as png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()