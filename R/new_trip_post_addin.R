#' new_trip_post_addin
#'
#' Addin to create a new trip in the blog
#' @import shiny
#' @import miniUI
#' 
#' 
#' @export
#' 
new_trip_post_addin <- function() {
  list_trip <- path_file( dir_ls("content/", type = "directory") )
  ui <- miniPage(
    gadgetTitleBar("New Post"),
    miniContentPanel(
      splitLayout(
        selectInput("trip_name", label = "Select a trip :", choices = list_trip), 
        textInput("title", label = "Post Title", value = "")
      ),
      splitLayout(
        textInput("date", label = "Date", value = Sys.Date()),
        textInput("author", label = "Author", value = ""), 
        selectizeInput("tags", label = "Tags", multiple = TRUE, choices = NULL, options = list(create = TRUE))
      ),
      fileInput("header", label = "Post Header Image", buttonLabel = "Select image..."),
      textInput("map", label = "Location", placeholder = "Where ?"),
      textOutput("problems")
      
    )
  )
  
  server <- function(input, output, session) {
    
    ok <- reactive({
      input$title != "" && input$author != ""
    })
    
    observe({
      shinyjs::toggle("done", ok())
    })
    
    output$problems <- renderText({
      msg <- ""
      
      if(input$title  == "") msg <- paste(msg, "NEED TITLE. ")
      if(input$author == "") msg <- paste(msg, "NEED AUTHOR. ")
      
      msg
    })
    
    # Listen for 'done' events. 
    observeEvent(input$done, {
      validate(
        need(input$title, ""), 
        need(input$author, "")
      )
      
      image <- input$header
      tags <- input$tags
      new_trip_post(trip_name = input$trip_name, 
                    date = input$date, 
                    title = input$title,
                    author = input$author, 
                    tags = tags,
                    header = image$datapath,
                    place = input$map)

      stopApp()
    })
    
  }
  
  # We'll use a pane viwer, and set the minimum height at
  # 300px to ensure we get enough screen space to display the clock.
  viewer <- dialogViewer("New Post", 500, 400)
  runGadget(ui, server, viewer = viewer)
  
}