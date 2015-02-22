# This is the answer on Question #5 of Lesson 4 week 3

# File 1 NEI <- readRDS("summarySCC_PM25.rds")
# File 2 SCC <- readRDS("Source_Classification_Code.rds")

# Question 6: Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Get info about the current workdir
getwd()

# Set Work dir
setwd("/Users/anknape/GitHub/Les4wk3")

# The data for this assignment are available from the course web site as a single zip file:
# Data for Peer Assessment [29Mb] download file to work dir
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Load library ggplot2
library(ggplot2)

# Load library reshape2
library(reshape2)

# Set variable NEI with data from downloaded RDS file
NEI <- readRDS("summarySCC_PM25.rds")

# Set variable SCC with data from donloaded RDS file
SCC <- readRDS("Source_Classification_Code.rds")

# Create a subset for fips 24510 and 06037 for type "ON-ROAD"
Two_Cities_OnR <- subset(NEI, (fips == "24510" | fips == "06037") & 
                                        type=="ON-ROAD", 
                                c("fips", "SCC", "Pollutant", "Emissions", "type", "year"))

# Change column names for clarity
names(Two_Cities_OnR) <- c("City", "SCC", "Pollutant", "Emissions", "Type", "Year")

# Check if column names changed
str(Two_Cities_OnR)

# Change 24510 in Baltimore City and 06037 in Los Angeles County
Two_Cities_OnR$City <- factor(Two_Cities_OnR$City, levels=c("24510", "06037"), 
                        labels=c("Baltimore City", "Los Angeles County"))

# check if fips is changed into City names
head(Two_Cities_OnR$City)

# Select the columns Year and City with a variable Emissions with its respective value
Two_Cities_OnR_M <- melt(Two_Cities_OnR, id = c("Year", "City"), measure.vars=c("Emissions"))

# Sum the value of Emission for the value of the same year for the two separate cities
Two_Cities_OnR_Sum <- dcast(Two_Cities_OnR_M, City + Year ~ variable, sum)

# Create a new column named Difference showing the claculated difference between "opvolgende years
Two_Cities_OnR_Sum[2:8, "Difference"] <-diff(Two_Cities_OnR_Sum$Emissions)

# Set the interval between the opvolgnde jaren such showing the difference for  eah measurement
Two_Cities_OnR_Sum[c(1,5), 4] <- 0

#Open graphics device
png(filename="plot6.png", width=480, height=480)

# Plotting The growth on 2 cities with ggplot
ggplot(data=Two_Cities_OnR_Sum, aes(Year, Difference, by=City, color=City)) + 
        geom_line() +
        geom_point(size=4, shape=16, color="red") +
        xlab ("Year") +
        ylab(" Change in Emissions (tons)") +
        ggtitle ("        Emission comparison Baltimore/LA from motor vehicle sources")

# Close the png graphic device
dev.off()

# now you can view th file 'plot6.png' on your computer

# Answer question 6: Los Angeles has seen greater changes over time 
# in motor vehicle emissions
# Search on Google resulted in possible reasons for teh reduction Les Angeles
# http://www.arb.ca.gov/html/brochure/history.htm, site of The Californian envirnmental
# agency showed the following changes with could effect the above mentioned result
# -1 In 2004 ARB adopted Heavy Duty Diesel Trucks idling controls. The regulation required Heavy 
# Duty Diesel Trucks and interstate bus operators to shut their engines down after five 
# minutes of non-essential idling. The regulation affected more than 400,000 trucks and 
# buses registered in CA and all out-of-state trucks and buses operating in CA.
# -2 In 2004 ARB adopted new diesel fuel standards. The rule required greater than 95% 
# reduction in the amount of sulfur in diesel fuel.
