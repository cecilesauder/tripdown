
#' new_travel_blog
#'
#' Create a new travel blog
#'
#' @import fs
#' @import purrr
#' @import magrittr
#'
#' @param path target directory where to put the new blog
#' @param title blog title
#' @param author blog author
#' @param baseurl blog url
#'

new_travel_blog <-function(path, baseurl, title, author){
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # generate header for file
  contents <- paste(
    "metaDataFormat: yaml",
    paste0("baseurl: ", baseurl),
    paste0("title: ", title),
    "theme: well-traveled",
    'languageCode: "en-us"',
    paste0('authors: "', author, '"'),
    paste0("copyright: '", author, "'"),
    "params:",
    "  logo: img/compass-rose.svg",
    "favicon:",
    "  image: favicon.png",
    "  type: image/png",
    "description: 'Travel blog.'",
    "error404:",
    "  title: Lost a page?",
    paste0("  text: We couldn't find anything under the address you requested. You may want to start from the <a href=", '"/"', ">homepage</a> or go back and try another link."),
    sep = "\n"
  )
  
  # copy the blog structure into the path
  source_directory <- system.file("blog", package = "tripdown")
  dir_copy_to(source_directory, path)
  dir_create(path(path, "content"))

  # write to index file
  writeLines(contents, con = file.path(path, "config.yaml"))




}
