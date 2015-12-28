# Sandbox for miscellaneous, temporary code

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



#--------- Misc"T

#ByDescription <- group_by(data2,HCPCS.Description)

agg_temp <- summarize(ByDescription,
                                     AmountAllowed = sum(Average.Medicare.Allowed.Amount),
                                     AmountSubmitted = sum(Average.Submitted.Charge.Amount),
                                     AmountPayed = sum(Average.Medicare.Payment.Amount)
) 

agg_temp <- agg[order(-agg$AmountSubmitted),]

x <- agg_temp[1,2]

tdesc <- "Treatment of broken ankle"

names(agg_temp)
t <- agg_temp[which(agg_temp$HCPCS.Description=='Treatment of broken ankle'),]
hist(t$AmountPayed)
