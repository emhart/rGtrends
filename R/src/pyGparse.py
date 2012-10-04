def pyGparse(pyGtrendobj):
    my_lines  = pyGtrendobj.splitlines()
    p_num = ((len(my_lines[0].split(",")) - 1)/2)
    output = [[0 for x in xrange(0)] for x in xrange(p_num + 1)] 
    
    for x in my_lines:
        t_string = x.split(",")
        my_dat = map(lambda i: t_string[i],filter(lambda i: i%2 == 1,range(len(t_string))))
        my_dat.insert(0,t_string[0])
        map(lambda i: output[i].append(my_dat[i]),range(len(my_dat)))
        
    return output