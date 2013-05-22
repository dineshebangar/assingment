Feature: secure_listing

Scenario: not logged in user calls listing with secure environment
    Given user not logged in with secure environment
    When user tries to listing with secure environment
    Then user should get log in error
    
  
Scenario: logged in user calls listing on root with secure environment
    Given user is logged in with secure environment
    When user tries listing on root with secure environment
    Then user should get listing on root
    
Scenario: logged in user calls listing inside directory with secure environment
    Given user is logged in with secure environment
    When user tries listing inside directory with secure environment
    Then user should get listing on selected directory with secure environment