@tutorials
Feature: Tutorials
  In order to have tutorials on my website
  As an administrator
  I want to manage tutorials

  Background:
    Given I am a logged in refinery user
    And I have no tutorials

  @tutorials-list @list
  Scenario: Tutorials List
   Given I have tutorials titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of tutorials
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @tutorials-valid @valid
  Scenario: Create Valid Tutorial
    When I go to the list of tutorials
    And I follow "Add New Tutorial"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 tutorial

  @tutorials-invalid @invalid
  Scenario: Create Invalid Tutorial (without title)
    When I go to the list of tutorials
    And I follow "Add New Tutorial"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 tutorials

  @tutorials-edit @edit
  Scenario: Edit Existing Tutorial
    Given I have tutorials titled "A title"
    When I go to the list of tutorials
    And I follow "Edit this tutorial" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of tutorials
    And I should not see "A title"

  @tutorials-duplicate @duplicate
  Scenario: Create Duplicate Tutorial
    Given I only have tutorials titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of tutorials
    And I follow "Add New Tutorial"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 tutorials

  @tutorials-delete @delete
  Scenario: Delete Tutorial
    Given I only have tutorials titled UniqueTitleOne
    When I go to the list of tutorials
    And I follow "Remove this tutorial forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 tutorials
 