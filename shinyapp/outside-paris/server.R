library(shiny)
library(leaflet)
load("cities.Rdata")
# Define server logic
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    francemap <- leaflet() %>%
      addTiles() %>%
      addCircleMarkers(lng = cities$lon, lat = cities$lat, radius = cities$score/2, label = cities$cityLabel)
    francemap
    # # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
