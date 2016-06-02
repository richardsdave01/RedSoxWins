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
                  sep = ""),
      p("This application allows you to compare expected and actual wins for the
        Boston Red Sox over a range of years between 1901 and 2014."),
      p("Use the sliders to select the range of years that you want to analyze. 
        The plot is most readable when the range is held to 20 or fewer years."),
      p("The", span("red", style="color:red"), " bars show actual runs scored in each year."),
      p("The", span("blue", style="color:blue"), " bars show expected runs scored
         as calculated for each year using the formula:"),
      withMathJax("$$ExpWins = \\frac{R^2}{R^2 + RA^2} \\cdot G$$"),
      p("where R = runs scored, RA = runs allowed, and G = games played")
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
