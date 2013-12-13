from pyGTrends import pyGTrends
from pyGparse import pyGparse
import httplib
import urllib
import urllib2

connector = pyGTrends('edmund.m.hart','3dmundh4rt')
connector.download_report(('jaguar', 'bmw'),)

