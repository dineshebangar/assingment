When /^user tries to download with secure environment$/ do
 
  begin
     @ftp.get("x")
   rescue Exception => @e
     puts @e
   
   end  
end

When /^user tries to download without params in secure environment$/ do
   begin
     @ftp.get()
   rescue Exception => @e
     puts @e
   end  
end

When /^user tries to download with params with secure environment$/ do
   begin
     @filename = create_tempfile()
     
     @file.write("Hello World")
     
     @size = File.size("/tmp/#{@filename}")
     
     @ftp.put(@file.path,@filename)
     
     @ftp.get("#{@filename},/tmp/#{@filename}")
     
     
     
    rescue Exception => @e
     puts @e
     
   ensure 
       
     @file.unlink  
     
   end
end

When /^user tries to download invalid file with secure environment$/ do
   begin
     @ftp.get("x")
   rescue Exception => @e
     puts @e
   end  
end