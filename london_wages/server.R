library(shiny)
# for use of magrittr pipe: %>%
library(dplyr)
#For ggvis package
library(ggvis)
#Load the London Real Wage Data
#The Data are from Robert Allen (2001)
londonrealwage <- read.csv("londonrealwage.csv")

shinyServer(function(input, output, session) {
    #Create the reactive function
    lrw <- reactive({
      data = londonrealwage[1:input$n, ]
    })
    #Create the plot behind the function
    lrw  %>%
      ggvis(x = ~Year, y = ~London_craftsman_real_wage, stroke := "blue") %>%
      layer_lines() %>%
      #layer_model_predictions(model = "lm", se = FALSE, stroke := "red") %>%
      add_axis("x", title = "Year", properties = axis_props(title = list(fontSize = 20))) %>%
      add_axis("y", title = "London Craftsmen's Real Wage ", subdivide=1, values = seq(0, 750, by = 50), 
               properties = axis_props(title = list(fontSize = 20))) %>%
      bind_shiny("plot", "plot_ui") 
  })

