library(shiny)

shinyServer(function(input, output) {
  
  metric <- reactive({
    input$Metric
  })
  
  newdata <- reactive({
    
    d1 <- subset(agg, HCPCS.Description == input$Procedure)
    return(d1)
    
  })
  
  histdata <- reactive({
    
    d1 <- subset(agg, HCPCS.Description == input$Procedure)
    d2 <- d1[[input$Metric]]
    return(d2)
    
  })
  
  output$distPlot <- renderPlot({
    
    x <- histdata()
    bins <- seq(min(x), max(x), length.out = 30 + 1)

    hist(x, breaks = bins, col = 'darkgray', border = 'white', main  = paste("Histogram of ", input$Metric, " at state level."), xlab = input$Metric)
  })
  

  output$data_table <- renderTable({

    # Return first 20 rows
    head(newdata(), 20)
  })

})

