#' new_travel_blog
#'
#' Create a new travel blog
#' @export
#' @examples
#' new_travel_blog()
new_travel_blog <-function(){
# copy the blog structure into the working directory
  file.copy(from= list.files(system.file("blog", package = "tripdown")), to = getwd(), recursive = TRUE)

}


#' new_trip
#'
#' Create a new trip in the blog
#' @param trip_name short name of the trip (for folders)
#' @param title Title of your trip (for display)
#' @param image header photo location (you'll can find it at content/trip_name/header.jpg)
#' @export
#' @examples
#' new_trip("NYC_2018", "New York 2018")
new_trip <- function(trip_name, title, image){
  if(!file.exists(paste0("content/",trip_name))){
    dir.create(paste0("content/",trip_name))
    dir.create(paste0("static/img/",trip_name))

    file.copy(from = image, to = paste0("img/", trip_name, "/header.jpg"))

    write(
      paste0(
        "---\ntitle: ", title,
        "\nimage: img/", trip_name, "/header.jpg \n---"
      ), file= paste0("content/", trip_name, "/_index.md")
    )

  }else{
    print("a directory with the same date already exists")
  }

}

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
#' new_trip_post("NYC_2018", "Brooklyn Heights")

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
