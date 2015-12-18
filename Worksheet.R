#load("Medicare_Data.Rda")

#Next create a simple aggregated table of Charges and payments by state. 
#Allow user to choose state and get those metrics.

library(plyr)
grouping <- group_by(data,Path.Size)
agg <- aggregate(data, c("Provider.State"), summarize, 
        Payments = sum(Average.Total.Payments),              
        CoveredCharges = sum(Average.Covered.Charges),
        PercentPayments = Payments/CoveredCharges
)

### for deploying shiny app

if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("rstudio/rsconnect")

library(rsconnect)

deployApp()

#--- Slidify commands
require(devtools)

install_github("ramnathv/slidify")
install_github("ramnathv/slidifyLibraries")

library(slidify)

slidify("index.Rmd")

publish(user = "shay-o", repo = "DataProductsProject")
publish(user = "shay-o", repo = "REPO", host = 'github')

#NEXT Look at difference in charges for different procedures DRGs.
# Get source data and look at disparity in covered charges for the same DRG.
#https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Inpatient2013.html

