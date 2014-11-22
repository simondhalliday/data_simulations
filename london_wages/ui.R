library(shiny)
# for use of magrittr pipe: %>%
library(dplyr)
#For ggvis package
library(ggvis)
londonrealwage <- read.csv("londonrealwage.csv")
shinyUI(fluidPage(
  titlePanel("The Wages of London Craftsmen Over Time"),
  div(),
    sidebarPanel(
 #responsive = FALSE,
                 sliderInput("n", "Number of Observations",
                             min = 1,
                             max = nrow(londonrealwage),
                             value = 1,
                             step = 8,
                             animate = animationOptions(interval = 400)
                 ), tags$h5("Discussion of the Data"),
           tags$p("The data are from Robert Allen (2001), 
          `The Great Divergence in European Wages and Prices 
           from the Middle Ages to the First World War.' 
           Methods can be found in that paper. 
           These are real wage data with 1850 as the base year.
           Real wages are calculated as grams of silver 
           nominal wage/consumer price index. Data provided 
           courtesy of",  
            tags$a(href="http://ineteconomics.org/", "INET"), 
            "and the",
             tags$a(href="http://core-econ.org/", "CORE-ECON project"),
            "."),
                 uiOutput("plot_ui") 
                 ), mainPanel(
  ggvisOutput("plot")
  )
))
