#load("Medicare_Data.Rda")

#Next create a simple aggregated table of Charges and payments by state. 
#Allow user to choose state and get those metrics.

library(plyr)
agg <- ddply(data, c("Provider.State"), summarize, 
        Payments = sum(Average.Total.Payments),              
        CoveredCharges = sum(Average.Covered.Charges),
        PercentPayments = Payments/CoveredCharges
)

###
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("rstudio/rsconnect")