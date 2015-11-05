
##  This script will creat plot Graph 1 for Exploratory Data Analysis, project 1.

library(dplyr)

library(data.table)

## Download file.

fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "EPC.zip")

## Unzip and read data into a data.table.

unzip("EPC.zip")  

EPC_data <- fread(
      "household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
      colClasses = c("character", "character", rep("numeric", 7))
)

##  Create a new column with combined Date and Time information.  

EPC_data2 <- mutate(EPC_data, Date_Time = paste(Date, Time))

##  Convert Date_Time from character to POSIXct.  Note this step is SLOW (1-2 minutes).

EPC_data2$Date_Time <- as.POSIXct(strptime(EPC_data2$Date_Time, "%d/%m/%Y %H:%M:%S"))

##  Then filter dateset by date. 

EPC_data2 <-EPC_data2 %>%
      filter(Date_Time >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S")) %>%
      filter(Date_Time < strptime("03/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))

## Create Graph 1

hist(EPC_data2$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

## Save Graph 1 as a png file.

dev.copy(png, "Plot1.png", width = 480, height = 480)
dev.off()