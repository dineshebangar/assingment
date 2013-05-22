Feature: secure_download

Scenario: not logged in user calls download with secure environment
    Given user not logged in with secure environment
    When user tries to download with secure environment
    Then user should get log in error
    
  
Scenario: logged in user calls download without params with secure environment
    Given user is logged in with secure environment
    When user tries to download without params in secure environment
    Then user should get error params not present
    
Scenario: logged in user calls download with proper params with secure environment
    Given user is logged in with secure environment
    When user tries to download with params with secure environment
    Then user should get download success
    
Scenario: logged in user calls download for invalid file with secure environment
     Given user is logged in with secure environment
     When user tries to download invalid file with secure environment
     Then user should get invalid file error
     
     
     
    
    
  
      