#' Adds quote padding so terms can be searchable with python
#'
#' @param my_string A vector of strings that are padded with quotation marks so they can be passed to python Required
#' 
#' @return a vector of strings padded with quotes
#' @import stringr
#' @author Edmund Hart \email{edmund.m.hart@@gmail.com}
#'
add_char <- function(my_string){
for(i in 1:length(my_string)){
  my_string[i] <- str_pad(my_string[i],str_length(my_string[i])+2,"both",pad="'")
  }
return(my_string)
}
  
  
  
  

  