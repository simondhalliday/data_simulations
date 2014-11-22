#Server.R
#Author1: Simon Halliday (Smith College) 
#Author2: Andrew Bray (Mount Holyoke College)
#shalliday@smith.edu

# load the shiny package
library(shiny)

# load the ggvis package
library(ggvis)

# load the dplyr package
# for use of magrittr pipe: %>%
library(dplyr)


shinyServer(function(input, output, session) {
  
#head(fishmarket)
# A reactive version of my fishmarket data for one buyer
  
  # load the data
  fishmarket2 <- read.csv("fishmarket2.csv")
  fmkt <- reactive({
           data = fishmarket2[1:input$n, ]
  })
  
  fmkt %>% 
    ggvis(x = ~kilos, y = ~Francs.per.kilo, fill := "blue", stroke := "black") %>% 
    layer_points() %>%
    layer_model_predictions(model = "lm", se = FALSE) %>%
    add_axis("x", title = "Kilograms of Fish") %>%
    add_axis("y", title = "Francs Per Kilogram") %>%
    scale_numeric("x", domain = c(0, 20), nice = FALSE) %>%
    scale_numeric("y", domain = c(10, 100), nice = FALSE) %>%
    add_tooltip(function(data){
      paste0("kg: ", data$kilos, "<br>", "Francs/kg: ",as.character(data$Francs.per.kilo))
    }, "hover") %>%
    bind_shiny("plot", "plot_ui")
  
    output$fmkt_table <- renderTable({
    fmkt()[, c("kilos", "Francs.per.kilo")]
  })
})

  

  
