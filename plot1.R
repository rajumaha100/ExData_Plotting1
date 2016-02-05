# install sqldf if it is not installed
list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

 
library(sqldf);# Load the sqldf package to load the data and filter it
mydata<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",sep=";",colClasses =c("character", "character","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")) # Load the data using sqldf and filter the data 
#hist(mydata$Global_active_power, col = "red") #create the histogram
png(file = "plot1.png",width = 480, height = 480, units = "px", bg = "white")
hist(mydata$Global_active_power, col = "red", main ="Global Active Power",xlab ="Global Active Power (kilowatts)") #create the histogram with title and X axis name
dev.off()  ## Don't forget to close the PNG device!