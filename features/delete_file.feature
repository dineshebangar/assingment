Feature: delete_file

Scenario: not logged in user calls delete file
    Given user not loged in
    When unauthenticated user tries to delete file
    Then user should get log in error
    
  
Scenario: logged in user calls delete file
    Given user is logged in
    When user tries to delete file
    Then user should get success message