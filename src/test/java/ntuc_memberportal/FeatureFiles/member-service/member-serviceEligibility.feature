@all
@member-service

Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL + 'member-service/v1/membership/check/active/'
    * header Accept = 'application/json'

#  GET response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method for Eligibility under Member-service
    Given path '<NRIC>/<DOB>'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibility.csv") |

#  GET response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 372 - Validate GET method for Occupation-Group Eligibility under Member-service
    Given path '<NRIC>/<OCCGroupCode>'
    When method Get
    Then status 200
    * print response
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceOccupationGrp.json')

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceOccupationGrp.csv") |


