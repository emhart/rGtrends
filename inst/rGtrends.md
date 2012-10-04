rGtrends tutorial
========================================================

rGtrends is an R wrapper for making calls to [Google Trends](http://www.google.com/trends) it automatically calls a python api which downloads a temporary CSV.  As of 9/27/2012 google changed it's interface for trends and the python component needs to be retooled for finer parsing.  As it stands now only raw data is downloaded with the ability to sort by date.  But once the python api is fixed individual sections can be downloaded.  

Step 1: Installation
----
Installation can be done one of two ways.  
### Method 1 

The first is via [devtools](http://github.com/hadley/devtools):

1. Download devtools
2. run the following snippet:

```r
require(devtools)
install_github("rGtrends", "emhart")
library(rGtrends)
```


### Methods 2:

1. Download the zipped source from [github](https://github.com/emhart/rGtrends/zipball/master)
2. Install the zip file with your preferred method, from within the R GUI, or the command line

`R CMD INSTALL (unzipped director)`
