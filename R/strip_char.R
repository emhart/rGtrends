#' Strips rJava S4 class characters from text vector returned from python
#'
#' @param Js4text vector of rJava S4 class strings 
#' 
#' @return a vector stripped of quotes ond brackets
#' @author Edmund Hart \email{edmund.m.hart@@gmail.com}
#'
strip_char <- function(Js4text){
  
  Js4text <- strsplit(Js4text,",")
  Js4text <- Js4text[[1]]
  Js4text <- sub( "['", "", Js4text, fixed=TRUE)
  Js4text <- sub( "]", "", Js4text, fixed=FALSE )
  Js4text <- sub( "'", "", Js4text, fixed=FALSE )
  Js4text <- sub( " ", "", Js4text, fixed=FALSE )
  Js4text <- sub( " ", "", Js4text, fixed=FALSE )
  Js4text <- sub( "'", "", Js4text, fixed=FALSE )
  return(Js4text)
}