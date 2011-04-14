Feature: Deleting projects
  In order to remove needless projects
  As a project manager
  I want to make them disappear
  
  Scenario: Deleting a project
    Given there is a project called "TextMate 2"
    And there are the following users:
    | email	| password | admin | unconfirmed |
    | admin@ticketee.com | password | true | false |
    And I am signed in as them
    And I am on the homepage
    When I follow "TextMate 2"
    When I follow "Delete"
    Then I should see "Project has been deleted."