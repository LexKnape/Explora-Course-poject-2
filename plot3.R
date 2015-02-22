# This is the answer on Question #3 of Lesson 4 week 3

# File 1 NEI <- readRDS("summarySCC_PM25.rds")
# File 2 SCC <- readRDS("Source_Classification_Code.rds")

# Question 3. Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999???2008 for Baltimore City? Which have seen increases in emissions 
# from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# Get info about the current workdir
getwd()

# Set Work dir
setwd("/Users/anknape/GitHub/Les4wk3")

# The data for this assignment are available from the course web site as a single zip file:
# Data for Peer Assessment [29Mb] download file to work dir
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Load library plyr
library(plyr)

# Load library ggplot2
library(ggplot2)

# Set variable NEI with data from downloaded RDS file
NEI <- readRDS("summarySCC_PM25.rds")

# Set variable SCC with data from donloaded RDS file
SCC <- readRDS("Source_Classification_Code.rds")

# Emission for fips 24510 (Baltimore) per source and getting rid of the missing values
Balt_PM2.5_24510 <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), 
                          function(df)sum(df$Emissions, na.rm=TRUE))

# Set new names for the columns to give them more sense.  
names(Balt_PM2.5_24510) <- c('Year', 'Type', 'Emission')

# Check if names are changed
head(Balt_PM2.5_24510)

# Create bitmapped format for graphic device in order to plot
png(filename="plot3.png", width=480, height=480)

# Plot the 4 sources of emissions
ggplot(data=Balt_PM2.5_24510, aes(x=Year, y=Emission, group=Type, color=Type)) +
        geom_line() +
        geom_point(size=4, shape=16, color="steelblue") +
        xlab("Year") +
        ylab("PM2.5 (value in tons)") +
        ggtitle("PM2.5 Emission (tons) Per Yr.by Type((point, nonpoint, 
                onroad, nonroad)")

# Close the png graphic device
dev.off()

# now you can view th file 'plot3.png' on your computer

# Of the four sources non-road, non point and on-road showed a decrease in emissions 
# from 1999 till 2008 while point showed an increase in emission. 
