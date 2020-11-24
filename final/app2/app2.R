library(tidyverse)
library(shiny)

d = read_csv('titanic.csv')

variables_names = names(d)

ui <- fluidPage(
  
  titlePanel("App 2 : Bar Plot"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(
        inputId ="var1",
        label = "Select a Categorical Variable",
        choices = variables_names, selected = "Survived"
      ),
      
      selectInput(
        inputId ="var2",
        label = "Select a Categorical Variable",
        choices = variables_names,
        selected = "Sex"
      )
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      
      plotOutput(outputId = 'show_plot')
    )
  )
)

# server is a function! 
server <- function(input, output) {
  
  
  output$show_plot <- renderPlot({
    d = read_csv('titanic.csv')
    v1 = input$var1
    v2 = input$var2
    
    
    library(ggplot2)
    
    r = ggplot()+
      geom_bar(mapping=aes(x=d[[v1]], fill=d[[v2]]),
               position='dodge') +
      labs(x = v1, fill = v2)
    return(r)
    
    
  })
  
}
# app
shinyApp(ui = ui, server = server)