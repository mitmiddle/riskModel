#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(scales)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  options(scipen=999)
  summaryDF <- reactive({
    poiPhish <- rpois(n = input$poiPhish_iter, input$poiPhish_mean)
    prtLabor <- rpert(n = input$poiPhish_iter,
                      input$prtLabor_min,
                      input$prtLabor_mean,
                      input$prtLabor_max,
                      input$prtLabor_con)
    poiBreach <- rpois(n = input$poiPhish_iter, 
                       (1/input$poiBreach_mean))
    prtBreach <- rpert(n = input$poiPhish_iter,
                       input$prtBreach_min,
                       input$prtBreach_mean,
                       input$prtBreach_max,
                       input$prtBreach_con)
    
    alePhish <- poiPhish * (prtLabor * input$blendedRate + (poiBreach * (prtBreach * input$breachCost)))
    
    df <- data.frame(as.list(summary(alePhish)))

  })
  alePhishDF <- reactive({
    poiPhish <- rpois(n = input$poiPhish_iter, input$poiPhish_mean)
    prtLabor <- rpert(n = input$poiPhish_iter,
                      input$prtLabor_min,
                      input$prtLabor_mean,
                      input$prtLabor_max,
                      input$prtLabor_con)
    poiBreach <- rpois(n = input$poiPhish_iter, 
                       (1/input$poiBreach_mean))
    prtBreach <- rpert(n = input$poiPhish_iter,
                       input$prtBreach_min,
                       input$prtBreach_mean,
                       input$prtBreach_max,
                       input$prtBreach_con)
    
    alePhish <- poiPhish * (prtLabor * cstLabor + (poiBreach * (prtBreachRecords * cstBreachRecords)))
    
  })
  output$poiPhishPlot <- renderPlot({
    
    poiPhish <- rpois(n = input$poiPhish_iter, input$poiPhish_mean)
    
    bins <- seq(min(poiPhish), max(poiPhish), length.out = input$bins + 1)
    
    hist(poiPhish, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  output$prtLaborPlot <- renderPlot({
    
    
    prtLabor <- rpert(n = input$poiPhish_iter,
                      input$prtLabor_min,
                      input$prtLabor_mean,
                      input$prtLabor_max,
                      input$prtLabor_con)
    
    bins <- seq(min(prtLabor), max(prtLabor), length.out = input$bins + 1)
    
    hist(prtLabor, col = 'darkgray', border = 'white')
  })
  output$poiBreachPlot <- renderPlot({
    
    poiBreach <- rpois(n = input$poiPhish_iter, 
                       (1/input$poiBreach_mean))
    
    bins <- seq(min(poiBreach), max(poiBreach), length.out = input$bins + 1)
    
    hist(poiBreach, breaks = bins, col = 'darkgray', border = 'white')
  })
  output$prtBreachPlot <- renderPlot({
    
    
    prtBreach <- rpert(n = input$poiPhish_iter,
                      input$prtBreach_min,
                      input$prtBreach_mean,
                      input$prtBreach_max,
                      input$prtBreach_con)
    
    bins <- seq(min(prtBreach), max(prtBreach), length.out = input$bins + 1)
    
    hist(prtBreach, col = 'darkgray', border = 'white')
    #alePhish <- poiPhish * (prtLabor * cstLabor + (poiBreach * (prtBreachRecords * cstBreachRecords)))
  })
  output$alePhishTable <- renderTable({
    l <- as_tibble(summaryDF())
    l <- select(l, "Minimum" = "Min.", 
                    "Good Year" = "X1st.Qu.",
                    "Typical Year" = "Median",
                    "Bad Year" = "X3rd.Qu.",
                    "Maximum" = "Max.")
    l <- lapply(l[1:5], function(x) prettyNum(paste0("$",x), big.mark=","))
  })
})
