# Create Global Active Power variation
plot4<- function() {
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
    par(mfrow = c(2,2), mar=c(4,4,2,1))
    plot(powerdata$Global_active_power~powerdata$DateTime,
         type="l", #Specify type of plot as l for line
         ylab="Global Active Power",
         xlab= "")
    plot(powerdata$Voltage~powerdata$DateTime,
         type="l", #Specify type of plot as l for line
         ylab="Voltage",
         xlab= "DateTime")
    plot(powerdata$Sub_metering_1~powerdata$DateTime,
         type="l", #Specify type of plot as l for line
         ylab="Energy sub metering",
         xlab= "")
   
    lines(powerdata$Sub_metering_2~powerdata$DateTime, col = "red")
    lines(powerdata$Sub_metering_3~powerdata$DateTime, col = "blue")
    legend("topright",
           legend=c("Sub_metering_1    ","Sub_metering_2    ","Sub_metering_3    "),
           col=c("black","red","blue"),
           lty=1,lwd=2, cex=0.5)
    plot(powerdata$Global_reactive_power~powerdata$DateTime,
         type="l", #Specify type of plot as l for line
         ylab="Global_reactive_power",
         xlab= "DateTime")
    #copry to png file
    dev.copy(png, "plot4.png", height=480, width=480)
    dev.off()
    
    par(mfrow = c(1,1))
}