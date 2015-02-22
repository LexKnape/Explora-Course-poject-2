# This is the answer on Question #2 of Lesson 4 week 3

# File 1 NEI <- readRDS("summarySCC_PM25.rds")
# File 2 SCC <- readRDS("Source_Classification_Code.rds")

# Question 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.

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

# Aggregate the group "24510" indicating the U.S.county, Baltimore City, Maryland 
PM2.5.24510 <- NEI[NEI$fips=="24510", ]

# Aggregate the emission for the years for group 24510 and sum it (cleaned for missin values)
baltimore.24510 <-aggregate(Emissions ~ year, PM2.5.24510, sum, na.rm=TRUE)

# Create bitmapped format for graphic device in order to plot
png(filename="plot2.png", width=480, height=480)

# Plot aggregated data for Baltimore city from 1999-2008 to see if emission decreased
plot(baltimore.24510$Emissions, baltimore.24510$Year, type="l", xlab= "Year", 
     ylab = "PM2.5(tons)", main="PM2.5 Generated between years 1999-2008 in Baltimore City, MD")

# Close the png graphic device
dev.off()

# now you can view th file 'plot2.png' on your computer

# Answer question 2: Yes the total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008
