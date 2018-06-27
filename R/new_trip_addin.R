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
  
  # Our ui will be a simple gadget page, which
  # simply displays the time in a 'UI' output.
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("New Trip"),
    miniUI::miniContentPanel(
      shiny::textInput("trip_name", label = "Trip Name (for the folder)", value = "NYC2018"),
      shiny::textInput("title", label = "Trip Title", value = "New York 2018"),
      shiny::fileInput("header", label = "Trip Header Image", buttonLabel = "Select image...")
    )
  )
  
  server <- function(input, output, session) {
    
    
    # Listen for 'done' events. When we're finished, we'll
    # insert the current time, and then stop the gadget.
    shiny::observeEvent(input$done, {
      image <- input$header
      new_trip(trip_name = input$trip_name, 
               title = input$title, 
               image = image$datapath)
      stopApp()
    })
    
  }
  
  # We'll use a pane viwer, and set the minimum height at
  # 300px to ensure we get enough screen space to display the clock.
  viewer <- shiny::paneViewer(300)
  shiny::runGadget(ui, server, viewer = viewer)
  
}
