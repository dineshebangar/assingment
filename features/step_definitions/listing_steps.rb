require 'net/ftp'
require 'guid'


When /^user tries to listing$/ do
 # pending # express the regexp above with the code you wish you had
     
    begin
      @ftp.dir
    rescue Exception => @e
      puts @e  
    end
    
 
end

When /^user tries listing on root$/ do
 # pending # express the regexp above with the code you wish you had
    begin
      @ftp.dir("/")
    rescue Exception => @e
       puts @e    
    end 
end

Then /^user should get listing on root$/ do
  # pending # express the regexp above with the code you wish you had
       @ftp.last_response_code.should match("200")
       
       
end

When /^user tries listing inside directory$/ do
    #pending # express the regexp above with the code you wish you had
    begin
     @tempdirname = Guid.new 
  
     @ftp.mkdir(@tempdirname.to_s)
     
     @ftp.chdir(@tempdirname.to_s)
     
     @ftp.dir
   
    rescue Exception => @e
    puts @e
    end  
    
    
end

Then /^user should get listing on selected directory$/ do
   @ftp.last_response_code.should match("200")
   @ftp.rmdir(@tempdirname.to_s)
end




