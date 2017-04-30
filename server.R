
library(shiny)
library(forecast)
shinyServer(function(input, output) {
      weeklydata <- read.csv("Ontariotest.csv")
      weeklydata[is.na(weeklydata)] <- 0
      #Scrub an outlier
      weeklydata[50:53,3] <- weeklydata[50:53,3]-300
      weeklydata[51,3] <- weeklydata[51,3]-150
      testing = weeklydata[grep("2017", weeklydata$Week),]
      training = weeklydata[-grep("2017", weeklydata$Week),]
      training  
      weeklytrend <- ts(training$Sales, start = c(2014, 1), frequency = 52)
  output$docutext <- renderText({ 
    print("This web app runs Holt-Winters exponential smoothing on some sample data we have provided. 
          You can manipulate the three model parameters using the slider bar on the left side of this app, to see the impact on our forecast. 
          You can also choose the number of weeks this model should forecast ahead for (up to 104 weeks).")
    })
  output$forecastPlot <- renderPlot({
    hw <- HoltWinters(weeklytrend, alpha=input$alpha, beta=input$beta, gamma=input$gamma)
  forecast1 <- forecast(hw, level = 90, h=input$forecastperiods)
  plot(forecast1, ylab="Volume", xlab="Year", main="Holt-Winters Forecast")

  })
})
