@all
@user-service

Feature: User service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/<type>'
    * string user = username
    * def deals = Boolean(deals)
    * def news = Boolean(news)
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def marketing = Boolean(marketing)
    When method Get
    Then status 200
    Then match response == read('memberportal/resources/Response/user-servicePreference.json')
    Examples:
      | read("memberportal/resources/TestData_File/user-servicePreference.csv") |

#----------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/'
    * string user = username
    * def deals = Boolean(deals)
    * def marketing = Boolean(marketing)
    * def news = Boolean(news)
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * def expectedResult = read('memberportal/resources/Response/user-servicePref.json')
    Then match response.metadata.status == expectedResult.metadata.status
    Then match response.content[0] == expectedResult.content[0]
    Examples:
      | read('memberportal/resources/TestData_File/user-servicePref.csv') |

#----------------------------------------------------------------------------------------------------------------
#  Patch
  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
    Given path 'user-service/v1/user/preferences/'
    * string user = username
    * def news = Boolean(news)
    * def deals = Boolean(deals)
    * def marketing = Boolean(marketing)
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('memberportal/resources/Request/user-servicePatchPref.json')
    And request requestBody
    When method Patch
    Then status 200
    * def expectedResult = read('memberportal/resources/Response/user-servicePatchPref.json')
    Then match response.metadata.status == expectedResult.metadata.status
    Then match response.content[0].settings.marketing == expectedResult.content[0].settings.marketing
    Then match response.content[0].settings.deals == expectedResult.content[0].settings.deals
    Then match response.content[0].settings.news == expectedResult.content[0].settings.news
    Then match response.content[0].type contains expectedResult.content[0].type
    Examples:
      | read('memberportal/resources/TestData_File/user-servicePatchPref.csv') |
#----------------------------------------------------------------------------------------------------------------
