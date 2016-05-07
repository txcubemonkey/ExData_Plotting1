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



daterange=c(as.POSIXlt(min(powerData$DateTime)),as.POSIXlt("2007-02-03 00:00:00"))   #figure out the lowest and highest months

png(filename = "plot2.png", width = 480, height = 480)
plot(powerData$DateTime,powerData$Global_active_power,pch=".",xlab="",ylab="Global Active Power (kilowatts)")          #don't plot the x axis
lines(powerData$DateTime,powerData$Global_active_power)   #lowess smooth with 30% window
dev.off()
