
shinyUI(

  fluidPage(
  headerPanel("Mortality Rate and Life Expectancy Studies"),
  sidebarLayout(position = "left",
                sidebarPanel(
                  h5("by Bin Lin"),
                  h5("This visulization investigates the relationship between mortality rates and life expectancy at birth for the regions across the world."),
                  h5("1. User can view the current trend of mortality rate and life expectancy at birth over time based on region"),
                  h5("2. User can view the correlation between mortality rates and life expectancy"),
                  h5("3. User can make prediction of life expectancy using mortality rate data"),
                  helpText(a("Data Source: WHO Website", href="http://www.who.int/gho/en/")),
                  
                  selectInput("region", "Change Region", unique(df$Region), selected = "Americas"),

                  radioButtons("type", "Types of Mortality VS. Life Expectancy", c("Neonatal" = "neonatal", "Infant" = "infant", "Maternal" = "maternal"), selected = NULL), 
                  
                  sliderInput("slider1", "What is the Neonatal Mortality Rate?", 0, 100, value = 0),
                  sliderInput("slider2", "What is the Infant Mortality Rate?", 0, 100, value = 0),
                  sliderInput("slider3", "What is the Maternal Mortality Rate?", 0, 1000, value = 0)
                  ),
                
                mainPanel(
                  tabsetPanel(
                              tabPanel("Tab 1", fluidRow(splitLayout(cellWidths = c("40%", "30%", "30%"), plotOutput("plot1"), plotOutput("plot2"), plotOutput("plot3"))))),
                  
                              tabPanel("Tab 2", fluidRow(plotOutput("plot4"))),
                  
                              tabPanel("Tab 3", fluidRow(
                                verbatimTextOutput("summary"), 
                                h3("Predicted Life Expectancy:"), 
                                textOutput("pred")))
                )
  )
  )      
)