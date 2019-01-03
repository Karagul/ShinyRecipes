library(shinydashboard)

header <- dashboardHeader(
  # Create a notification drop down menu
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text = "The International Space Station is overhead!"
    )
  ),
  
  # Create a message drop down menu  
  dropdownMenu(
    type = "messages",
    messageItem(
      from = "Adhi",
      message = "You can view the International Space Station!",
      href = "https://spotthestation.nasa.gov/sightings/"
    ),
    
    # Add a second messageItem() 
    messageItem(
      from = "Nat",
      message = "Learn more about the International Space Station",
      href = "https://spotthestation.nasa.gov/faq.cfm"
    )
  ),
  
  # Create a tasks drop down menu
  dropdownMenu(
    type = "task",
    taskItem(
      text = "Mission Learn Shiny Dashboard",
      value = 10
    )
  )	
)


sidebar <- dashboardSidebar(
  sidebarMenu(
    # Create two `menuItem()`s, "Dashboard" and "Inputs"
    menuItem(text="Dashboard", tabName = "dashboard"),
    menuItem(text="Inputs", tabName = "inputs" )
  )
  
    # Add a slider
  sliderInput(inputId = "height",
              label = "Height",
              min = 66,
              max = 264,
              value = 264)
)



body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard", "Dashboard here"),
    tabItem(tabName = "inputs", "Input Data here")
    # Add two tab items, one with tabName "dashboard" and one with tabName "inputs"
  )
)



ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)

server <- function(input, output) {}                    

shinyApp(ui, server)
