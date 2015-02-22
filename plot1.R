## This is the R script to generate the first plot.
# To save the space on GitHub, the original files are not included here,
# though the commands for reading the files are provided. The files can be downloaded and unzipped from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Read the input files
codesFile <- "Source_Classification_Code.rds"
summaryFile <- "summarySCC_PM25.rds"
codesData <- readRDS (codesFile)
summaryData <- readRDS(summaryFile)

# We don't need to subset the data any further for this plot, since it only contains
# the years 1999,2002,2005,2008. This can be validated by calling unique(summaryData$year)
plotData <- aggregate(Emissions ~ year, data = summaryData, FUN = "sum")
# Build the plot
png("plot1.png")
plot(plotData$year, plotData$Emissions, type = "b", col = "blue", lwd = 2, xlab = "Year", ylab="Emissions", main = "Total PM25 emissions in the U.S. over time")
dev.off()
