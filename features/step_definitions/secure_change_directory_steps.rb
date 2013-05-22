
When /^user tries to change directory with secure environment$/ do
  begin
     @tempdirname = Guid.new 
  
     @ftp.mkdir(@tempdirname.to_s)
     
     @ftp.chdir(@tempdirname.to_s)
    
   
   rescue Exception => @e
     puts @e
   end  
  
end


