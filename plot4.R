
# install sqldf if it is not installed
list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Load the sqldf package to load the data and filter it
library(sqldf);
mydata<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')",sep=";",colClasses =c("character", "character","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")) # Load the data using sqldf and filter the data 

#With the par( ) function, you can include the option mfrow=c(nrows, ncols) to create a matrix of nrows x ncols plots that are filled in by row. mfcol=c(nrows, ncols) fills in the matrix by columns.
par(mfrow=c(2,2))

# For 1st plot

y<-mydata$Global_active_power
# combine date and time columns
t<- paste(mydata$Date,mydata$Time, sep =" ")
# convert it into date time class
x<-strptime(t, "%d/%m/%Y %H:%M:%S")

# plotting symbol and color 
par(pch=22, col="black") 
#blank plot
plot(x, y, type="n", main=" ", ann=FALSE) 
#line plot
lines(x,y,type ="l")
# Label the x and y axes
title(xlab="")
title(ylab="Global Active Power")


# For 2nd plot
y<-mydata$Voltage
plot(x, y, type="n", main=" ", ann=FALSE) 
lines(x,y,type ="l")
title(xlab="datetime")
title(ylab="Voltage")


# For 3rd plot
Sub_metering_1<-mydata$Sub_metering_1
Sub_metering_2<-mydata$Sub_metering_2
Sub_metering_3<-mydata$Sub_metering_3

# Calculate range from 0 to max value of Sub_metering_1 ,Sub_metering_2 and Sub_metering_3
g_range <- range(0, Sub_metering_1, Sub_metering_2,Sub_metering_3)

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
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), cex=0.4, lwd = 1);

# For 4th plot
y<-mydata$Global_reactive_power
plot(x, y, type="n", main=" ", ann=FALSE) 
lines(x,y,type ="l")
title(xlab="datetime")
title(ylab="Global_reactive_power")


dev.copy(png, file = "plot4.png",width = 480, height = 480, units = "px", bg = "white")
dev.off()  ## Don't forget to close the PNG device!