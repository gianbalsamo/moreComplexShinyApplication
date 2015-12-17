
#require(rCharts)
library(lubridate)
library(zoo)
library(ggplot2)
require(devtools)
require(shiny)
library(shiny)

#install_github('ramnathv/rCharts') 

moneySupply<-read.csv('Turkey_vs_EuroArea.csv',header = TRUE)
moneySupply<-moneySupply[,c("LOCATION","TIME","Value")]
moneySupply[,"TIME"]<-paste(moneySupply[,"TIME"],"01",sep="-")

M1Turkey<-moneySupply[moneySupply[,"LOCATION"]=="TUR",c("TIME","LOCATION","Value")]
M1EuroArea<-moneySupply[moneySupply[,"LOCATION"]=="EA19",c("TIME","LOCATION","Value")]

compactM1<-cbind(M1Turkey,M1EuroArea[c("LOCATION","Value")])

colnames(compactM1)[3]<-"ValueTurkey"
colnames(compactM1)[5]<-"ValueEuroArea"
compactM1<-compactM1[,c(1,3,5)]

result <- function(time) {
      return((compactM1[compactM1[,"TIME"]==time,"ValueTurkey"]-100)/
                   (compactM1[compactM1[,"TIME"]==time,"ValueEuroArea"]-100))
}

shinyServer(
      function(input, output) {
            
            #moneySupply<-read.csv('/Users/gianfrancobalsamo/Dropbox/BIG_DATA/DevelopingDataProducts/final-project/myApp-3/Turkey_vs_EuroArea.csv',header = TRUE)
            moneySupply<-read.csv('Turkey_vs_EuroArea.csv',header = TRUE)
            moneySupply<-moneySupply[,c("LOCATION","TIME","Value")]
            moneySupply[,"TIME"]<-paste(moneySupply[,"TIME"],"01",sep="-")
            
            M1Turkey<-moneySupply[moneySupply[,"LOCATION"]=="TUR",c("TIME","LOCATION","Value")]
            M1EuroArea<-moneySupply[moneySupply[,"LOCATION"]=="EA19",c("TIME","LOCATION","Value")]
            
            compactM1<-cbind(M1Turkey,M1EuroArea[c("LOCATION","Value")])
            
            colnames(compactM1)[3]<-"ValueTurkey"
            colnames(compactM1)[5]<-"ValueEuroArea"
            compactM1<-compactM1[,c(1,3,5)]
            output$myChart <- renderChart({
                  m1 <- mPlot(x = "TIME", y = c("ValueTurkey","ValueEuroArea"), type = "Line", data = compactM1)
                  m1$set(dom="myChart")
                  #m1$set(pointSize = 0, lineWidth = 3)
                  #m1$addParams(dom = 'myChart')
                  return(m1)
            })
            #output$value <- renderPrint({ input$text })
            #output$tempo <- renderPrint({ input$text })
            #output$ratio <- renderPrint({result(input$text)})
            output$date <- renderPrint({input$date})
            output$ratio <- renderPrint({result(input$date)})
            output$documentation <- renderText({"User Instructions: \n (1) click on COST FUNCTION tab; \n (2) go to calendar on the left; \n (3) available dates: 1992-06-01 to 2014-01-01; \n (4) click on an 'available' date ending in '-01'; \n (5) your selected date appears on the right beneath label: \n 'Queried Date'; \n (6) value of cost function appears beneath label: \n 'Cost Function'; \n (7) for selected date, \n value of cost function shows ratio of \n Turkey's money supply increase over Europe's; \n (8) hover cursor over interactive chart beneath \n label 'Plot'; \n (9) see difference in money supply (2010=100)"})
      }
)

