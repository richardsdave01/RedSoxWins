## Developing Data Products class project
## Author: Dave Richards
## Date: May 31, 2016
##
## server.R

library(shiny)
library(dplyr)
library(ggplot2)

# get team data from the Lahman package
library(Lahman)
data("Teams")

# Extract Red Sox data - this only needs to be done once
RedSox <- Teams %>% filter(lgID == 'AL' & teamID == 'BOS') %>% 
        select(yearID, G, W, R, RA)



shinyServer(function(input, output) {
        
        # Display the first and last years of the range selected by the user
        
        output$low <- renderText({ paste("First Year: ", input$yearRange[1]) })
        output$high <- renderText({ paste("Last Year: ", input$yearRange[2]) })

        
        # Display the plots of expected and actual wins for each year in the range
        
        output$winsPlot <- renderPlot({
                
                # extract stats for the years in the range
                yearStats <-
                        filter(RedSox, RedSox$yearID >= input$yearRange[1] &
                                       RedSox$yearID <= input$yearRange[2])
                yearStats$yearID <- as.factor(yearStats$yearID)
                
                # create a data frame with actual wins from the Lahman data
                ActWins <-
                        yearStats %>% select(yearID, W) %>% mutate(group = "Actual")
                
                # calculate expected wins for each year, put into another data frame
                ExpWins <-
                        yearStats %>% mutate(W = ((R^2) / (R^2 + RA^2)) * G) %>%
                        select(yearID, W) %>% 
                        mutate(group = "Expected")
                
                # combine into a single data frame for ggplot to use
                Wins <- rbind(ExpWins, ActWins)
                
                # create the plots
                ggplot(Wins, aes(x=yearID, y=W, group=group, fill=group)) +
                        geom_bar(stat = "identity", position = "dodge") +
                        scale_fill_brewer(palette = "Set1") +
                        labs(x = "Year", y = "Wins", fill = "")
                
        })
})
