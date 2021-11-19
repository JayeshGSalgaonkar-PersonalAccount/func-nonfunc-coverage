@all
@member-service

Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

#------------------------------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method for Eligibility under Member-service
    Given path 'member-service/v1/membership/check/active/<NRIC>/<DOB>'
    When method Get
    * def PaymentArrearMonths = parseInt(PaymentArrearMonths)
    * def PaymentTypeCode = parseInt(PaymentTypeCode)
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].PaymentTypeName == expectedResponse.content.PaymentTypeName
    Then match response.content[0].PaymentArrearMonths == expectedResponse.content.PaymentArrearMonths
    Then match response.content[0].PaymentTypeCode == expectedResponse.content.PaymentTypeCode
    Then match response.content[0].UnionCode == expectedResponse.content.UnionCode
    Then match response.content[0].ExchangeId == expectedResponse.content.ExchangeId
    Then match response.content[0].BranchCode == expectedResponse.content.BranchCode
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibility.csv") |

#-----------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - NEGATIVE TEST
    Given path 'member-service/v1/membership/check/active/<NRIC>/<DOB>'
    When method Get
    Then status 500
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | NRIC  | DOB      | status      | errorCode       | errorDescription                          |
      | (*&)W | 13139999 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |

#-----------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 372 - Validate GET method for Occupation-Group Eligibility under Member-service
    Given path 'member-service/v1/membership/check/eligibility/<NRIC>'
    * def Checkelig = Boolean(Checkelig)
    When method Get
    * print response
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibilityNRIC.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].Checkelig == expectedResponse.content[0].Checkelig
    Then match response contains {Checkclist: '##boolean'}
    Then match response contains {Checkblist: '##boolean'}
    Then match response contains {CheckIneligibleJobFlag: '##boolean'}
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibilityNRIC.csv") |