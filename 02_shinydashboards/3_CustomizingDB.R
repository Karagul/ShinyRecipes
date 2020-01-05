##-------------------------------------------------------------###
##
## Course: Shinydashboards 
##
## Chapter 3 - Customizing Styles
## Natarajan G
## 29/Dec/2019
##
##-------------------------------------------------------------###

# 0 Load required libraries

library(shinydashboard)
library(shiny)

# Boot Strapping

library("shiny")

body <- dashboardBody(
  fluidRow(
    # Row 1
    box(
      width = 12,
      title = "Regular Box, Row 1",
      "Star Wars"
    )
  ),
  
  fluidRow(
    # Row 2
    box(
      width = 12,
      title = "Regular Box, Row 2",
      "Nothing but Star Wars"
    )
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body)

shinyApp(ui, server)

## 3 - Create rows and columns - Infoboxes

library("shiny")

body <- dashboardBody(
  fluidRow(
    # Column 1
    column(
      width = 6,
      infoBox(
        width = NULL,
        title = "Regular Box, Column 1",
        subtitle = "Gimme those Star Wars"
      )),
    # Column 2
    column(
      width = 6,
      infoBox(
        width = NULL,
        title = "Regular Box, Column 2",
        subtitle = "Don't let them end"
      ))
  )
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)


## Mixed layouts: Boxes & Info Boxes

library("shiny")

body <- dashboardBody(
  fluidRow(
    # Row 1
    box(
      width = 12,
      title = "Regular Box, Row 1",
      "Star Wars, nothing but Star Wars"
    )
  ),
  fluidRow(
    # Row 2, Column 1
    column(
      width = 6,
      infoBox(
        width = NULL,
        title = "Info Box, Row 2, Column 1",
        subtitle = "Gimme those Star Wars"
      )
    ),
    # Row 2, Column 2
    column(
      width = 6,
      infoBox(
        width = NULL,
        title = "Info Box, Row 2, Column 2",
        subtitle = "Don't let them end"
      )
    )
  )
)

ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)


## Add custom formatting to body & skin to UI

library("shiny")

body <- dashboardBody(
  # Update the CSS
  tags$head(
    tags$style(
      HTML('
            h3 { font-weight: bold; }
            ')
    )
  ),
  fluidRow(
    box(
      width = 12,
      title = "Regular Box, Row 1",
      "Star Wars, nothing but Star Wars"
    )
  ),
  fluidRow(
    column(width = 6,
           infoBox(
             width = NULL,
             title = "Regular Box, Row 2, Column 1",
             subtitle = "Gimme those Star Wars"
           )
    ),
    column(width = 6,
           infoBox(
             width = NULL,
             title = "Regular Box, Row 2, Column 2",
             subtitle = "Don't let them end"
           )
    )
  )
)

ui <- dashboardPage(
  skin = "purple",
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = body)
shinyApp(ui, server)

## Add icons from font-awesome library

library("shiny") 

header <- dashboardHeader(
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text = "The International Space Station is overhead!",
      icon(name="rocket", lib="font-awesome")
    )
  )
)
ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)

## 

library("shiny")

body <- dashboardBody(
  tags$head(
    tags$style(
      HTML('
      h3 {
        font-weight: bold;
      }
      ')
    )
  ),
  fluidRow(
    box(
      width = 12,
      title = "Regular Box, Row 1",
      "Star Wars, nothing but Star Wars",
      # Make the box red
      status = "danger"
    )
  ),
  fluidRow(
    column(width = 6,
           infoBox(
             width = NULL,
             title = "Regular Box, Row 2, Column 1",
             subtitle = "Gimme those Star Wars",
             # Add a star icon
             icon = icon(name = "star", lib = "font-awesome")
           )
    ),
    column(width = 6,
           infoBox(
             width = NULL,
             title = "Regular Box, Row 2, Column 2",
             subtitle = "Don't let them end",
             # Make the box yellow
             color = "yellow"
           )
    )
  )
)

ui <- dashboardPage(
  skin = "purple",
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = body)
shinyApp(ui, server)

