require(rCharts)

# require('rCharts')
# require('shiny')
# require("quantmod")
# require("TTR")
# require("stringr")
# require('lubridate')

#options(RCHART_LIB = "morris")
shinyUI(pageWithSidebar(
      headerPanel("Relative Increase in Money Supply"),
      sidebarPanel(
            dateInput("date", "click first day of any month for any available year")
      ),
      mainPanel(
            headerPanel("Money Supply Policy: Turkey versus Euro Area"),
            tabsetPanel(
                  tabPanel("DOCUMENTATION", verbatimTextOutput("documentation")),
                  tabPanel("COST FUNCTION",
                           h3("Queried Date"),
                           h4("Available dates: from 1992-06-01 to 2014-01-01"),
                           #verbatimTextOutput("tempo"),
                           verbatimTextOutput("date"),
                           h3("COST FUNCTION"),
                           h4("Turkey's multiplier of Europe's money-supply increase"),
                           verbatimTextOutput("ratio"),
                           h4("Plot"),
                           showOutput("myChart","morris"))
            )
      )
))