
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("State level aggregation of health payments."), 

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
    
      
      selectInput("Metric","Choose Metric",c("Payments","CoveredCharges","PercentPayments"))
      ),

    # Show a plot of the generated distribution
    mainPanel(
      
      plotOutput("distPlot"),
      h5("Data taken from courtesy of John Muschellis github repo (https://github.com/muschellij2/Shiny_Health_Data) via the Centers for Medicaid and Medicare."),
      h5("(https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier2013.html)."),
      h5("Note application is unrelated to shiny app at the repo above.")
                 
    )
  )
))
