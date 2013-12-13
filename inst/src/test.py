from pyGTrends import pyGTrends
#from pyGparse import pyGparse
import httplib
import urllib
import urllib2

#connector = pyGTrends('edmund.m.hart','3dmundh4rt')
#connector.download_report(('jaguar', 'bmw'),)
#print connector.csv(section="Top searches")


def pyGparse(pyGtrendobj):
    #if pyGtrendobj.quota:
    	#raise Exception("Quota reached, please search again later")
    	
    my_lines  = pyGtrendobj.splitlines()
    p_num = ((len(my_lines[0].split(",")) - 1)/2)
    output = [[0 for x in xrange(0)] for x in xrange(p_num + 1)] 
    
    for x in my_lines:
        t_string = x.split(",")
        my_dat = map(lambda i: t_string[i],filter(lambda i: i%2 == 1,range(len(t_string))))
        my_dat.insert(0,t_string[0])
        map(lambda i: output[i].append(my_dat[i]),range(len(my_dat)))
        
    return output


raw_data = open("report-1.csv",'r')
pyGparse(raw_data)
