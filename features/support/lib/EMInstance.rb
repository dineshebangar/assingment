
 # @cutest = EMInstance.new
       # @cutest.create
class EMInstance
  
  def create
    
    EM::FTPD::App.start('./config.rb')
    
  end
  
end
