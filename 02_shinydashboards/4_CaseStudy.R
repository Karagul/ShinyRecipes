
##-------------------------------------------------------------###
##
## Course: Shinydashboards 
##
## Chapter 4: Case Study : Build dashboard to explore fireballs dataset
## Natarajan G
## 30/Dec/2019
##
##-------------------------------------------------------------###

# 0 Load required libraries

library(shinydashboard)
library(shiny)

nasa_fireball <- read.csv("cneos_fireball_data.csv", stringsAsFactors = F)

names(nasa_fireball) <- c("date", "lat", "lon", "alt", "vel", "lat_dir", "lon_dir", "vz", "energy", "impact_e")

# Print the nasa_fireball data frame
print(nasa_fireball)

# Examine the types of variables present
sapply(nasa_fireball, class)

# Observe the number of observations in this data frame
nrow(nasa_fireball)

# Check for missing data
sapply(nasa_fireball, anyNA)

# Add numeric lat and lon columns 
nasa_fireball$lon_n <- as.numeric(gsub("[^0-9.-]", "", nasa_fireball$lon))
nasa_fireball$lat_n <- as.numeric(gsub("[^0-9.-]", "", nasa_fireball$lat))


##  Add a card visual ( valueBox in Shiny )

library("shiny")
max_vel <- max(nasa_fireball$vel, na.rm = T)
max_impact_e <- max(nasa_fireball$impact_e, na.rm = T)
max_energy <- max(nasa_fireball$energy, na.rm = T)

body <- dashboardBody(
  fluidRow(
    
    # Add a value box for maximum energy
    valueBox(
      value = max_energy, 
      subtitle = "Maximum total radiated energy (Joules)",
      icon = icon("lightbulb-o")
    ),
    
    # Add a value box for maximum impact
    valueBox(
      value = max_impact_e,
      subtitle = "Maximum impact energy (kilotons of TNT)",
      icon = icon(name="star")
    ),
    
    # Add a value box for maximum velocity
    valueBox(
      value = max_vel, 
      subtitle = "Maximum pre-impact velocity", 
      icon = icon(name = "fire", lib = "font-awesome"), 
      color = "aqua", 
      width = 4
    )
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)


## RendervalueBox : Dynamic dashboard

n_us <-  sum(
  ifelse(
    nasa_fireball$lat < 64.9 & 
      nasa_fireball$lat > 19.5 & 
      nasa_fireball$lon < -68.0 & 
      nasa_fireball$lon > -161.8,
    1, 0.023
  ), 
  na.rm = TRUE
)

n_color <- if (n_us < 10) {
  "red"
} else {
  "fuchsia"
}  

server <- function(input, output) {
  output$us_box <- renderValueBox(
    valueBox(
      value = n_us,
      subtitle = "Number of Fireballs in the US",
      icon = icon("globe"),
      color = n_color
    )
  )
}

body <- dashboardBody(
  fluidRow(
    valueBoxOutput("us_box")
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)



## Sidebar for Slidebar Input

sidebar <- dashboardSidebar(
  sliderInput(
    inputId = "threshold",
    label = "Color Threshold",
    min = 0,
    max = 100,
    value = 10
  )
)

server <- function(input, output) {
  output$us_box <- renderValueBox({
    valueBox(
      value = n_us,
      subtitle = "Number of Fireballs in the US",
      icon = icon("globe"),
      color = if (n_us < input$threshold) {
        "blue"
      } else {
        "fuchsia"
      }
    )
  })
}


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)



## Add map now from leaflet package


library("leaflet")

server <- function(input, output) {
  output$plot <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      addCircleMarkers(lng = nasa_fireball$lon_n, 
                       lat = nasa_fireball$lat_n,
                       radius = log(nasa_fireball$impact_e),
                       label = nasa_fireball$date,
                       weight = 2
      )
  })
}

body <- dashboardBody( 
  leafletOutput("plot")
)

ui <- dashboardPage(
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = body
)

shinyApp(ui, server)

## Put it all together now

library("leaflet")

server <- function(input, output) {
  output$plot <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  
      addCircleMarkers(
        lng = nasa_fireball$lon_n,
        lat = nasa_fireball$lat_n, 
        radius = log(nasa_fireball$impact_e), 
        label = nasa_fireball$date, 
        weight = 2)
  })
}

body <- dashboardBody(
  fluidRow(
    valueBox(
      value = max_energy, 
      subtitle = "Maximum total radiated energy (Joules)", 
      icon = icon("lightbulb-o")
    ),
    valueBox(
      value = max_impact_e, 
      subtitle = "Maximum impact energy (kilotons of TNT)",
      icon = icon("star")
    ),
    valueBox(
      value = max_vel,
      subtitle = "Maximum pre-impact velocity", 
      icon = icon("fire")
    )
  ),
  fluidRow(
    leafletOutput("plot")
  )
)


ui <- dashboardPage(
  skin = "red",
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = body
)

shinyApp(ui, server)

