Feature: make_directory

Scenario: not logged in user calls make dir
    Given user not loged in
    When unauthorised user tries to make directory
    Then user should get log in error
    
  
Scenario: logged in user calls make directory
    Given user is logged in
    When logged in user tries make directory
    Then user should get success response
