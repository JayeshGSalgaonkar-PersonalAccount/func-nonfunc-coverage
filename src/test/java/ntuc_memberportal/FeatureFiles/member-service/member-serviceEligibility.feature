@all
@member-service

Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL + 'member-service/v1/membership/check/active/'
    * header Accept = 'application/json'

#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method for Eligibility under Member-service
    Given path '<NRIC>/<DOB>'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibility.csv") |

#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - NEGATIVE TEST
    Given path '<NRIC>/<DOB>'
    When method Get
    Then status 500
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | NRIC  | DOB      | status      | errorCode       | errorDescription                          |
      | 899W  | 13139999 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |
      | (*&)W | 13139999 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |
      | &^123 | 13139999 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |

#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 372 - Validate GET method for Occupation-Group Eligibility under Member-service
    Given path '<NRIC>/<OCCGroupCode>'
    When method Get
    Then status 200
    * print response
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceOccupationGrp.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceOccupationGrp.csv") |