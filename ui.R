

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("State level aggregation of medicare health claims payments."), 

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      selectInput("Metric","Choose Metric",c("AmountAllowed","AmountSubmitted","AmountPayed")),
    
      selectInput("Procedure","Choose Procedure",UniqueServices)
    ),
  
    # Show a plot of the generated distribution
    mainPanel(
      p("This shows a histogram state-level data points for the chosen metric (Amount Allowed, Amount Submitted, Amount Payed) for the chosen procedure. The specific data is shown in the table below. This is useful as an initial exploration of the variability of submitted claims and payments for same procedure."),

      p("Data is healthcare provider data given to the Centers for Medicare and Medicaid Services (cms.gov). Data is from 2013."),
      p(tags$a(href="https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier2013.html", "See this page for more information")),
      tags$a(href="http://www.cms.gov/apps/ama/license.asp?file=http://download.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/Medicare_State_HCPCS_Aggregate_CY2013.zip", "Specific data file is here"),
      
      
      
      plotOutput("distPlot"),
      tableOutput("data_table")
    )
  )
)
)
