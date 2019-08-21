
library(shiny)
library(ggplot2)
library(googleVis)
library(dplyr)


df2 <- df%>%
  group_by(ICD.Chapter, Year)%>%
  summarize(Crude.Rate = sum(Deaths)/sum(Population)*100000)


df2$State <- as.factor("National")
df3 <- full_join(df2, df)


df3 <- df3%>%
  group_by(ICD.Chapter, State)%>%
  mutate(percent_change = (Crude.Rate - Crude.Rate[1]) / Crude.Rate[1])%>%
  select(ICD.Chapter, State, Year, Crude.Rate, percent_change)

                                                                            
shinyServer(function(input, output, session) {
  
  output$plot1 <- renderPlot({
    
    df4 <- df3 %>%
      filter(ICD.Chapter == input$disease, Year == input$year)
    
    ggplot(data = df4, aes(x = reorder(State, percent_change), y = percent_change)) + geom_bar(stat = "identity") + ggtitle("Mortality by States") + labs(x = "States", y = "Crude Rate Change Since 1999")
  })
})
