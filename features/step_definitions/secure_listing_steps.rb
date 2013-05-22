require 'guid'

Given /^user not logged in with secure environment$/ do
  @ftp = Net::FTPFXPTLS.new('localhost')
end

When /^user tries to listing with secure environment$/ do
  begin
      @ftp.dir
    rescue Exception => @e
      puts @e  
    end
end

Given /^user is logged in with secure environment$/ do
   begin
      
      @ftp.login('12345','12345')
      
    rescue Exception => @e
      puts @e
    end
end

When /^user tries listing on root with secure environment$/ do
 begin
      @ftp.dir
    rescue Exception => @e
      puts @e  
    end
end

When /^user tries listing inside directory with secure environment$/ do
   begin
     @tempdirname = Guid.new 
  
     @ftp.mkdir(@tempdirname.to_s)
     
     @ftp.chdir(@tempdirname.to_s)
     
     @ftp.dir
   
    rescue Exception => @e
    puts @e
    end  
end

Then /^user should get listing on selected directory with secure environment$/ do
   @ftp.last_response_code.should match("200")
   @ftp.rmdir(@tempdirname.to_s)
end

