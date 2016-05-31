
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Boston Red Sox - Expected vs. Actual Wins"),

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

    # Show a plot of the expected and actual wins vs. year
    mainPanel(
            textOutput("low"),
            textOutput("high"),
        
            plotOutput("winsPlot")
    )
  )
))
