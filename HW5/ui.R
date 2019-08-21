#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  headerPanel('Housing Price Explorer'),
  sidebarPanel(
    selectInput('seas', 'Seasonality', unique(df$Seasonality), selected='SA'),
    selectInput('metro', 'Metro Area', unique(df$Metro), selected='Atlanta'),
    selectInput('tier', 'Housing Tier', unique(df$Tier), selected='High')
  ),
  mainPanel(
    plotOutput('plot1'),
    verbatimTextOutput('stats')
  )
)
)
