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

## Plotting Global active power on different days
plot(data$Global_active_power ~ data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
	 
## Saving plot as png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
