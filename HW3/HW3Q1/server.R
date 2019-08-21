
#Question 1:
#As a researcher, you frequently compare mortality rates from particular causes across different States. 
#You need a visualization that will let you see (for 2010 only) the crude mortality rate, across all 
#States, from one cause (for example, Neoplasms, which are effectively cancers). Create a visualization 
#that allows you to rank States by crude mortality for each cause of death.


library(shiny)
library(ggplot2)
library(googleVis)
library(dplyr)

df <- df%>%
  filter(Year==2010)%>%
  select(ICD.Chapter, State, Crude.Rate)

shinyServer(function(input, output, session) {
  
  output$plot1 <- renderPlot({
    df1 <- df %>% filter(ICD.Chapter == input$disease)
    
    ggplot(data = df1, aes(x = reorder(State, Crude.Rate), y = Crude.Rate)) + geom_bar(stat = "identity")  + ggtitle("Mortality by States") + labs(x = "States", y = "Crude Rate")
    
  })
})