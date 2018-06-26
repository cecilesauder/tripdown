#' new_trip_post
#'
#' Create a new post for a trip in the blog
#'
#' @param trip_name short name of the trip
#' @param title title of the post
#' @param date date in standard format "2018-04-01" (default = date of the day)
#' @param author author's name (default = "me")
#' @export
#' @examples
#' \dontrun{ new_trip_post("NYC_2018", "Brooklyn Heights")}

new_trip_post <- function(trip_name, title, date = Sys.Date(), author = "me"){
  if(!file.exists(paste0("content/", trip_name, "/", date, ".md"))){
    write(
      paste0(
        "---\nauthor : ", author,
        "\ndate : ", date,
        "\ntitle : ", title,
        "\ntags : ",
        "\ngallery : img/",  trip_name, "/", date,
        "\n---"
      ), file= paste0("content/", trip_name, "/", date, ".md")
    )
  }else{
    print("a post with the same date already exists")
  }

  dir.create(paste0("static/img/", trip_name, "/", date))
}