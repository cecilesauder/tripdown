#' new_trip
#'
#' Create a new trip in the blog
#' @param trip_name short name of the trip (for folders)
#' @param title Title of your trip (for display)
#' @param image header photo location (you'll can find it at content/trip_name/header.jpg)
#' @export
#' @examples
#' \dontrun{ new_trip("NYC_2018", "New York 2018", "/stuff/header.jpg") }
new_trip <- function(trip_name, title, image){
  if(!file.exists(paste0("content/",trip_name))){
    dir.create(paste0("content/",trip_name))
    dir.create(paste0("static/img/",trip_name))

    file.copy(from = image, to = paste0("static/img/", trip_name, "/header.jpg"))

    write(
      paste0(
        "---\ntitle: ", title,
        "\nimage: img/", trip_name, "/header.jpg \n---"
      ), file= paste0("content/", trip_name, "/_index.md")
    )

  }else{
    print("a directory with the same name already exists")
  }

}
