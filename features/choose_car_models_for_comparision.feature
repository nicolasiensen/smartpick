Feature: choose car models for comparision
  In order to analyse a comparision
  As a buyer
  I want to choose car models for comparision

  Scenario: when I submit the form wrong
    Given I'm in "the homepage"
    When I submit "the comparison form"
    Then I should see "the comparison form error message"

  @javascript
  Scenario: when choose two cars to compare
    Given I'm in "the homepage"
    And I choose "Ford Fiesta 1.3  3p e 5p" in "the first comparison car field"
    And I choose "GM - Chevrolet Celta 1.4/ Super/ Energy 1.4 8V 85cv 3p" in "the second comparison car field"
    When I submit "the comparison form"
    Then I should not see "the comparison form error message"
    And I should be in "the comparison result page"
