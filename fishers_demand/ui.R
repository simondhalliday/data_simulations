# ui.R
library(ggvis)
# load the data
fishmarket2 <- read.csv("fishmarket2.csv")
shinyUI(fluidPage(
  # Application title
  titlePanel("Aumaty Fish Market - A Buyer"),
  div(),
  sidebarPanel(
    #A slider with the number of points as input 
    #to show how the demand curve develops
    sliderInput("n", "Number of Observations", 
                min = 1, 
                max = nrow(fishmarket2),
                value = 1, 
                step = 1,
                animate = animationOptions(interval = 500)
                ),
    tags$h5("How the model works"),
    tags$p("The data are from Kirman and Haerdle's work on the 
           Aumaty Fish Market. These are price and quantity data
           for one fish buyer at the market."),
    tags$ul(
      tags$li("The", 
              tags$strong("slider"), 
              "allows you
              to add and remove observations from the fitted model. "), 
      tags$li(tags$strong("Hover"), 
              "your mouse over a data point to see the 
           price (francs per kilo) and quantity (kilograms of fish) 
           combination for that observation."),  
      tags$li("The fitted black line is from a", 
              tags$strong("linear model"),  
           "using ordinary least squares." )
      ),  
      tags$p("The fitted line initially has no consistent slope, but
           after adding observations with (up to 32) 
           the line is downward-sloping
           as we would expect a price-quantity correspondence or", 
           tags$strong("demand function"),
           "to be. Notice how adding the final 
           observation,", 
           tags$strong("an outlier,"),
           "affects the slope of the curve. 
           This observation should make you aware of the ways
           in which models can be sensitive to data. "),    
    uiOutput("plot_ui")
  ), mainPanel(
    ggvisOutput("plot"),
    tableOutput("fmkt_table")
  )
))