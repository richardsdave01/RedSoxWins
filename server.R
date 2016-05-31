library(shiny)
library(Lahman)
data("Teams")
library(dplyr)
library(ggplot2)

#  create RedSox dataset
RedSox <- Teams %>% filter(lgID == 'AL' & teamID == 'BOS') %>% 
                    select(yearID, G, W, R, RA)


shinyServer(function(input, output) {
        
        
        output$low <- renderText({ paste("First Year: ", input$yearRange[1]) })
        output$high <- renderText({ paste("Last Year: ", input$yearRange[2]) })
        
        output$winsPlot <- renderPlot({
                
                yearStats <-
                        filter(RedSox, RedSox$yearID >= input$yearRange[1] &
                                       RedSox$yearID <= input$yearRange[2])
                yearStats$yearID <- as.factor(yearStats$yearID)
                
                ActWins <-
                        yearStats %>% select(yearID, W) %>% mutate(group = "Actual")
                ExpWins <-
                        yearStats %>% mutate(W = ((R^2) / (R^2 + RA^2)) * G) %>%
                        select(yearID, W) %>% 
                        mutate(group = "Expected")
                Wins <- rbind(ExpWins, ActWins)
                
                ggplot(Wins, aes(x=yearID, y=W, group=group, fill=group)) +
                        geom_bar(stat = "identity", position = "dodge") +
                        scale_fill_brewer(palette = "Set1") +
                        labs(x = "Year", y = "Wins", fill = "")
                
        })
})
