import httplib
import urllib
import urllib2 
import re
import csv

import cookielib

class pyGTrends(object):
    """
    Google Trends API
    
    Recommended usage:
    
    from csv import DictReader
    r = pyGTrends(username, password)
    r.download_report(('pants', 'skirt'))
    d = DictReader(r.csv().split('\n'))
    """
    def __init__(self, username, password):
        """
        provide login and password to be used to connect to Google Analytics
        all immutable system variables are also defined here
        website_id is the ID of the specific site on google analytics
        """        
        self.login_params = {
            "continue": 'http://www.google.com/trends',
            "PersistentCookie": "yes",
            "Email": username,
            "Passwd": password,
        }
        self.headers = [("Referrer", "https://www.google.com/accounts/ServiceLoginBoxAuth"),
                        ("Content-type", "application/x-www-form-urlencoded"),
                        ('User-Agent', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36'),
                        ("Accept", "text/plain")]
        self.url_ServiceLoginBoxAuth = 'https://accounts.google.com/ServiceLoginBoxAuth'
        self.url_Export = 'http://www.google.com/trends/viz'
        self.url_CookieCheck = 'https://www.google.com/accounts/CheckCookie?chtml=LoginDoneHtml'
        self.header_dictionary = {}
        self._connect()
        self.quota = False
        self.raw_data=[]
        
    def _connect(self):
        """
        connect to Google Trends
        """
        
        self.cj = cookielib.CookieJar()                            
        self.opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(self.cj))
        self.opener.addheaders = self.headers
        
        galx = re.compile('<input name="GALX" type="hidden" value="(?P<galx>[a-zA-Z0-9_-]+)">')

        resp = self.opener.open(self.url_ServiceLoginBoxAuth).read()
        resp = re.sub(r'\s\s+', ' ', resp)

        m = galx.search(resp)
        if not m:
            raise Exception("Cannot parse GALX out of login page test")
        self.login_params['GALX'] = m.group('galx')
        params = urllib.urlencode(self.login_params)
        self.opener.open(self.url_ServiceLoginBoxAuth, params)
        self.opener.open(self.url_CookieCheck)

        for cook in self.cj:
            print cook.name, cook.value 
        
    def download_report(self, keywords,search_type='', geo=''):
        """
        download a specific report
        You can download specific reports by setting search_type to
        images for Images, froogle for products, and news for News
        geo can be any valid 2 character code
        """
        if type(keywords) not in (type([]), type(('tuple',))):
            keywords = [keywords]
        
        
        
        params = {
        'q': ",".join(keywords),
        'cmpt':'q',
        'content':'1',
        'export':'1'
        }

        # add search type and region if need be

        if geo:
            params.update({'geo':geo})
        if search_type:
            params.update({'gprop':search_type}) 

        #encode parameters
        params = urllib.urlencode(params)
        
        self.raw_data = self.opener.open('http://www.google.com/trends/trendsReport?hl=en-US&' + params).read()
        #print http://www.google.com/trends/trendsReport?hl=en-US&' + parameters
        print self.raw_data

        if self.raw_data in ['You must be signed in to export data from Google Trends']:
            raise Exception(self.raw_data)


         #Exception handling for quotas with google insight    
        if "quota" in self.raw_data:
            self.quota = True
            raise Exception("You have reached your quota limit. Please try again later.")
        
    def csv(self, section="main"):
        """
        Returns a CSV of a specific segment of the data.
        Available segments include: Main, Regions, Cities, Top searches, Rising searches
        """
       
        if section == "main":
            section = ("Interest")
        else:
            section = section
         
        segments = self.raw_data.split('\n\n\n')


        for s in segments:
            print s.partition(',')[0], "\n", section in s.partition(',')[0] 
   
            #if  section in s.partition(',')[0]:
                #return s
                    
        #raise Exception("Could not find requested section new ver")

