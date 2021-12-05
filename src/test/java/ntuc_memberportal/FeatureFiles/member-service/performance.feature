Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

#---------------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - Membership Details
    Given path 'member-service/v1/membership/details/<nric>/<dob>'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceMemDetailss.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-service_Performance.csv') |

#---------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method for Eligibility under Member-service
    Given path 'member-service/v1/membership/check/active/<nric>/<dob>'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-service_Performance.csv') |


#---------------------------------------------------------------------------------------------------------------------

