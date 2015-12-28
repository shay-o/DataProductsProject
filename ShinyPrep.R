# Code for processing data for Slidify App

#Read data
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

# aggregate (remove granularity)
library(dplyr)
ByProviderStateCode <- group_by(data2,NPPES.Provider.State.Description,HCPCS.Description)

agg_ByProviderStateCode <- summarize(ByProviderStateCode,
                                     AmountAllowed = sum(Average.Medicare.Allowed.Amount),
                                     AmountSubmitted = sum(Average.Submitted.Charge.Amount),
                                     AmountPayed = sum(Average.Medicare.Payment.Amount)
) 

agg <- agg_ByProviderStateCode

# get services list
#Services <- as.list(agg$HCPCS.Description)
UniqueServices <- unique(as.list(agg$HCPCS.Description))

#d1 <- filter(agg,HCPCS.Description == tempservice)

# need to refer to colnum. select does not take a variable to refer to column
#d2 <- select(d1,match(tempmetric,names(d1))) 