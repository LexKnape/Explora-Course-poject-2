# This is the answer on Question #4 of Lesson 4 week 3

# File 1 NEI <- readRDS("summarySCC_PM25.rds")
# File 2 SCC <- readRDS("Source_Classification_Code.rds")

# Question 4: Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

# Get info about the current workdir
getwd()

# Set Work dir
setwd("/Users/anknape/GitHub/Les4wk3")

# The data for this assignment are available from the course web site as a single zip file:
# Data for Peer Assessment [29Mb] download file to work dir
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# Load library ggplot2
library(ggplot2)

# Set variable NEI with data from downloaded RDS file
NEI <- readRDS("summarySCC_PM25.rds")

# Set variable SCC with data from donloaded RDS file
SCC <- readRDS("Source_Classification_Code.rds")

# Merge the SCC into NEI in order to select the coal related emissions
# Next time I first select the required columns from SCC as it takes a while
SCC_in_NEI <- merge(NEI, SCC, by="SCC")

# Create a subset of the Coal related emission from SCC_in_NEI
CoalEmission <- subset(SCC_in_NEI, grepl
                       ("Coal", SCC_in_NEI$Short.Name, fixed=T), 
                       c("Emissions", "year", "type", "Short.Name"))

# The coal related emission is now aggregated by year 
CoalEmission_by_year <- aggregate(Emissions ~ year, CoalEmission, sum) 

# # Create bitmapped format for graphic device in order to plot
png(filename="plot4.png", width=480, height=480)

# Plot the data with the emissions from coal combustion-related sources.
ggplot(data=CoalEmission_by_year, aes(x=year, y=Emissions ))+
        geom_line() +
        geom_point(size=4, shape=16, color="red") +
        xlab("year") +
        ylab("Total PM2.5 Emissions (tons)") +
        ggtitle("Emission change from coal combustion-related sources (1999-2008)")

# Close the png graphic device
dev.off()

# now you can view th file 'plot4.png' on your computer

# Across the United States, emissions from coal combustion-related sources  have 
# decreased from 1999–2008?
