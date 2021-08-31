@all
@user-service
Feature: User service (POSTAL CODE)

  Background:
    * url baseURL
    * header Accept = 'application/json'

    # To GET response from User POSTAL CODE micro-service and verify status
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/<postalCode>'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-servicePostalCode.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePostalCode.csv") |
