data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

subData<-data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]

for (i in 1:2){subData[[i]]<-as.character(subData[[i]])}
for (i in 3:9){subData[[i]]<-as.numeric(as.character(subData[[i]]))}

subData$Date<-as.Date(subData$Date, format = "%d/%m/%Y")

subData$Time<-paste(subData$Date, subData$Time, sep = " ")

names(subData)[2]<-"DateTime"

subData$DateTime<-strptime(subData$DateTime, format = "%Y-%m-%d %H:%M:%S")

cleanData<-subData[,2:9]

png(file = "plot2.png", width = 480, height = 480)
with(cleanData, plot(DateTime,Global_active_power,xlab="",ylab = "Global Active Power (kilowatts)", type="l"))
dev.off()
