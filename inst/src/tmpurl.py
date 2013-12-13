import httplib
import urllib
import urllib2 

keywords= ["farts","poop"]

cmpt="q"
## Search type: Defines 
search_type = ""
# Geo is the country searches are coming from
geo = "UK"
params = urllib.urlencode({
'q': ",".join(keywords),
#'date': date,
'geo': geo,
'gprop': search_type,
'cmpt':cmpt,
'content':'1',
'export':'1'
})

print params
print "http://www.google.com/trends/trendsReport?hl=en-US&" + params      
"http://www.google.com/trends/trendsReport?hl=en-US&cat=0-67-179&geo=JP&q=singapore&cmpt=q&content=1&export=1"
