# Population Health and Economy impact by sever weather events from 1950 to 2012
Shinkuang Chang  
July 23, 2015  

#Synopsis
In this report we try to find out which severe weather event is most harmful to population and which severe weather event is most costly to economy through all the states. This study will be based on the storm data compiled by National Oceanic and Atmospheric Administration (NOAA). This data covers the severe wether events from 1950 to November of 2011. 


The data set is coming from ...

#Loading and Processing the Raw Data
##Reading the whole data 


```r
# Disable scientific notation
options(scipen=999)

filename <- "repdata_data_StormData.csv"
# Read NOAA severe weather events data to a data frame
dt0 <- read.table(filename,sep=",",header=T,na.strings = "")
```


```r
dim(dt0)
```

```
## [1] 902297     37
```

```r
num_records <- NROW(dt0)
```
There are 902297 in repdata_data_StormData.csv dataset. 

## Checking data set especially FATALITIES, and PROPDMG
Show first few rows of records for the first six variables.


```r
head(dt0[,1:6])
```

```
##   STATE__           BGN_DATE BGN_TIME TIME_ZONE COUNTY COUNTYNAME
## 1       1  4/18/1950 0:00:00     0130       CST     97     MOBILE
## 2       1  4/18/1950 0:00:00     0145       CST      3    BALDWIN
## 3       1  2/20/1951 0:00:00     1600       CST     57    FAYETTE
## 4       1   6/8/1951 0:00:00     0900       CST     89    MADISON
## 5       1 11/15/1951 0:00:00     1500       CST     43    CULLMAN
## 6       1 11/15/1951 0:00:00     2000       CST     77 LAUDERDALE
```


We are retrieving the FATALITIES to a dataset called fatality and PROPDMG to a dataset called propdmg. We will use the summary function in R to show some simple summaries of these two datasets. 


```r
# show the first few line of records
evtype <- dt0$EVTYPE
fatality <- dt0$FATALITIES
summary(fatality)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.0168   0.0000 583.0000
```

```r
propdmg <- dt0$PROPDMG
summary(propdmg)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    0.00    0.00    0.00   12.06    0.50 5000.00
```

From above code you can see that there are no missing values for both FATALITIES and PROMDMG variables from the original datasets and this is good for the following data analysis. 


#Result
## Entire U.S. analysis

```r
dt1 <- aggregate(FATALITIES ~ EVTYPE, data = dt0, FUN=sum)

event1 <- dt1[which.max(dt1$FATALITIES),1]
total_death <- dt1[which.max(dt1$FATALITIES),2]

dt2 <- aggregate(PROPDMG ~ EVTYPE, data = dt0, FUN = sum)
event2 <- dt2[which.max(dt2$PROMDMG),1]
total_damage <- dt2[which.max(dt2$PROPDMG),2]
```

TORNADO is the most deadly severe weather event accross U.S. from 1950 to November 2011. 
Total death for TORNADO is 5633.

 is the most costly severe weather event accross U.S. from 1950 to November 2011. 
Total damage cost for  is 3212258.16 millions U.S. dollars. 


Following graph will show the top 10 deadly severe weather events accross U.S. from 1950 to November 2011.



```r
dt1_ordered <- dt1[order(-dt1$FATALITIES),]
dt1_top10 <- dt1_ordered[1:10,]
dt1_top10
```

```
##             EVTYPE FATALITIES
## 834        TORNADO       5633
## 130 EXCESSIVE HEAT       1903
## 153    FLASH FLOOD        978
## 275           HEAT        937
## 464      LIGHTNING        816
## 856      TSTM WIND        504
## 170          FLOOD        470
## 585    RIP CURRENT        368
## 359      HIGH WIND        248
## 19       AVALANCHE        224
```

```r
dt1_xaxis_label <- dt1_top10$EVTYPE
dt1_xaxis_label
```

```
##  [1] TORNADO        EXCESSIVE HEAT FLASH FLOOD    HEAT          
##  [5] LIGHTNING      TSTM WIND      FLOOD          RIP CURRENT   
##  [9] HIGH WIND      AVALANCHE     
## 985 Levels:    HIGH SURF ADVISORY  COASTAL FLOOD ... WND
```

```r
barplot(dt1_top10$FATALITIES,main="Top 10 deadly severe weather events", ylab="Total death",names.arg = dt1_xaxis_label, las = 2)
```

![](assign2_files/figure-html/unnamed-chunk-1-1.png) 

Following graph will show the top 10 costly severe weather events accross U.S. from 1950 to November 2011.



```r
dt2_ordered <- dt2[order(-dt2$PROPDMG),]
dt2_top10 <- dt2_ordered[1:10,]
dt2_top10
```

```
##                 EVTYPE   PROPDMG
## 834            TORNADO 3212258.2
## 153        FLASH FLOOD 1420124.6
## 856          TSTM WIND 1335965.6
## 170              FLOOD  899938.5
## 760  THUNDERSTORM WIND  876844.2
## 244               HAIL  688693.4
## 464          LIGHTNING  603351.8
## 786 THUNDERSTORM WINDS  446293.2
## 359          HIGH WIND  324731.6
## 972       WINTER STORM  132720.6
```

```r
dt2_xaxis_label <- dt2_top10$EVTYPE
dt2_xaxis_label
```

```
##  [1] TORNADO            FLASH FLOOD        TSTM WIND         
##  [4] FLOOD              THUNDERSTORM WIND  HAIL              
##  [7] LIGHTNING          THUNDERSTORM WINDS HIGH WIND         
## [10] WINTER STORM      
## 985 Levels:    HIGH SURF ADVISORY  COASTAL FLOOD ... WND
```

```r
barplot(dt2_top10$PROPDMG,main="Top 10 costly severe weather events", ylab="Total damage in millions",names.arg = dt2_xaxis_label, las = 2)
```

![](assign2_files/figure-html/unnamed-chunk-2-1.png) 
