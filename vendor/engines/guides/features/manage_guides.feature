@guides
Feature: Guides
  In order to have guides on my website
  As an administrator
  I want to manage guides

  Background:
    Given I am a logged in refinery user
    And I have no guides

  @guides-list @list
  Scenario: Guides List
   Given I have guides titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of guides
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @guides-valid @valid
  Scenario: Create Valid Guide
    When I go to the list of guides
    And I follow "Add New Guide"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 guide

  @guides-invalid @invalid
  Scenario: Create Invalid Guide (without title)
    When I go to the list of guides
    And I follow "Add New Guide"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 guides

  @guides-edit @edit
  Scenario: Edit Existing Guide
    Given I have guides titled "A title"
    When I go to the list of guides
    And I follow "Edit this guide" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of guides
    And I should not see "A title"

  @guides-duplicate @duplicate
  Scenario: Create Duplicate Guide
    Given I only have guides titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of guides
    And I follow "Add New Guide"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 guides

  @guides-delete @delete
  Scenario: Delete Guide
    Given I only have guides titled UniqueTitleOne
    When I go to the list of guides
    And I follow "Remove this guide forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 guides
 