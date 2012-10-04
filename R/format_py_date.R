#' Formats rJava strings of dates into text that can be converted to POSIX date
#'
#' @param date_vec A vector of dates retured and stripped of characters from rJava
#' @return a vector of POSIX formatted dates
#' @author Edmund Hart \email{edmund.m.hart@@gmail.com}
#'

format_py_date <- function(date_vec){
  date_vec <- gsub('([[:alpha:]])([0-9])',"\\1 \\2",date_vec)
  months <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec") 
  mon_num <- 1:12
  for(i in 1:12){
    date_vec <- gsub(months[i],mon_num[i],date_vec)
  }
date_vec <- gsub(" ","-",date_vec)
return(as.Date(date_vec,format="%m-%d-%Y"))
}