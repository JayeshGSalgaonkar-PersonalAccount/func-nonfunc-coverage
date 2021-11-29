Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL + 'member-service/v1/membership/check/active/'
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#   GET
  Scenario Outline: PRODUCT BACKLOG - 244 GET method to verify membership details
    Given path 'member-service/v1/membership'
    * def user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * def expectedResponse = read("ntuc_memberportal/resources/Response/member-serviceMemShip.json")
    * print response.content.membershipTypeCode == expectedResponse.content
    * print response.content.nameOnCard == expectedResponse.content
    * print response.content.status == expectedResponse.content
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceMemShip.csv") |

#------------------------------------------------------------------------------------------------------------------------
  #   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 5 - Validate Linkpoint-Balance under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceLinkpoints.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceLinkpoints.csv") |

#------------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG 527 - Get all membership types the user can apply to.
    Given path 'member-service/v1/membership/memberships-can-apply'
    * string user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response.content.types contains <Type>
    Then match response.metadata.status == <status>
    Examples:
      | Type | status    | username            |
      | "OA" | "SUCCESS" | "ishsh@hotmail.com" |

#------------------------------------------------------------------------------------------------------------------------
#  PUT
  Scenario Outline: PRODUCT BACKLOG 277 - Accept Terms and Condition
    Given path 'member-service/v1/membership/<membershipId>/terms-and-conditions/accept'
    * def membershipId = parseInt(membershipId)
    * def agreed = Boolean(agreed)
    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceTCAccept.json')
    And request requestBody
    When method Put
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceTCAccept.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceTCAccept.csv') |
