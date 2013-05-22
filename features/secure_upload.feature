Feature: secure_upload

Scenario: not logged in user calls upload with secure environment
    Given user not logged in with secure environment
    When user tries to upload file with secure environment
    Then user should get log in error message
    
      
Scenario: logged in user calls upload without params with secure environment
    Given user is logged in with secure environment
    When user tries to upload without params in secure environment
    Then user should get error params not present
    
Scenario: logged in user calls upload with proper params with secure environment
    Given user is logged in with secure environment
    When user tries to upload with params in secure environment
    Then user should get upload success
    

    
    
  