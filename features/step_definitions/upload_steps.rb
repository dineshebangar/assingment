
Given /^user not logged in$/ do
       
   @ftp = Net::FTP.new('localhost')

end

When /^user tries to upload file$/ do
  
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

Then /^user should get log in error message$/ do
    @e.message.should match(/530.+/)
end

When /^user tries to upload without params$/ do
     begin     
     
      @ftp.put()
     
    rescue Exception => @e
    
      puts @e     
   
    end
    
end

When /^user tries to upload with params$/ do
         
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

Then /^user should get upload success$/ do
     
     @ftp.last_response_code.should match("226")
     @ftp.delete(@filename)
     
end


private

 
 def create_tempfile() # create a tempfile
   
     @file = Tempfile.new('random')
     
     name = @file.path
   
     @newfilenam = name.match(/([^\/.]*)$/)
     
     @newfilename = @newfilenam[0]
    
     return @newfilename
     
 end