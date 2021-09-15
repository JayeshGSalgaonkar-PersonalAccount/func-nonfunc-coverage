@all
@user-service

Feature: User service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dyanicAccessToken = setup.staticToken
#    * def dyanicAccessToken = setup.dyanicAccessToken

#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<type>'
    And header Authorization = 'Bearer ' + dyanicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePreference.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/'
    And header Authorization = 'Bearer ' + dyanicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePref.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePref.csv') |

#  Patch
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/'
    And header Authorization = 'Bearer ' + dyanicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePatchPref.json')
    And request requestBody
    When method Patch
    Then status 200
    * def expectedResult = read('ntuc_memberportal/resources/Response/user-servicePatchPref.json')
    Then match response.content.settings.marketing == expectedResult.settings.marketing
    Then match response.content.settings.deals == expectedResult.settings.deals
    Then match response.content.settings.news == expectedResult.settings.news
    Then match response.content.settings.type == expectedResult.content.type
    Then match response.metatdata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePatchPref.csv') |

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