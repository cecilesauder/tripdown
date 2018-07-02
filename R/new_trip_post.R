#' new_trip_post
#'
#' Create a new post for a trip in the blog
#'
#' @param trip_name short name of the trip
#' @param title title of the post
#' @param date date in standard format "2018-04-01" (default = date of the day)
#' @param tags tags
#' @param author author's name (default = "me")
#' @param header image for the post
#' @export
#' @examples
#' \dontrun{ new_trip_post("NYC_2018", "Brooklyn Heights")}

new_trip_post <- function(trip_name, title, date = Sys.Date(), author = "me", header, tags){
  slug <- paste0(date, "-", stringr::str_replace_all(stringr::str_to_lower(title), "[^[a-zA-Z0-9]]", "-"))
  md_file <- paste0("content/", trip_name, "/", slug, ".md")
  if (file.exists(md_file)) {
    stop("a post with the same date and title already exists")
  }
    
  write(
    paste0(
      "---\nauthor : ", author,
      "\ndate : ", date,
      "\ntitle : ", title,
      if(length(tags) > 0){
        paste( "\ntags : ", paste(paste("\n  - ", tags), collapse = ""))
      },
      "\ngallery : img/", trip_name, "/", slug,
      "\n---\n\n"
    ), file = md_file
  )
  dir.create(paste0("static/img/", trip_name, "/", slug), recursive = TRUE)
  
  print(header)
  file.copy(from = header, to = paste0("static/img/", trip_name,"/", slug, "/header.jpg"))
  
  
  rstudioapi::navigateToFile(md_file)
}
