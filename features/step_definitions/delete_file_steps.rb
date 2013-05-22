When /^unauthenticated user tries to delete file$/ do
   begin
     @ftp.delete("x")
   rescue Exception => @e
     puts @e
   end
end

When /^user tries to delete file$/ do
  
   begin
     @filename = create_tempfile()
     
     @ftp.put(@file.path,@filename)
     
     @ftp.delete(@filename)
     
   rescue Exception => @e
     puts @e
     
   ensure 
     @file.unlink  
   end
    
end

Then /^user should get success message$/ do
    @ftp.last_response_code.should match("250")
end