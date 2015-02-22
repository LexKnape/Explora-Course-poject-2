# This is the answer on Question #1 of Lesson 4 week 3

# File 1 NEI <- readRDS("summarySCC_PM25.rds")
# File 2 SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using 
# the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# Get info about the current workdir
getwd()

# Set Work dir
setwd("/Users/anknape/GitHub/Les4wk3")

# The data for this assignment are available from the course web site as a single zip file:
# Data for Peer Assessment [29Mb] download file to work dir
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Set variable NEI with data from downloaded RDS file
NEI <- readRDS("summarySCC_PM25.rds")

# Set variable SCC with data from donloaded RDS file
SCC <- readRDS("Source_Classification_Code.rds")

# The emissiongroup is totalled by years and cleaned from missing values
Emissiongroup <- with (NEI,aggregate(NEI[,'Emissions'], by=list(year), sum, na.rm=TRUE))

# Create bitmapped format for graphic device in order to plot
png(filename='plot1.png', width=480, height=480, units='px')

# Plot the aggregated data of total emissions from PM2.5 for all the years
plot(Emissiongroup, type="l", xlab="Year", ylab="Total PM2.5 Emmision From All Sources Between 1999-(2008)", xaxt="n", main="Total Emissions (tons)")

# Close the png graphic device
dev.off()

# now you can view th file 'plot1.png' on your computer

# Answer on question 1: Yes the total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008.
