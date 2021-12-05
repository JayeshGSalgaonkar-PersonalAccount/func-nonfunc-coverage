Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG ITEM 766 - Company Search
    Given path 'user-service/v1/company/search'
    * def search =
    """
    {q: '#(name)'}
    """
    And params search
    When method Get
    Then status 200
    * def expected = read("ntuc_memberportal/resources/Response/user-serviceCompanyName.json")
    Then match response contains any expected
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceCompanyName.csv') |


#------------------------------------------------------------------------------------------------------------
  Scenario Outline: Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/<code>'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read("ntuc_memberportal/resources/Response/user-servicePostalCode.json")
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePostalCode.csv") |

#------------------------------------------------------------------------------------------------------------
#  GET
#  Scenario Outline: Validate User service for Preference
#    Given path 'user-service/v1/user/preferences/<type>'
#    * def news = Boolean(news)
#    * def marketing = Boolean(marketing)
#    * string user = username
#    * def secret = test_secret[user]
#    * def setup = call read('../commonFeatures/auth.feature')
#    * def dynamicAccessToken = setup.dynamicAccessToken
#    And header Authorization = 'Bearer ' + dynamicAccessToken
#    When method Get
#    Then status 200
#    * print response
#    * def expectedResponse = read('ntuc_memberportal/resources/Response/user-servicePreference.json')
#    Then match response.metadata.status == expectedResponse.metadata.status
#    Then match response.content.type == expectedResponse.content.type
#    Then match response.content.settings.news == expectedResponse.content.settings.news
#    Then match response.content.settings.marketing == expectedResponse.content.settings.marketing
#    Examples:
#      | read("ntuc_memberportal/resources/TestData_File/user-servicePreference.csv") |

#------------------------------------------------------------------------------------------------------------
##    GET
#  Scenario Outline: PRODUCT BACKLOG ITEM 11 - Validate User service for Preference
#    Given path 'user-service/v1/user/preferences/'
#    * string user = username
#    * def deals = Boolean(deals)
#    * def marketing = Boolean(marketing)
#    * def news = Boolean(news)
#    * def secret = test_secret[user]
#    * def setup = call read('../commonFeatures/auth.feature')
#    * def dynamicAccessToken = setup.dynamicAccessToken
#    And header Authorization = 'Bearer ' + dynamicAccessToken
#    When method Get
#    Then status 200
#    * def expectedResult = read('ntuc_memberportal/resources/Response/user-servicePref.json')
#    Then match response.metadata.status == expectedResult.metadata.status
##    Then match response.content[0].type == expectedResponse.content[0].type
#    Examples:
#      | read('ntuc_memberportal/resources/TestData_File/user-servicePref.csv') |

#------------------------------------------------------------------------------------------------------------
