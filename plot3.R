# Create Global Active Power variation
plot3<- function() {
    # Read Power consumption data for 2/1/2007 and 2/2/2007 
    powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                            skip = 66636, nrows=2881, 
                            colClasses = c("character", "character", "numeric", 
                                           "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric")) 
    #Read header
    headers <- read.table("household_power_consumption.txt",  header = TRUE, sep = ";", nrows=2)
    colnames(powerdata)<-colnames(headers)
    
    # combine date and time to Datetime format
    powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time), format="%d/%m/%Y %H:%M:%S")
    
    
    #Plot 
    plot(powerdata$Sub_metering_1~powerdata$DateTime,
         type="l", #Specify type of plot as l for line
         ylab="Energy sub metering",
         xlab= "")
    lines(powerdata$Sub_metering_2~powerdata$DateTime, col = "red")
    lines(powerdata$Sub_metering_3~powerdata$DateTime, col = "blue")
    legend("topright",
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col=c("black","red","blue"),
           lty=1,lwd=2)
    #copry to png file
    dev.copy(png, "plot3.png", height=480, width=480)
    dev.off()
}