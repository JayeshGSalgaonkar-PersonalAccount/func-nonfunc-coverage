@all
@user-service
Feature: User service (POSTAL CODE & Company search)

  Background:
    * url baseURL
    * header Accept = 'application/json'

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Validate GET method for Postal-Code from USER-service
    Given path 'user-service/v1/postal-code/<postalCode>'
    * def id = parseInt(id)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read("memberportal/resources/Response/user-servicePostalCode.json")
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].buildingName == expectedResponse.content[0].buildingName
    Then match response.content[0].postalCode == expectedResponse.content[0].postalCode
    Then match response.content[0].block == expectedResponse.content[0].block
    Examples:
      | read("memberportal/resources/TestData_File/user-servicePostalCode.csv") |
