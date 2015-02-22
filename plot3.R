## This is the R script to generate the plot.
# To save the space on GitHub, the original files are not included here,
# though the commands for reading the files are provided. The files can be downloaded and unzipped from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Read the input files
codesFile <- "Source_Classification_Code.rds"
summaryFile <- "summarySCC_PM25.rds"
codesData <- readRDS (codesFile)
summaryData <- readRDS(summaryFile)
# Subset the data for Baltimore (fips = 24510), and calculate the totals
fipsB <- subset(summaryData, fips == 24510)
plotData <- aggregate(Emissions ~ year * type, data = fipsB, FUN = "sum")
# Build the plot
library(ggplot2)
png("plot3.png")
qplot(year, Emissions, data = plotData , geom = c("point", "line"), facets = type ~ .)
dev.off()
