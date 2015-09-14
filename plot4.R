data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

subData<-data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]

for (i in 1:2){subData[[i]]<-as.character(subData[[i]])}
for (i in 3:9){subData[[i]]<-as.numeric(as.character(subData[[i]]))}

subData$Date<-as.Date(subData$Date, format = "%d/%m/%Y")

subData$Time<-paste(subData$Date, subData$Time, sep = " ")

names(subData)[2]<-"DateTime"

subData$DateTime<-strptime(subData$DateTime, format = "%Y-%m-%d %H:%M:%S")

cleanData<-subData[,2:9]

png(file = "plot4.png", width = 480, height = 480)

#Open a window size as below
#x11(width=480, height=480) 

#Divide window into 4 sections
par(mfrow = c(2, 2))

#1st chart
with(cleanData, plot(DateTime,Global_active_power,xlab="",ylab = "Global Active Power", type="l"))

#2nd chart
with(cleanData, plot(DateTime,Voltage,xlab="datetime",ylab = "Voltage", type="l"))

#3rd chart
with(cleanData, plot(DateTime, Sub_metering_1, xlab="",ylab = "Energy sub metering",type = "l", col="black"))
with(cleanData, lines(DateTime, Sub_metering_2, type = "l", col="red"))
with(cleanData, lines(DateTime, Sub_metering_3, type = "l", col="blue"))
legend("topright",  col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, lty= 1, bty = "n")

#4th chart
with(cleanData, plot(DateTime,Global_reactive_power,xlab="datetime",ylab = "Global_reactive_power", type="l"))

dev.off()
