When /^unauthorised user tries to make directory$/ do
   
   begin
     @tempdirname = Guid.new 
  
     @ftp.mkdir(@tempdirname.to_s)
       
   rescue Exception => @e
     puts @e
   end  
   
end

When /^logged in user tries make directory$/ do
   begin
     @tempdirname = Guid.new 
  
     @ftp.mkdir(@tempdirname.to_s)
     
     @ftp.chdir(@tempdirname.to_s)
     
   rescue Exception => @e
     puts @e
   end  
end