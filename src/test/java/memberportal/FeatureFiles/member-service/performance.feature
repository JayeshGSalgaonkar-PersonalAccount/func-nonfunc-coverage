Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#---------------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - Membership Details
    Given path 'member-service/v1/membership/details/<nric>/<dob>'
    And header karate-name = 'membership/details/nric/dob'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('memberportal/resources/Response/member-serviceMemDetailss.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('memberportal/resources/TestData_File/member-service_Performance.csv') |

#---------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method for Eligibility under Member-service
    Given path 'member-service/v1/membership/check/active/<nric>/<dob>'
    And header karate-name = 'membership/check/active/nric/dob'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('memberportal/resources/Response/member-serviceEligibility.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('memberportal/resources/TestData_File/member-service_Performance.csv') |
#---------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 372 - Validate GET method for Occupation-Group Eligibility under Member-service
    Given path 'member-service/v1/membership/check/eligibility/<nric>'
    And header karate-name = 'eligibility/nric'
    When method Get
    Then status 200
    * def expectedResponse = read('memberportal/resources/Response/member-serviceEligibilityNRIC.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read("memberportal/resources/TestData_File/member-service_Performance.csv") |
#---------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - 142 GET method to verify membership details
    Given path 'member-service/v1/membership'
    * def user = username
    * def token = authToken
#    * print token
    And header Authorization = 'Bearer ' + token
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read("memberportal/resources/TestData_File/member-serviceMemShip.csv") |

#---------------------------------------------------------------------------------------------------------------------
## GET
#  Scenario Outline: PRODUCT BACKLOG - 527 GET method to verify membership DRAFT details
#    Given path 'member-service/v1/membership/draft'
#    * def user = username
#    * def token = authToken
#    And header Authorization = 'Bearer ' + token
#    When method Get
#    Then status 200
#    * match response.metadata.status == "SUCCESS"
#    Examples:
#      | read('memberportal/resources/TestData_File/member-serviceDraft.csv') |

#---------------------------------------------------------------------------------------------------------------------
#   GET
#  Scenario Outline: PRODUCT BACKLOG - 1215 Validate Membership DETAILS using NRIC and DOB
#    Given path 'member-service/v1/membership/details/<NRIC>/<DOB>'
#    * def ArrearsinMonth = parseInt(ArrearsinMonth)
#    * def ArrearsAmount = parseInt(ArrearsAmount)
#    * def EducationalLevel = parseInt(EducationalLevel)
#    * def MaritalStatus = parseInt(MaritalStatus)
#    When method Get
#    Then status 200
#    * def expected = read('memberportal/resources/Response/member-serviceMemDetailss.json')
#    Then match response.metadata.status == expected.metadata.status
#
#    Examples:
#      | read('memberportal/resources/TestData_File/member-serviceMemDetails.csv') |
#---------------------------------------------------------------------------------------------------------------------
