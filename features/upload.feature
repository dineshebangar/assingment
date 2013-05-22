Feature: upload

Scenario: not logged in user calls upload
    Given user not logged in
    When user tries to upload file
    Then user should get log in error message
    
      
Scenario: logged in user calls upload without params
    Given user is logged in
    When user tries to upload without params
    Then user should get error params not present
    
Scenario: logged in user calls upload with proper params
    Given user is logged in 
    When user tries to upload with params 
    Then user should get upload success
    

    
    
  