#' Search google trends (http://trends.google.com)
#' using a python API. 
#'
#'
#' @param keywords A vector of search strings, each term will be a seperate search. Required
#' @param date A vector of dates coded a string in the form YYYY-MM, with the first element being the starting date and the second element the end date.  If you want to return the entire range leave blank.  If you want from a starting date to the last available point, leave the second element in vector as "all", or the first as "all" to search from the beginning until the specified end date
#' @return a data frame with weekly search output and search volmue within the specified date range
#' @import rJython rJava stringr
#' @author Edmund Hart \email{edmund.m.hart@@gmail.com}
#' @export
#' @examples \dontrun{
#' my_search <- rGtrends("Bieber")
#' plot(my_search[,2],my_search[,1],type='l')
#' }
#' 

rGtrends <- function(keywords, date=c("all","all"),src_path = NA){
#require(rJava)
#require(rJython)
#require(stringr)
## Exception handling
if(!is.character(keywords)) stop("Keywords must be strings")
if(length(keywords) > 5) stop("Only 5 keywords can be used in one search")

if(length(date)!=2) stop("Date must be a vector of length 2, see documentation")

####Find the installed path of the package for the python if not specified ###
if(is.na(src_path)){
  libs_path <- installed.packages()
  libs_path <- libs_path[grep("rGtrends",libs_path)[1],2]
  src_path <- paste(libs_path,"/rGtrends/src",sep="")
}


  
pg_path <- paste("'",src_path,"/pyGTrends.py'",sep="")
pyg_src <- paste("pg = imp.load_source('pyGTrends',",pg_path,")",sep="")
  
pgp_path <- paste("'",src_path,"/pyGparse.py'",sep="")
pygp_src <- paste("gp = imp.load_source('pyGparse',",pgp_path,")",sep="")
  
rJython <- rJython()
rJython$exec("import imp")

rJython$exec(pyg_src)
rJython$exec(pygp_src)
  
#' Name and password for rGtrends.  People may not want to send
#' their e-mail credentials unencrypted so I made a dummy email account
#' but I may have to change this at somepoint.  Please don't send e-mails
#' from it :)

rJython$exec("con = pg.pyGTrends('rgtrendsapi','ropensci')")



terms <- paste("(",paste(add_char(keywords),collapse=","),")",sep="")
call <- paste("con.download_report(",terms,")",sep="")
rJython$exec(call)
#### Leaving this code in for when the API is fixed
#if (language){
#  data_call <- paste("data=gp.pyGparse(con.csv(section=",add_char("Language"),"))")
#}

#if (city){
#  data_call <- paste("data=gp.pyGparse(con.csv(section=",add_char("Cities"),"))")
#}

#if (region){
#  data_call <- paste("data=gp.pyGparse(con.csv(section=",add_char("Region"),"))")
#}

#if(sum(c(region,city,language)) == 0){
data_call <- paste("data=gp.pyGparse(con.csv())")
#}

###Extract data into a dataframe


rJython$exec(paste(data_call,"[0]",sep=""))
dat <- rJython$get("data")
dat <- .jstrVal(dat)
dat <- strip_char(dat)
c_names <- vector()
output <- matrix(0,ncol=length(keywords),nrow=length(dat)-1)

my_dates <- format_py_date(dat[2:length(dat)])

  
  for(i in 1:(length(keywords))){
    rJython$exec(paste(data_call,"[",i,"]",sep=""))    
    dat <- rJython$get("data")
    dat <- .jstrVal(dat)
    dat <- strip_char(dat)
    c_names[i] <- dat[1]
    output[,i] <- as.numeric(dat[2:length(dat)])
      
  }
output <- data.frame(output)
output <- cbind(my_dates,output)
colnames(output) <- c("Date",gsub(" ","",keywords))

if(date[1]=="all" && date[2]=="all"){
  return(output)  
 }

if(date[1]=="all" && date[2] != "all"){
  return(output[1:max(grep(date[2],my_dates)),])
}

if(date[1] !="all" && date[2] == "all"){
  return(output[min(grep(date[1],my_dates)):dim(output)[1],])
}

if(date[1]!="all" && date[2] != "all"){
  return(output[min(grep(date[1],my_dates)):max(grep(date[2],my_dates)),])
}

}

