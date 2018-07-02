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

new_trip_post <- function(trip_name, title, date = Sys.Date(), author = "me", header, tags, place){
  slug <- paste0(date, "-", stringr::str_replace_all(stringr::str_to_lower(title), "[^[a-zA-Z0-9]]", "-"))
  md_file <- paste0("content/", trip_name, "/", slug, ".rmd")
  if (file.exists(md_file)) {
    stop("a post with the same date and title already exists")
  }
  
  coord <- ggmap::geocode(place)
  print(coord)
  
  var_if_tag <- if(length(tags) > 0){
    paste( "tags : ", paste(paste("\n  - ", tags), collapse = ""))
  }else{""
  }      
  write(
    
    glue::glue(
      '
---
author : {author}
date : {date}
title : {title}
{tags}
gallery : img/{trip_name}/{slug}
---

Cumque pertinacius ut legum gnarus accusatorem flagitaret atque sollemnia, doctus id Caesar libertatemque superbiam ratus tamquam obtrectatorem audacem excarnificari praecepit, qui ita evisceratus ut cruciatibus membra deessent, inplorans caelo iustitiam, torvum renidens fundato pectore mansit inmobilis nec se incusare nec quemquam alium passus et tandem nec confessus nec confutatus cum abiecto consorte poenali est morte multatus. et ducebatur intrepidus temporum iniquitati insultans, imitatus Zenonem illum veterem Stoicum qui ut mentiretur quaedam laceratus diutius, avulsam sedibus linguam suam cum cruento sputamine in oculos interrogantis Cyprii regis inpegit.

Sed ut tum ad senem senex de senectute, sic hoc libro ad amicum amicissimus scripsi de amicitia. Tum est Cato locutus, quo erat nemo fere senior temporibus illis, nemo prudentior; nunc Laelius et sapiens (sic enim est habitus) et amicitiae gloria excellens de amicitia loquetur. Tu velim a me animum parumper avertas, Laelium loqui ipsum putes. C. Fannius et Q. Mucius ad socerum veniunt post mortem Africani; ab his sermo oritur, respondet Laelius, cuius tota disputatio est de amicitia, quam legens te ipse cognosces.

Sin autem ad adulescentiam perduxissent, dirimi tamen interdum contentione vel uxoriae condicionis vel commodi alicuius, quod idem adipisci uterque non posset. Quod si qui longius in amicitia provecti essent, tamen saepe labefactari, si in honoris contentionem incidissent; pestem enim nullam maiorem esse amicitiis quam in plerisque pecuniae cupiditatem, in optimis quibusque honoris certamen et gloriae; ex quo inimicitias maximas saepe inter amicissimos exstitisse.

{map}
      
            ', tags = var_if_tag, map = text_map(coord$lon, coord$lat, place)
    ), file = md_file
  )
  dir.create(paste0("static/img/", trip_name, "/", slug), recursive = TRUE)
  
  file.copy(from = header, to = paste0("static/img/", trip_name,"/", slug, "/header.jpg"))
  
  
  rstudioapi::navigateToFile(md_file)
}
