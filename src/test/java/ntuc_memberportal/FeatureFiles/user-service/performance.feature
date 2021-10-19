Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken

#    POST response
  Scenario Outline: Validate POST method for user address and details under User-service
    Given path 'user-service/v1/user/aggregate'
    * def requestBody = read("ntuc_memberportal/resources/Request/user-serviceAggregate.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-serviceAggregate.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceAggregate.csv") |

  Scenario Outline: Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/<code>'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-servicePostalCode.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePostalCode.csv") |

  Scenario Outline: Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<type>'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePreference.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-serviceStaticData.json")