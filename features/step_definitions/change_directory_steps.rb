Given /^user not loged in$/ do

 
 @ftp = Net::FTP.new('localhost')
    
end

When /^user tries to change directory$/ do
 
  begin
  
    @tempdirname = Guid.new 
    
    @ftp.chdir(@tempdirname.to_s)
    
  rescue Exception => @e
    puts @e
  end
    
end

Then /^user should get log in error$/ do
  
   @e.message.should match(/530.+/) 
end

Given /^user is logged in$/ do

   begin
     
     @ftp = Net::FTP.new('localhost')
     @ftp.login('12345','12345')
      
   rescue Exception => @e
     puts @e
   end
     
   
end

When /^user tries change directory$/ do
   begin
     @tempdirname = Guid.new 
  
     @ftp.mkdir(@tempdirname.to_s)
     
     @ftp.chdir(@tempdirname.to_s)
    
   
   rescue Exception => @e
     puts @e
   end  
  
end

Then /^user should get success response$/ do
    
    @ftp.last_response_code.should match("257")
    @ftp.rmdir(@tempdirname.to_s)
end

