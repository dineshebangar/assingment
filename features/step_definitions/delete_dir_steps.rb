When /^unauthorised user tries to delete directory$/ do
    begin
      @tempdirname = Guid.new 
      @ftp.rmdir(@tempdirname.to_s)
       
    rescue Exception => @e
      puts @e
    end  
  
end

When /^logged in user tries delete directory$/ do
    begin
      @tempdirname = Guid.new 
      @ftp.mkdir(@tempdirname.to_s)
      
      @ftp.rmdir(@tempdirname.to_s)
    
    rescue Exception => @e
      puts @e
    end  
  
end

Then /^user directory should be deleted$/ do
  
     @ftp.last_response_code.should match("257")
  
end