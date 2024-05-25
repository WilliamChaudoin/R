#### Shiny Server

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('shiny')
#install.packages('ggplot2')
library(shiny)
library(ggplot2)

# To Be Used It Connection With The Shiny User Interface Script

# Define Server
shinyServer(function(input, output) {output$histPlot = renderPlot({
 ggplot(mtcars, aes(x = mpg)) + geom_histogram(bins = input$bins) +
 labs(x = "Miles/gallon", y = 'Frequency', title = 'Histogram Of Miles/Gallon Of Cars') +
 theme(text = element_text(size = 20))})})

# Define Server Logic
shinyServer(function(input, output) { 
  output$p1 <- renderPlot({
    p = ggplot(mtcars, aes(x = !!input$continuous_variable)) +
      labs(y = "Number of Cars", title = paste("Trend of ", input$continuous_variable))
    if (input$hist_fill == "default") {
      p + geom_histogram(bins = input$bins)
    }
    else {
      p + geom_histogram(bins = input$bins, fill = "dodgerblue3")
    }
  })
  
  output$p2 = renderPlot({
    ggplot(mtcars, aes(y = !!input$continuous_variable)) +
      geom_boxplot() +
      labs(title = paste("How", input$continuous_variable, "value is spread")) +
      coord_flip()
  })
  
  output$p3 = renderPlot({
    ggplot(data = mtcars,
           aes(x = factor(!!input$categorical_variable),
               fill = factor(!!input$categorical_variable))) +
      geom_bar() +
      labs(x = input$categorical_variable,
           title = paste("Trend of", input$categorical_variable))
  })
  
  output$p4 = renderPlot({
    ggplot(mtcars, aes(x = !!input$continuous_variable,
                       y = wt,
                       color = factor(!!input$categorical_variable))) +
      geom_point(size = 3) +
      labs(title = paste("Distribution of", input$continuous_variable, "with respect to Weight"))
  })
})