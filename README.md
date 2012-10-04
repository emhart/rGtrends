README 
=========
rGtrends is an interface for a python [Google trends](http://www.google.com/trends) API created by [Sal Uryasev](Sal Uryasev).  It works by downloading a temporary CSV within a python environment, parsing it, sending it to R, and parsing it a bit more into a dataframe.  As of 9/27/2012 Google changed it's interface for Trends and merged it with insight.  At the moment only raw search volume data can be downloaded.  Once the python code is updated I will return the functionality of parsing search results by region and language.

Installation
----
Installation can be done one of two ways.  
### Method 1 

The first is via [devtools](http://github.com/hadley/devtools):

1. Download devtools
2. run the following snippet:

```r
require(devtools) 
install_github("rGtrends","emhart") 
```

### Methods 2:

1. Download the zipped source from [github](https://github.com/emhart/rGtrends/zipball/master)
2. Install the zip file with your preferred method, from within the R GUI, or the command line "`R CMD INSTALL (unzipped directory)`"
