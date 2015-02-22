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
# Merge two tables, and remove all records except coal-based combustion
# To keep only "coal-based combusion" types, the data is filtered on
# the column EI.Sector based on the pattern "Comb.*Coal", this returns 3 distinct types:
#     [1] Fuel Comb - Electric Generation - Coal     
#     [2] Fuel Comb - Industrial Boilers, ICEs - Coal
#     [3] Fuel Comb - Comm/Institutional - Coal    
    setkeyv(summaryData,"SCC")
    setkeyv(codesData,"SCC")
    summaryData <- merge(summaryData, codesData)
    coalBased <- summaryData[grep("Comb.*Coal", summaryData$EI.Sector, perl=TRUE), ]
    plotData <- aggregate(Emissions ~ year, data = coalBased, FUN = "sum")
# Build the plot
    png("plot4.png")
    plot(plotData$year, plotData$Emissions, type = "b", col = "blue", lwd = 2, xlab = "Year", ylab="Emissions", main = "Total Coal Combustion-based PM25 emissions in the U.S. over time")
    dev.off()
