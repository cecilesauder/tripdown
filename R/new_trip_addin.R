#' new_trip_addin
#'
#' Addin to create a new trip in the blog
#' @import shiny
#' @import miniUI
#' 
#' 
#' @export
#' 
new_trip_addin <- function() {

  ui <- miniPage(
    gadgetTitleBar("New Trip"),
    miniContentPanel(
      textInput("trip_name", label = "Trip Name (for the folder)", value = "NYC2018"),
      textInput("title", label = "Trip Title", value = "New York 2018"),
      fileInput("header", label = "Trip Header Image", buttonLabel = "Select image...")
    )
  )
  
  server <- function(input, output, session) {
    
    
    # Listen for 'done' events. 
    observeEvent(input$done, {
      image <- input$header
      new_trip(trip_name = input$trip_name, 
               title = input$title, 
               image = image$datapath)
      stopApp()
    })
    
  }
  
  # We'll use a pane viwer, and set the minimum height at
  # 300px to ensure we get enough screen space to display the clock.
  viewer <- dialogViewer("New Trip", 500, 400)
  runGadget(ui, server, viewer = viewer)
  
}
