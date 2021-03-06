---
title       : Data Data Products Course Project
subtitle    : Shiny Application and Reproducible Pitch
author      : Shay O
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---

## Summary

This application provides histogram of Medicaid health care payment data aggregated to the state level. User can choose one of three metrics to view distribution of values at the state level.

http://www.cms.gov/apps/ama/license.asp?file=http://download.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/Medicare_State_HCPCS_Aggregate_CY2013.zip

This application shows a histogram and data table of state-level data points for the chosen metric (Amount Allowed, Amount Submitted, Amount Payed) for the chosen procedure. This is intended to be useful as an initial exploration of the variability of submitted claims and payments for same procedure.

The data is healthcare provider data given to the Centers for Medicare and Medicaid Services (cms.gov). Data is from 2013.
  
See this page for more information:      
https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier2013.html


```r
library(dplyr)
 
rawdata <- read.csv("./Medicare-State-HCPCS-Aggregate-CY2013.csv")
# data from http://www.cms.gov/apps/ama/license.asp?file=http://download.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/Medicare_State_HCPCS_Aggregate_CY2013.zip

# remove columns
data2 <- rawdata[c(1:10,14,18)] # remove colums for min, max, std. Keep just row definition and averages.

# change column formats
data2$Average.Submitted.Charge.Amount <- as.numeric(data2$Average.Submitted.Charge.Amount) 
data2$Average.Medicare.Allowed.Amount <- as.numeric(data2$Average.Medicare.Allowed.Amount)
data2$Average.Medicare.Payment.Amount <- as.numeric(data2$Average.Medicare.Payment.Amount)
data2$NPPES.Provider.State.Description <- as.character(data2$NPPES.Provider.State.Description)
data2$HCPCS.Description <- as.character(data2$HCPCS.Description)
```

--- .class #id 

## Methodology
Raw data file is here:
http://www.cms.gov/apps/ama/license.asp?file=http://download.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/Medicare_State_HCPCS_Aggregate_CY2013.zip

File was saved as a csv then loaded into R Studio. I removed columns and reformated some. 

Data is aggregated by state as follows:

```r
ByProviderStateCode <- group_by(data2,NPPES.Provider.State.Description,HCPCS.Description)


agg_ByProviderStateCode <- summarize(ByProviderStateCode,
                                     AmountAllowed = sum(Average.Medicare.Allowed.Amount),
                                     AmountSubmitted = sum(Average.Submitted.Charge.Amount),
                                    AmountPayed = sum(Average.Medicare.Payment.Amount)
) 

agg_ByProviderStateCode <- agg_ByProviderStateCode[order(-agg_ByProviderStateCode$AmountSubmitted),]
agg_ByProviderStateCode$HCPCS.Description[1]
```

```
## [1] "Treatment of broken ankle"
```

```r
temp <- agg_ByProviderStateCode$AmountSubmitted[which(agg_ByProviderStateCode$HCPCS.Description=='Treatment of broken ankle')]
```

--- .class #id 

The app is intended as an exploratory tool showing the range of data for different procedures. For example the most common procedure is 'Treatment of broken ankle'. 

We can see there is a significant range in submitted requests. The average is 9.1996154 &times; 10<sup>5</sup> but the max is 1.908132 &times; 10<sup>6</sup> and the min is 1.14244 &times; 10<sup>5</sup>.

--- .class #id 

```r
    hist(temp, col = 'darkgray', border = 'white', main  = paste("Histogram of submitted cost for 'Broken Ankle' at state level."), xlab = "Amount Submitted")
```

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3-1.png) 
