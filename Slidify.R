require(devtools)

install_github("ramnathv/slidify")
install_github("ramnathv/slidifyLibraries")

library(slidify)

slidify("index.Rmd")

publish(user = "shay-o", repo = "DataProductsProject")
