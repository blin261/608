
shinyServer(function(input, output, session) {
  selectedData1 <- reactive({
    df1 <- df %>%
      filter(Region == input$region)
  })

  selectedData2 <- reactive({
    df3 <- df2 %>%
      filter(Region == input$region)
  })
  
  selectedData3 <- reactive({
    df5 <- df4 %>%
      filter(Region == input$region)
  })
  
  selectedData4 <- reactive({input$type})
  
  
  
  output$plot1 <- renderPlot({
    df1 <- df%>%
      filter(Region == input$region)
    ggplot(selectedData1(), aes(x = Year)) + 
      geom_line(aes(y = Infant_Mortality_Rate, color = "Infant", stat = "identity")) +
      geom_line(aes(y = Neonatal_Mortality_Rate, color = "Neonatal", stat = "identity")) +
      scale_colour_manual("", breaks = c("Infant", "Neonatal"), values = c("red", "blue")) + 
      ggtitle("Mortality Rates by Region") + labs(x = "Year", y = "Mortality Rate per 1000 Births")
  })


  output$plot2 <- renderPlot({
    df3 <- df2%>%
      filter(Region == input$region)
    ggplot(selectedData2(), aes(x = Year)) + 
      geom_line(aes(y = Maternal_Mortality_Ratio),  color = "green", stat = "identity") +
      ggtitle("Maternal Mortality Ratio by Region") + labs(x = "Year", y = "Maternal mortality ratio (per 100 000 live births)")
    })
  
  
  output$plot3 <- renderPlot({
    df5 <- df4%>%
      filter(Region == input$region)
    ggplot(selectedData3(), aes(x = Year)) + 
      geom_line(aes(y = Life_Expectancy),  color = "black", stat = "identity") +
      ggtitle("Life Expectancy by Region") + labs(x = "Year", y = "Life Expectancy at Birth")
  })
  
  
  
  output$plot4 <- renderPlot({
    if (selectedData4() == "neonatal")
      {
      ggplot(data = total, aes(x = Neonatal_Mortality_Rate, y = Life_Expectancy)) +
        geom_point(color = "red", stat = "identity") +
        ggtitle("Neonatal Mortality Rate VS. Life Expectancy") + 
        labs(x = "Neonatal Mortality Rate", y = "Life Expectancy at Birth") +
        geom_smooth(method='lm', se = FALSE) + 
        annotate("text", x = 30, y = 75, label = paste("Correlation: ", cor(total$Neonatal_Mortality_Rate, total$Life_Expectancy)))
    }
    
    
    else if (selectedData4() == "infant")
      {
      ggplot(data = total, aes(x = Infant_Mortality_Rate, y = Life_Expectancy)) + 
        geom_point(color = "red", stat = "identity") +
        ggtitle("Infant Mortality Rate VS. Life Expectancy") + 
        labs(x = "Infant Mortality Rate", y = "Life Expectancy at Birth") +
        geom_smooth(method='lm',se = FALSE) + 
        annotate("text", x = 50, y = 75, label = paste("Correlation: ", cor(total$Infant_Mortality_Rate, total$Life_Expectancy)))
    }
    
    
    else if (selectedData4() == "maternal")
    {
      ggplot(data = total, aes(x = Maternal_Mortality_Ratio, y = Life_Expectancy)) + 
        geom_point(color = "red", stat = "identity") +
        ggtitle("Maternal Mortality Rate VS. Life Expectancy") + 
        labs(x = "Maternal Mortality Rate", y = "Life Expectancy at Birth") +
        geom_smooth(method='lm', se = FALSE) + 
        annotate("text", x = 400, y = 75, label = paste("Correlation: ", cor(total$Maternal_Mortality_Ratio, total$Life_Expectancy)))
    }
  })
  
  
  
      model1 <- lm(Life_Expectancy ~ Neonatal_Mortality_Rate + Infant_Mortality_Rate + Maternal_Mortality_Ratio, data = total)
      
      prediction <- reactive({
        neonatal_input <- input$slider1
        infant_input <- input$slider2
        moternal_input <- input$slider3
        predict(model1, newdata = data.frame(Neonatal_Mortality_Rate = neonatal_input, Infant_Mortality_Rate = infant_input, Maternal_Mortality_Ratio = moternal_input))
        })
      
    output$summary <- renderPrint({
      summary(model1)
    })
    
    output$pred <- renderText({
      prediction()
    })

})


