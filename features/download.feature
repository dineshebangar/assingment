Feature: download

Scenario: not logged in user calls download
    Given user not loged in
    When user tries to download
    Then user should get log in error
    
  
Scenario: logged in user calls download without params
    Given user is logged in
    When user tries to download without params
    Then user should get error params not present
    
Scenario: logged in user calls download with proper params
    Given user is logged in 
    When user tries to download with params 
    Then user should get download success
    
Scenario: logged in user calls download for invalid file 
     Given user is logged in
     When user tries to download invalid file 
     Then user should get invalid file error
     
     
     
    
    
  
      