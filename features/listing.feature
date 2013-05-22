Feature: listing

Scenario: not logged in user calls listing
    Given user not loged in
    When user tries to listing
    Then user should get log in error
    
  
Scenario: logged in user calls listing on root
    Given user is logged in
    When user tries listing on root
    Then user should get listing on root
    
Scenario: logged in user calls listing inside directory
    Given user is logged in 
    When user tries listing inside directory 
    Then user should get listing on selected directory
      