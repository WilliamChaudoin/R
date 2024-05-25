#### Shiny User Interface

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('shiny')
#install.packages('tidyverse')
library(shiny)
library(tidyverse)

# Create User Interface
shinyUI(fluidPage(titlePanel('Motor Trend Car Road Tests Data'), 
  verticalLayout(plotOutput('histPlot'), sliderInput(inputId = 'bins',
  label = 'Number of bins:', min = 1, max = 10, value = 5))))

categorical_varibles = c('cyl', 'vs', 'am', 'gear', 'carb')

# Application Layout
shinyUI(fluidPage(
  br(),
  titlePanel(title = "Data Exploration Using Shiny"),
  sidebarLayout(
    sidebarPanel(
      h3('Explore mtcars'),
      varSelectInput("continuous_variable",
                     "Select Continuous Variable",
                     data = select(mtcars, -categorical_varibles),
                     selected = "mpg"),
      varSelectInput("categorical_variable",
                     "Select Categorical Variable",
                     data = mtcars[categorical_varibles],
                     selected = "cyl"),
      h3("Histogram settings:"),
      numericInput("bins",
                   "Number of bins",
                   min = 2,
                   max = 20,
                   value = 10),
      radioButtons("hist_fill",
                   "Histogram fill:",
                   choices = c("default", "blue")),
      h4("Plot Variable Map Guide"),
      p('Miles/gallon = mpg', br(),
        'Displacement (cu in.) = disp', br(),
        'Gross horsepower = hp', br(),
        'Rear axle ratio = drat', br(),
        'Weight (1000 lbs) = wt', br(),
        '1/4 mile time = qsec', br(),
        'Number of cylinders = cyl', br(),
        'Engine\n(0 = V-shaped, 1 = straight) = vs', br(),
        'Transmission\n(0 = automatic, 1 = manual) = am', br(),
        'Number of forward gears = gear', br(),
        'Number of carburetors = carb'
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Distribution of Numerical Variables",
          plotOutput("p1"),
          plotOutput("p2")
        ),
        tabPanel(
          "Distribution of Categorical Variables",
          plotOutput("p3")
        ),
        tabPanel(
          "Plots for Observing Data Correlation",
          plotOutput("p4"))
      )
    ),
    position = "right"
  )
))