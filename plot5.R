## This is the R script to generate the plot.
# To save the space on GitHub, the original files are not included here,
# though the commands for reading the files are provided. The files can be downloaded and unzipped from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Read the input files
library(data.table)
codesFile <- "Source_Classification_Code.rds"
codesData <- readRDS (codesFile)    
codesData <- as.data.table(codesData)
summaryFile <- "summarySCC_PM25.rds"
summaryData <- readRDS(summaryFile)    
summaryData <- as.data.table(summaryData)
# Merge two tables, and remove all records except the ones related to motor vehicles (in Baltimore).
# To keep only the motor vehicle-related PM25 sources, the data is filtered on
# the column EI.Sector based on the pattern "Vehicle", this returns 4 distinct types:
# [1] Mobile - On-Road Gasoline Light Duty Vehicles
# [2] Mobile - On-Road Gasoline Heavy Duty Vehicles
# [3] Mobile - On-Road Diesel Light Duty Vehicles
# [4] Mobile - On-Road Diesel Heavy Duty Vehicles
    setkeyv(summaryData,"SCC")
    setkeyv(codesData,"SCC")
    summaryData <- merge(summaryData, codesData)
    fipsB <- subset(summaryData, fips == 24510)
    motorV <- fipsB[grep("Vehicle", fipsB$EI.Sector, perl=TRUE), ]
    plotData <- aggregate(Emissions ~ year, data = motorV, FUN = "sum")
# Build the plot
png("plot5.png")
plot(plotData$year, plotData$Emissions, type = "b", col = "blue", lwd = 2, xlab = "Year", ylab="Emissions", main = "Total PM25 emissions from Motor Vehicles in Baltimore")
dev.off()
