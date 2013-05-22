Given /^I visit page "(.*?)"$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
   
   visit arg1
   fill_in("User Name:", :with => "12345") 
   fill_in("Password:", :with => "12345") 
   click_button 'Ok'

end

Then /^I should see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
  
end