Feature: delete_directory

Scenario: not logged in user calls delete dir
    Given user not loged in
    When unauthorised user tries to delete directory
    Then user should get log in error
    
  
Scenario: logged in user calls delete directory
    Given user is logged in
    When logged in user tries delete directory
    Then user directory should be deleted
