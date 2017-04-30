
library(shiny)
library(forecast)
shinyUI(fluidPage(
  titlePanel("Holt-Winters Forecasting"),
  sidebarLayout(
    sidebarPanel(
       sliderInput("alpha",
                   "Alpha: (Smoothing Factor)",
                   min = 0.01,
                   max = 1, value = 0.03
              ),
       sliderInput("beta",
                   "Beta: (Trend Factor)",
                   min = 0,
                   max = 1, value = 0.1
       ),
       sliderInput("gamma",
                   "Gamma: (Seasonal Smoothing Factor)",
                   min = 0,
                   max = 1, value = 0.7
       ),
       numericInput("forecastperiods", "Number of Weeks to Forecast:", 
                    value = 52, min = 1, max = 104, step = 1)
    ),
    mainPanel(
       textOutput("docutext"),
       plotOutput("forecastPlot")
    )
  )
))
