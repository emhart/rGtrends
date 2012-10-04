\name{rGtrends}
\alias{rGtrends}
\title{Search google trends (http://trends.google.com)
using a python API.}
\usage{
  rGtrends(keywords, src_path = NA, date = c("all", "all"))
}
\arguments{
  \item{keywords}{A vector of search strings, each term
  will be a seperate search. Required}

  \item{date}{A vector of dates coded a string in the form
  YYYY-MM, with the first element being the starting date
  and the second element the end date.  If you want to
  return the entire range leave blank.  If you want from a
  starting date to the last available point, leave the
  second element in vector as "all", or the first as "all"
  to search from the beginning until the specified end
  date}
}
\value{
  a data frame with weekly search output and search volmue
  within the specified date range
}
\description{
  Search google trends (http://trends.google.com) using a
  python API.
}
\examples{
\dontrun{
my_search <- rGtrends("Bieber")
plot(my_search[,2],my_search[,1],type='l')
}
}
\author{
  Edmund Hart \email{edmund.m.hart@gmail.com}
}

