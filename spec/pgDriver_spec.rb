require 'tempfile'
require 'spec_helper'
require 'guid'


 describe EM::FTPD::Server, "initial" do

  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

  it "should default to a root name" do
    @test.name_prefix.should eql("/")
  end

  context "connection is opened" do
   
    it "should respond with 220 when connection is opened" do
      @test.sent_data.should match(/^220/)  # 220 response when connection is opened
    end
  end
end

 describe EM::FTPD::Server, "Authorisation" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
  
  context "with authorised access" do
     
       it "should respond with 230 " do
        @test.receive_line("USER 12345")
        @test.reset_sent!
        @test.receive_line("PASS 12345")
        @test.sent_data.should match(/230.+/)  # 230 response on success
       end
      
  end
  
  context "with unauthorised access as missing password" do
  
    it "should respond with 553 " do
      
      @test.receive_line("USER 12345")
      @test.reset_sent!
      @test.receive_line("PASS")
      @test.sent_data.should match(/553.+/)  # 553 response on params not present
    end
  
  end
  
  context "with unauthorised access as no params" do
    it "should respond with 553 " do
      @test.receive_line("USER")
      @test.reset_sent!
      @test.receive_line("PASS")
      @test.sent_data.should match(/553.+/)  # 553 response on params not present
    end
  end
   
end

 describe EM::FTPD::Server, "Make dir" do
   before(:each) do
     @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
   end

   context "Unauthorised user calls make_dir" do
    it "should respond with 530 " do
     @test.reset_sent!
     @test.receive_line("MKD x")
     @test.sent_data.should match(/530.*/) # 530 response on unauthorised access
    end
   end
  
   context "Logged in user calls Make dir" do
   
    it "should respond with 257 when the directory is created and show listing" do
   
     @tempdirname = Guid.new    
     log_in()       
   
     @test.receive_line("MKD #{@tempdirname}")    
   
     @test.sent_data.should match(/257.+/)  # 257 response on Directory created
    
     @test.receive_line("CWD #{@tempdirname}")  
    
     @test.sent_data.should match(/250.+/)   # 250 response on change directory success
    
     @test.name_prefix.should match("#{@tempdirname}")
    
     @test.receive_line("PASV")
     @test.reset_sent!
     @test.receive_line("LIST") 
    
     @test.sent_data.should match(/150.+226.+/m)  # 150 and 226 response on list action success
      
     remove_dir_from_remote(@tempdirname) #call to remove created dir
    end
   end
 
  end

 describe EM::FTPD::Server, "Dir LIST" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
     

  context "Unauthorised user calls DIR" do
  
    it "should respond with 530 " do
     @test.reset_sent!
     @test.receive_line("LIST")
     @test.sent_data.should match(/530.+/)  # 530 response on unauthorised access
    end
  end

  context "Logged in user calls dir" do
      
   it "should respond with 150 ...425  when called with no data socket" do
     
     log_in()
     @test.receive_line("LIST")
     @test.sent_data.should match(/150.+425.+/m)  # 150  and 425 response on list action with no data socket 
   end

   it "should respond with 150 ... 226 when called in the root dir with no param" do
   
     log_in_pasv()
     @test.reset_sent!
     @test.receive_line("LIST")
     @test.name_prefix.should match("/")
     @test.sent_data.should match(/150.+226.+/m)  # 150 and 226 response on successful list action 
   
   end

   it "should respond with 150 ... 226 when called inside directory " do
   
    @tempdirname = Guid.new 
    
    log_in()
    
    @test.receive_line("MKD #{@tempdirname}")    
    
    @test.sent_data.should match(/257.+/)  # 257 response on directory created
    
    @test.receive_line("CWD #{@tempdirname}")
    
    @test.sent_data.should match(/250.+/) # 250 response on change directory success
    
    @test.receive_line("PASV")
    @test.reset_sent!
    @test.receive_line("LIST")
    @test.sent_data.should match(/150.+226.+/m)  # 150 and 226 response on list action success
    
    remove_dir_from_remote(@tempdirname) # Call to remove test directory from remote 
    
   end
  
  end
  
 end

 describe EM::FTPD::Server, "Change_dir" do
 
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

  
  context "not logged in user" do
  
   it "should respond with 530" do
  
    @test.reset_sent!
    @test.receive_line("CWD")
    @test.sent_data.should match(/530.*/)  # 530 response on unauthorised access
  
   end
  
  end
  
  context "Logged in and calls change dir " do
   
   it "should respond with 250 if called with dir name " do
  
     @tempdirname = Guid.new    
    
     log_in()       
   
     @test.receive_line("MKD #{@tempdirname}")    
   
     @test.sent_data.should match(/257.+/)  # 257 response on directory created
    
     @test.receive_line("CWD #{@tempdirname}")  
    
     @test.sent_data.should match(/250.+/)  # 250 response on change directory success
    
     @test.name_prefix.should match("#{@tempdirname}")
    
     remove_dir_from_remote(@tempdirname)  # called to remove test directory from remote  
  
   end
   
  end

 end

 describe EM::FTPD::Server, "Remove Dir" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
  
  context "Unauthorised user calls remove_dir" do
  
   it "should respond with 530 for failure" do
  
    @test.reset_sent!
    @test.receive_line("RMD x")
    @test.sent_data.should match(/530.*/)  # 530 response on unauthorised access
  
   end
  end
 
 context "Logged in user calls delete dir" do
   it "should respond with 250 if success " do
    
     @tempdirname = Guid.new    
     log_in()       
   
     @test.receive_line("MKD #{@tempdirname}")    
    
     @test.sent_data.should match(/257.+/)  # 257 response on directory created
     
     @test.receive_line("CWD #{@tempdirname}")  
    
     @test.sent_data.should match(/250.+/)   # 250 response on action success
       
     @test.receive_line("RMD #{@tempdirname}")
     @test.sent_data.should match(/250.+/)   # 250 response on action success
     
     @test.reset_sent!
     
     @test.receive_line("CWD #{@tempdirname}")  
    
     @test.sent_data.should match(/550.+/)    # 550 response on action failure 
  end
 end

  
 end
 
 describe EM::FTPD::Server, "Put Files" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

    context "Unauthorised user calls Put files" do
    
    it "should respond with 530 " do
      @test.reset_sent!
      @test.receive_line("stor")
      @test.sent_data.should match(/530.+/)  # 530 response on unauthorised access
    end
 
  end
 
  context "Logged in user calls PUT File" do
      
   it "should respond with 150 ...553 when called with no data socket" do
     log_in()
     @test.receive_line("STOR")
     @test.sent_data.should match(/553.+/)  # 553 response on no datasocket present
   end

 
   it "should respond with 150 ... 226 when called in the put files " do
     
     @filename = create_tempfile()
     log_in_pasv()
     @test.receive_line("STOR #{@filename} /tmp/#{@filename}")
     @test.sent_data.should match(/150.+200.+/m)  # 150 and 200 response on 
     remove_file_from_remote(@filename)   # call to remove test file from remote
     remove_file_from_sys(@filename) # call to delete test file from tmp directory in system
   
   end  
   
  end 

end

 describe EM::FTPD::Server, "Delete Files" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

  context "Called by Not Logged in user" do
  
   it "should respond with 530 " do
     @test.reset_sent!
     @test.receive_line("DELE x")
     @test.sent_data.should match(/530.*/)  # 530 response on unauthorised access
   end
  
  end

  context "Logged in user calls delete file" do
  
   it "should respond with 553 when the no paramater " do
     log_in()
     @test.reset_sent!
     @test.receive_line("DELE")
     @test.sent_data.should match(/553.+/)  # 553 response on no params present
   end
   
   it "should respond with 250 when the file is deleted" do
  
     @filename = put_files_in_remote() # create file on remote
     log_in()
     @test.reset_sent!
     @test.receive_line("RETR #{@filename}")  # checks if file present on remote
     @test.sent_data.should match(/150.+226.+/m) # 150 and 226 response on data transfer success
     @test.receive_line("DELE #{@filename}")
     @test.sent_data.should match(/250.+/)
  
   end
  
  end
 end

 describe EM::FTPD::Server, "Get Files" do
 
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
  
 context "Called by not logged in user" do
   
   it "should always respond with 530 " do
 
    @test.reset_sent!
    @test.receive_line("RETR x")
    @test.sent_data.should match(/530.+/) # 530 response when unauthorised access
 
   end
 
 end

  context "Logged in user calls get files" do
  
   it "should respond with 553 when called with no param" do
 
     log_in()
     @test.receive_line("RETR")
     @test.sent_data.should match(/553.+/) # 553 response on params not present
 
   end

  
  
    it "should always respond with 150..226 when called with valid file" do
      
      @filename = put_files_in_remote()
      log_in_pasv()
      @test.receive_line("RETR #{@filename}")
      @test.sent_data.should match(/150.+226.+/m) # 150 and 226 response on data transfer success
      puts "Data size in get files "+@test.sent_data
      remove_file_from_remote(@filename) # call to remove test file from remote
      remove_file_from_sys(@filename) # call to delete test file from tmp directory
    
    end
  end
 end



private


 def log_in() # login
   
   @test.receive_line("USER 12345")
   @test.receive_line("PASS 12345")
   @test.reset_sent!
   
 end
 
 def log_in_pasv()   # login ion passive mode 
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.receive_line("PASV")
    @test.reset_sent!
 end
  
 def remove_dir_from_remote(name) # remove dir from remote
   
    log_in()
    @test.receive_line("RMD #{name}")
   
 end
  
 def create_tempfile() # create a tempfile
   
   @file = Tempfile.new('random')
     
   name = @file.path
   
   @newfilenam = name.match(/([^\/.]*)$/)
     
   @newfilename = @newfilenam[0]
    
   return @newfilename
     
 end
 
 def remove_file_from_remote(filename) # removes file from remote
    log_in()
    @test.reset_sent!
    @test.receive_line("DELE #{filename}")
    @file.close
    
    @file.unlink
    
 end
 
 def put_files_in_remote() # puts file in remote
    @filename = create_tempfile()
    log_in_pasv()
    @test.receive_line("STOR #{@filename} /tmp/#{@filename}")
    remove_file_from_sys(@filename)
    return @filename
 end

 def remove_file_from_sys(filename) #removes file from system
  if File.exist?("/tmp/#{filename}")
     
     FileUtils.rm("/tmp/#{filename}")
  
   end
  end
