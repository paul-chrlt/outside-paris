library(shiny)

# Define UI
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Outside Paris"),
    
    # Sidebar with sliders input 
    sidebarLayout(
        sidebarPanel(
            sliderInput("population",
                        "Importance of population:",
                        min = -10,
                        max = 10,
                        value = 5
            ),
            sliderInput("distance",
                        "Importance of distance to paris:",
                        min = -10,
                        max = 10,
                        value = 5
            ),
            sliderInput("culture",
                        "Importance of culture:",
                        min = -10,
                        max = 10,
                        value = 5
            ),
            sliderInput("jobs",
                        "Importance of employment:",
                        min = -10,
                        max = 10,
                        value = 5
            )),
            # Show a plot
        mainPanel(
                leafletOutput("distPlot")
            )
        )
    )
)
    