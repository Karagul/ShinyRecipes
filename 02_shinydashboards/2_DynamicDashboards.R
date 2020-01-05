##-------------------------------------------------------------###
##
## Course: Shinydashboards 
##
## Chapter 1 - Reactivity in Shinydashboards
## Natarajan G
## 29/Dec/2019
##
##-------------------------------------------------------------###

# 0 Load required libraries

library(shinydashboard)
library(shiny)

# Create an empty header
header <- dashboardHeader()

# Create an empty sidebar
sidebar <- dashboardSidebar()

# Create an empty body
body <- dashboardBody()



ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)


#1 - input controls

sidebar <- dashboardSidebar(
  # Add a slider
  sliderInput(inputId = "height",
              label = "Height",
              min = 66,
              max = 264,
              value = 264)
)


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = dashboardBody()
)
shinyApp(ui, server) 

# connect UI to take inputs, Server to render object & UI to output rendered object

library(shiny)
library(dplyr)

data("starwars")

sidebar <- dashboardSidebar(
  # Create a select list
  selectInput(inputId = "name",
              label = "Name",
              choices = starwars$name
  )
)

body <- dashboardBody(
  textOutput(outputId ="name")
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)

server <- function(input, output) {
  output$name <- renderText({
    input$name
  })
}

shinyApp(ui, server)



## 3 Reactive File Reader : Realtime dashboarding

# Read in real-time data
# One benefit of a dashboard is the ability to examine real-time data. 
# In shiny, this can be done using the reactiveFileReader() or reactivePoll() functions from the shiny package. 
# For example, if we had our data saved as a .csv, we could read it in using reactiveFileReader() along with the readFunc set to read.csv.


library("shiny")

starwars_url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_6225/datasets/starwars.csv"

server <- function(input, output, session) {
  reactive_starwars_data <- reactiveFileReader(
    intervalMillis = 1000,
    session = session,
    filePath = starwars_url,
    readFunc = function(filePath) { 
      read.csv(url(filePath))
    }
  )
  
  output$table <- renderTable({reactive_starwars_data()})
}

body <- dashboardBody(
  tableOutput("table")
)


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)


## 5

# https://www.rstudio.com/resources/videos/profiling-and-performance/

task_data <- read.csv("tasks.lst", stringsAsFactors = F)

server <- function(input, output) {
  output$task_menu <- renderMenu({
    tasks <- apply(task_data, 1, function(row) {
      taskItem(text = row[["text"]],
               value = row[["value"]])
    })
    dropdownMenu(type = "tasks", .list = tasks)
  })
}

header <- dashboardHeader(
  dropdownMenuOutput("task_menu")
)

ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)




## Value Box - Card Visual??

library("shiny")
sidebar <- dashboardSidebar(
  actionButton("click", "Update click box")
) 

server <- function(input, output) {
  output$click_box <- renderValueBox({
    valueBox(
      value = input$click,
      subtitle = "Click Box"
    )
  })
}

body <- dashboardBody(
  valueBoxOutput("click_box")
)


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)

