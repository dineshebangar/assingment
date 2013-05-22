Feature: change_directory

Scenario: not logged in user calls change dir
    Given user not loged in
    When user tries to change directory
    Then user should get log in error
    
  
Scenario: logged in user calls change directory
    Given user is logged in
    When user tries change directory
    Then user should get success response
