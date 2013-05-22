Feature: logon   

Scenario: Unsuccessful login
	Given a user tries to connect 
    When the user log in with invalid information
    Then the user should see an log in error message

Scenario: Successful login
    Given a user tries to connect
    When the user logs in
    Then the user should see an log in success message
    

