##-------------------------------------------------------------###
##
## Course: Shinydashboards 
##
## Chapter 1 - Shinydashboards Framework
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


# Best Practice Tip:
# As shown here, it is better to build the header, sidebar and body separately so that they are modular

# Create the UI using the header, sidebar, and body
ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {}

shinyApp(ui, server)



# 2a Lets add some content to the dashboard header

header <- dashboardHeader(
  dropdownMenu(
    type = "messages",
    messageItem(
      from = "Lucy",
      message = "You can view the International Space Station!",
      href = "https://spotthestation.nasa.gov/sightings/"
    ),
    # Add a second messageItem() 
    messageItem(
      from = "Lucy",
      message = "Learn more about the International Space Station",
      href = "https://spotthestation.nasa.gov/faq.cfm"
    )
  )
)

ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)

server <- function(input, output) {}                    
shinyApp(ui, server)


# 2b Create a notification dropdown menu

header <- dashboardHeader(
  # Create a notification drop down menu
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text = "The International Space Station is overhead!"
    )
  )
)

# Use the new header
ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)

shinyApp(ui, server)


# 2c Create a task dropdown menu

header <- dashboardHeader(
  # Create a tasks drop down menu
  dropdownMenu(
    type = "tasks",
    taskItem(
      text = "Mission Learn Shiny Dashboard",
      value = 10
    )
  )
)

# Use the new header
ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)



# 4 Side bar

sidebar <- dashboardSidebar(
  sidebarMenu(
    # Create two `menuItem()`s, "Dashboard" and "Inputs"
    menuItem(text="Dashboard", tabName = "dashboard"),
    menuItem(text="Inputs", tabName = "inputs" )
  )
)

# Use the new sidebar
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = dashboardBody()
)
shinyApp(ui, server)


# 5 Dashboard Body

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard"),
    tabItem(tabName = "inputs")
    # Add two tab items, one with tabName "dashboard" and one with tabName "inputs"
  )
)

# Use the new body
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)

# 6 Add items to body

library("shiny")
body <- dashboardBody(
  # Create a tabBox
  tabItems(
    tabItem(
      tabName = "dashboard",
      tabBox( title = "International Space Station Fun Facts",
              tabPanel("Fun Fact 1"),
              tabPanel("Fun Fact 2")
      )
    ),
    tabItem(tabName = "inputs")
  )
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)
