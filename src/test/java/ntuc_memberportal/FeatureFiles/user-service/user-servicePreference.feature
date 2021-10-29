@all
@user-service

Feature: User service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')


#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<type>'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def marketing = Boolean(marketing)
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/user-servicePreference.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def news = Boolean(news)
    When method Get
    Then status 200
    * print response
    * def expectedResult = read('ntuc_memberportal/resources/Response/user-servicePref.json')
    Then match response.metadata.status == expectedResult.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePref.csv') |

#  Patch
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePatchPref.json')
    And request requestBody
    When method Patch
    Then status 200
    * print response
    * def expectedResult = read('ntuc_memberportal/resources/Response/user-servicePatchPref.json')
    Then match response.metadata.status == "SUCCESS"
#    Then match response.content.settings.marketing == expectedResult.settings.marketing
#    Then match response.content.settings.deals == expectedResult.settings.deals
#    Then match response.content.settings.news == expectedResult.settings.news
#    Then match response.content.settings.type == expectedResult.content.type
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-servicePatchPref.csv') |
