DEPRECATED
=============

Due to constant changes in the Google trends site, maintaining a package has become untenable.  I'm leaving it up as a guide to how integrate python and R more than anything else.  There's a fully native package called [GTrendsR](https://bitbucket.org/persican/gtrendsr) with native support for the site that currently works.



README 
=========
## Current status ##
Because of changes in Google's implementation of the trends package, the python end of the API needs to be updated.  I am currently in the process of working on this but the package as it stands is broken until I fix the backend Python code.  I'm sorry for any inconvenience.


rGtrends is an interface for a python [Google trends](http://www.google.com/trends) API created by [Sal Uryasev](Sal Uryasev).  It works by downloading a temporary CSV within a python environment, parsing it, sending it to R, and parsing it a bit more into a dataframe.  As of 9/27/2012 Google changed it's interface for Trends and merged it with insight.  At the moment only raw search volume data can be downloaded.  Once the python code is updated I will return the functionality of parsing search results by region and language.

See a full [tutorial here](http://emhart.github.com/rGtrends/)

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
