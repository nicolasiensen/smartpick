Feature: choose car models for comparision
  In order to analyse a comparision
  As a buyer
  I want to choose car models for comparision

  Scenario: when I submit the form wrong
    Given I'm in "the homepage"
    When I submit "the comparison form"
    Then I should see "the comparison form error message"

  Scenario: when I submit the form right
    Given I'm in "the homepage"
    And I fill in "the first comparison field" with "Fiat Uno Mille 1.0 Eletronic 4p"
    When I submit "the comparison form"
    Then I should not see "the comparison form error message"
    And I should be in "the comparison result page"
