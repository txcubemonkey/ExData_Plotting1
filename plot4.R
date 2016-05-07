library(dplyr)
Fulldata <- read.table("c:/rdata/ExploratoryGraphs/data/household_power_consumption.txt",
                       header=TRUE,sep=";",stringsAsFactors = FALSE
)
powerData <- Fulldata %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(DayOfWeek = as.factor(weekdays(as.Date(Date, format = "%d/%m/%Y")))) %>%
  mutate(DateTime = as.POSIXct(paste(Date,Time), format = "%d/%m/%Y%H:%M:%S")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power))

daterange=c(as.POSIXlt(min(powerData$DateTime)),as.POSIXlt("2007-02-03 00:00:00"))  

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2)) # make 2x2 grid

#write plot 2 in top left
plot(powerData$DateTime,powerData$Global_active_power,pch=".",xlab="",ylab="Global Active Power (kilowatts)")          #don't plot the x axis
lines(powerData$DateTime,powerData$Global_active_power)   #lowess smooth with 30% window


#write plot 3 in bottom left
plot(powerData$DateTime,powerData$Sub_metering_1,pch=".",xlab=" ",ylab="Energy sub metering")    
lines(powerData$DateTime,powerData$Sub_metering_1)   
lines(powerData$DateTime,powerData$Sub_metering_2, col="red") 
lines(powerData$DateTime,powerData$Sub_metering_3, col="blue")
legend("topright",lty=c(1,1,1), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

#write top right
plot(powerData$DateTime,powerData$Voltage,pch=".",xlab="datetime",ylab="Voltage")      
lines(powerData$DateTime,powerData$Voltage)   #lowess smooth with 30% window


#write bottom right
plot(powerData$DateTime,powerData$Global_reactive_power,pch=".",xlab="datetime",ylab="Global_Reactive_Power")          #don't plot the x axis
lines(powerData$DateTime,powerData$Global_reactive_power)   

dev.off()

