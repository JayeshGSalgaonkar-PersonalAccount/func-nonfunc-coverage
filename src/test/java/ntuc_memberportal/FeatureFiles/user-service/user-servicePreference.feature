@all
@user-service

Feature: User service

  Background:
    * url baseURL
    * header Accept = 'application/json'

#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<Pref>/<userId>'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePreference.json')

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<userId>'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePref.json')

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePref.csv') |

#    PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<scid>'
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePutPreference.json')
    And request requestBody
    When method Put
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePutPreference.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePutPreference.csv') |

#  PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - NEGATIVE TESTs
    Given path 'user-service/v1/user/preferences/<scid>'
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePutPreference.json')
    And request requestBody
    When method Put
    Then status 404
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePutPreference.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePutPreference.csv') |