## Developing Data Products class project
## Author: Dave Richards
## Date: May 31, 2016
##
## ui.R

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Boston Red Sox - Actual vs. Expected Wins"),

  # Sidebar with a slider input for years to be analyzed
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearRange",
                  "Range of years to analyze:",
                  min = 1901,
                  max = 2014,
                  value = c(1950, 1960),
                  sep = "")
    ),

    # Show minimum & maximum years selected and
    #   bar plots of the expected and actual wins vs. year
    mainPanel(
            textOutput("low"),
            textOutput("high"),
        
            plotOutput("winsPlot")
    )
  )
))
