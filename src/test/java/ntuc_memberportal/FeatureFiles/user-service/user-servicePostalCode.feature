@user-service @all
Feature: User service (POSTAL CODE)

  Background:
    * url baseURL
    * header Accept = 'application/json'

    # To GET response from User POSTAL CODE micro-service and verify status
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/{code}'
    And param code = <code>
    * def postalCodeData = {postalCode: "<postalCode>",street: "<street>",block: "<block>",buildingName: "<buildingName>"}
    When method Get
    Then status 200
    Then match response == postalCodeData
    Examples:
      | code   |
      | 345543 |