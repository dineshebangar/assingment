When /^user tries to upload file with secure environment$/ do
  begin
     @filename = create_tempfile()
     
     @ftp.put(@file.path,@filename)
     
   rescue Exception => @e
     puts @e
     
   ensure 
     @file.unlink  
     remove_file_from_sys(@file.path)
   end
end

When /^user tries to upload without params in secure environment$/ do
 begin     
     
      @ftp.put()
     
    rescue Exception => @e
    
      puts @e     
   
    end
end

When /^user tries to upload with params in secure environment$/ do
  begin
     @filename = create_tempfile()
     
     @ftp.put(@file.path,@filename)
     
   rescue Exception => @e
     puts @e
     
   ensure 
     @file.unlink  
     remove_file_from_sys(@file.path)
   end
end