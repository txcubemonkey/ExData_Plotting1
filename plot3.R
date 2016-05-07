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

png(filename = "plot3.png", width = 480, height = 480)
plot(powerData$DateTime,powerData$Sub_metering_1,pch=".",xlab=" ",ylab="Energy sub metering")    
lines(powerData$DateTime,powerData$Sub_metering_1)   
lines(powerData$DateTime,powerData$Sub_metering_2, col="red") 
lines(powerData$DateTime,powerData$Sub_metering_3, col="blue")
legend("topright",lty=c(1,1,1), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lwd=c(1,1,1),
       cex = 0.7
       )
dev.off()

