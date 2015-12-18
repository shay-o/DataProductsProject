---
title       : Data Products Assignment 1
subtitle    : 
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

Data is set originally from CMS.gov. I gathered it from https://github.com/muschellij2/Shiny_Health_Data which houses an unrelated Shiny app using this data. This application is unrelated to that application. I would jsut like to acknowledge muschellij2 had collected this data original.

https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier2013.html

Changed23

--- .class #id 

## Methodology

Data is aggregated as follows:

```r
library(plyr)
agg <- ddply(data, c("Provider.State"), summarize, 
        Payments = sum(Average.Total.Payments),              
        CoveredCharges = sum(Average.Covered.Charges),
        PercentPayments = Payments/CoveredCharges)
```


