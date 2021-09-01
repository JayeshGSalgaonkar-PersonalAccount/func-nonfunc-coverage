@all
@member-service

Feature: My-Info Member-Service
  This feature will test HTTP methods for My-Info integration Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method to verify member service for OA
  Scenario Outline: PRODUCT BACKLOG - 244 GET method to verify membership details
    Given path 'member-service/v1/callback'
    When method Get
    Then status 200
    * def expected = read('ntuc_memberportal/resources/Response/member-serviceMyInfo.json')
    Then match response == expected
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceMyInfo.csv") |
