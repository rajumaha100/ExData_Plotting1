
# install sqldf if it is not installed
list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Load the sqldf package to load the data and filter it
library(sqldf);
mydata<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",sep=";",colClasses =c("character", "character","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")) # Load the data using sqldf and filter the data 

#the lines( ) function adds information to a graph. It can not produce a graph on its own. Usually it follows a plot(x, y) command that produces a graph.
#By default, plot( ) plots the (x,y) points. Use the type="n" option in the plot( ) command, to create the graph with axes, titles, etc., but without plotting the points.

Sub_metering_1<-mydata$Sub_metering_1
Sub_metering_2<-mydata$Sub_metering_2
Sub_metering_3<-mydata$Sub_metering_3

# combine date and time columns
t<- paste(mydata$Date,mydata$Time, sep =" ")
# convert it into date time class
x<-strptime(t, "%d/%m/%Y %H:%M:%S")

# Calculate range from 0 to max value of Sub_metering_1 ,Sub_metering_2 and Sub_metering_3
g_range <- range(0, Sub_metering_1, Sub_metering_2,Sub_metering_3)


png(file = "plot3.png",width = 480, height = 480, units = "px", bg = "white") 

# plotting symbol and color 
par(pch=22, col="black") 

#blank plot
plot(x, Sub_metering_1, type="n", main=" ", ann=FALSE) 

#line plot for Sub_metering_1
lines(x,Sub_metering_1,type ="l")

#line plot for Sub_metering_2
lines(x,Sub_metering_2,type ="l",col="red")

#line plot for Sub_metering_3
lines(x,Sub_metering_3,type ="l",col="blue")

# Label the x and y axes
title(xlab="")
title(ylab="Energy sub metering")

# Create a legend 
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), cex=0.8, lwd = 1);

dev.off()  ## Don't forget to close the PNG device!