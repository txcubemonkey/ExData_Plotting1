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
#  filter(DateTime >= as.Date("2006-02-01 00:00:00"), DateTime < as.Date("2006-02-03 00:00:00"))
# only 2007-02-01 and 2007-02-02

png(filename = "plot1.png", width = 480, height = 480)
hist(powerData$Global_active_power,xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

