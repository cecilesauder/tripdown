#' new_trip_post
#'
#' Create a new post for a trip in the blog
#'
#' @param trip_name short name of the trip
#' @param title title of the post
#' @param date date in standard format "2018-04-01" (default = date of the day)
#' @param tags tags
#' @param author author's name (default = "me")
#'
#' @export
#' @examples
#' \dontrun{ new_trip_post("NYC_2018", "Brooklyn Heights")}
new_trip_post <- function(trip_name, title, date = Sys.Date(), author = "me", tags){
  md_file <- paste0("content/", trip_name, "/", date, ".md")
  if (!file.exists(md_file)) {
    write(
      paste0(
        "---\nauthor : ", author,
        "\ndate : ", date,
        "\ntitle : ", title,
        if(length(tags) > 0){
          paste( "\ntags : ", paste(paste("\n  - ", tags), collapse = ""))
        },
        "\ngallery : img/",  trip_name, "/", date,
        "\n---\n\n"
      ), file = md_file
    )
  } else {
    print("a post with the same date already exists")
  }

  rstudioapi::navigateToFile(md_file)
  
  dir.create(paste0("static/img/", trip_name, "/", date))
}
