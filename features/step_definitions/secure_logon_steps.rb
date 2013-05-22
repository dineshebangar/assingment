require 'ftpfxp'

Given /^a user tries to connect with secure environment$/ do
  
  @ftp = Net::FTPFXPTLS.new('localhost')
  
 end


