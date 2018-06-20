dir_copy_to <- function(source, target){
  
  info <- dir_info(source)
  walk2(info$path, as.character(info$type), ~{
    if ( .y == "file" ) file_copy(.x, target)
    if ( .y == "directory" ) dir_copy(.x, target)
  })
  
}