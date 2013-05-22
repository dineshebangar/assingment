

def create_tempfile(filename) # create a tempfile
   
   @file = Tempfile.new(filename)   
   @file.write("hello world")   
 end