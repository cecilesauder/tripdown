# https://stackoverflow.com/questions/12135732/how-to-open-working-directory-directly-from-r-console
opendir <- function(dir = getwd()){
  if (.Platform['OS.type'] == "windows"){
    shell.exec(dir)
  } else {
    system(paste(Sys.getenv("R_BROWSER"), dir))
  }
}

#' @import stringr
#' @importFrom glue glue
#' @export
open_gallery <- function(){
  txt <- rstudioapi::getActiveDocumentContext()$contents
  gallery <- str_subset(txt, "^gallery") %>% 
    str_replace("gallery : ", "")
  dir <- glue( "static/{gallery}" )
  
  opendir(dir)
}
