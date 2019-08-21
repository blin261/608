
library(shiny)
library(ggplot2)
library(dplyr)
library(reshape2)
library(devtools)


df <- read.csv("https://raw.githubusercontent.com/blin261/608/master/Infant_Neonatal_Mortality.csv")

df2 <- read.csv("https://raw.githubusercontent.com/blin261/608/master/Maternal_Mortality.csv")

df4 <- read.csv("https://raw.githubusercontent.com/blin261/608/master/Life_Expectancy.csv")

df4 <- df4[c(1, 2, 3)]
colnames(df4)[3] <- "Life_Expectancy"




total <- merge(df, df2, by=c("Region", "Year"))
total <- merge(total, df4, by=c("Region", "Year"))

total <- total%>%
  filter(Year==2015)