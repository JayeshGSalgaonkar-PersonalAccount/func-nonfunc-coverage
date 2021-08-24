@all
@user-service

Feature: User service

  Background:
    * url baseURL
    * header Accept = 'application/json'

  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/<user>/preferences/<Pref>'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-servicePreference.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/<user>/preferences'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-servicePreference.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

