@all
@member-service

Feature: Member-Service (Linkpoints-Balance)
  This feature will test GET method for Linkpoint-Balance API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#--------------------------------------------------------------------------------------------------------------
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

#--------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 5 - Validate Datatype in Linkpoints under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    * def user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print "responseStatus is = " + responseStatus
    * print "responseTime is = " + responseTime
    And match $.content.balance == "#string"
    And match $.content.dollarValue == "#string"
    And match $.content.poolId == "#string"
    And match $.content.expiryDate == "#string"
    And match $.content.poolName == "#string"
    Examples:
      | username            |
      | "ishsh@hotmail.com" |

#--------------------------------------------------------------------------------------------------------------
#   GET membership details from UCEM
  Scenario Outline: PRODUCT BACKLOG - 244 Validate Membership DETAILS using NRIC and DOB
    Given path 'member-service/v1/membership/details/<NRIC>/<DOB>'
    * def ArrearsinMonth = parseInt(ArrearsinMonth)
    * def ArrearsAmount = parseInt(ArrearsAmount)
    When method Get
    Then status 200
    * def expected = read('ntuc_memberportal/resources/Response/member-serviceMemDetailss.json')
    Then match response.metadata.status == "SUCCESS"
#    Then match response.content[0].ArrearsinMonth == expected.content[0].ArrearsinMonth
#    Then match response.content[0].BranchName == expected.content[0].BranchName
#    Then match response.content[0].ArrearsAmount == expected.content[0].ArrearsAmount
#    Then match response.content[0].MemberTypeCode == expected.content[0].MemberTypeCode
#    Then match response.content[0].MemberTypeName == expected.content[0].MemberTypeName
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceMemDetails.csv') |

#--------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - NEGATIVE TEST
    Given path 'member-service/v1/membership/details/<NRIC>/<DOB>'
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription  == <errorDescription>

    Examples:
      | NRIC | DOB      | status        | errorCode          | errorDescription   |
      | @#E# | 01011990 | "BAD_REQUEST" | "VALIDATION_ERROR" | "Invalid NRIC/FIN" |