# Set directory
setwd("f:/R/Rep_data/RepData_assign2/")
# Read in the data set with header 
dt0 <- read.table("repdata_data_StormData.csv",sep=",",comment.char = "#",header=T,na.strings = "")

cnames <- readLines("repdata_data_StormData.csv",1)

# Check out how many records
dim(dt0)  
# There are 902297 records with 37 variables

# Take a look of few records
head(dt0[,1:9])

# We are intersting on following variables
# EVTYPE - Event Type
# FATALITIES - death
# PROPDMG - property damage in millions

# Check PROPDMG data
x0 <- dt0$PROPDMG 
summary(x0)

x1 <- dt0$FATALITIES
summary(x1)

# Both datasets look good and there are no missing data

# Group the dataset by EVTYPE for both FATALITIES and PROPDMG 
# Use aggregate to sum FATALITIEs by EVTYPE 
dt1 <- aggregate(FATALITIES ~ EVTYPE, dt0, sum)

# Use aggregate to sum FATALITIEs by EVTYPE 
dt2 <- aggregate(PROPDMG ~ EVTYPE, dt0, sum)

# Use which.max to get maximum index for dt1$FATALITIEs and dt2$PROPDMG
# Then display the whole row information 
dt1[which.max(dt1$FATALITIES),]

dt2[which.max(dt2$PROPDMG),]


