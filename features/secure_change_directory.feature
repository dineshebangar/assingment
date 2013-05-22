Feature: secure_change_directory

Scenario: not logged in user calls change dir with secure environment
    Given user not logged in with secure environment
    When user tries to change directory with secure environment
    Then user should get log in error
    
  
Scenario: logged in user calls change directory with secure environment
    Given user is logged in with secure environment
    When user tries to change directory with secure environment
    Then user should get success response
