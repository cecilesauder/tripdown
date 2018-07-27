#' process_img
#'
#' Scale an image
#'
#' @param file direction for the image to scale
#' 
#' @import magick
#' @import assertthat
#' @import progress
#' @import exiv
#' @import dplyr
#' 

process_img <- function(file){
  w <- if (basename(file) == "header.jpg") 1920 else 800
  img <- image_read(file)
  width <- image_info(img)$width
  if(width > w){
    image_scale(img, w) %>%
      image_write(path = file, format = "jpg")
    TRUE
  } else {
    FALSE
  }
}

#' redim_all
#'
#' Scale all blog photos
#'
#' @param files optional direction for photos, if not given, all the photos in "static/img" are used
#'
#' @export
#' @examples
#' redim_all()
redim_all <- function(files){
  if( missing(files) ){
    files <- list.files( "static/img", full.names = TRUE, recursive = TRUE, pattern = "(JPG|jpg)$")
  }
  message( "redimensionnement")
  p <- progress_bar$new(total = length(files))
  vect_modif <- map_lgl(files, ~{
    on.exit(p$tick())
    process_img(.x)
  })
  n_modif <- sum(vect_modif)
  n_total <- length(vect_modif)
  cat("\n")
  message(glue("J'ai modifié {n_modif} fichiers sur {n_total}"))
}

#' orient_all
#'
#' Orient all blog photos
#'
#' @param files optional direction for photos, if not given, all the photos in "static/img" are used
#'
#' @export
#' @examples
#' orient_all()
orient_all <- function( files ){
  if( missing(files) ){
    files <- list.files( "static/img", full.names = TRUE, recursive = TRUE, pattern = "jpg$")
  }
  message( "reorientation")
  pb <- progress_bar$new(total = length(files))
  orientations <- map_int( files, ~{
    or <- read_exif(.x) %>% 
      filter( exif_key == "Exif.Image.Orientation") %>% 
      pull(exif_val) %>% 
      as.integer()
    pb$tick()
    if( length(or) ) or else 0L
  })
  files <- files[ orientations > 1]
  
  pb <- progress_bar$new(total = length(files))
  walk( files, ~{
    image_read(.x) %>% 
      image_orient() %>% 
      image_write(path = .x)
    pb$tick()
  })
  
  message(glue("J'ai réorienté {length(files)} fichiers"))
  
}

#' clean_all
#'
#' Scale and orient all blog photos
#'
#' @param files optional direction for photos, if not given, all the photos in "static/img" are used
#'
#' @export
#' @examples
#' clean_all()
clean_all <- function( files ){
  redim_all(files)
  orient_all(files)
}
