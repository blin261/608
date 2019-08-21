library(shiny)

shinyUI(fluidPage(
  headerPanel("Mortality"),
  sidebarPanel(
    selectInput("disease", "Change Disease", unique(df$ICD.Chapter), selected = "Certain infectious and parasitic diseases"),
    selectInput("year", "Change Years", unique(df$Year), selected = "2010")
    
  ),
  
  mainPanel(
    plotOutput("plot1")
  )
))