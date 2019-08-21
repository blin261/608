
#Question 1:
#As a researcher, you frequently compare mortality rates from particular causes across different States. 
#You need a visualization that will let you see (for 2010 only) the crude mortality rate, across all 
#States, from one cause (for example, Neoplasms, which are effectively cancers). Create a visualization 
#that allows you to rank States by crude mortality for each cause of death.

library(shiny)

shinyUI(fluidPage(
  headerPanel("Mortality"),
  sidebarPanel(
    selectInput("disease", "Change Disease", unique(df$ICD.Chapter), selected = "Certain infectious and parasitic diseases")
  ),
  
  mainPanel(
    plotOutput("plot1")
  )
))