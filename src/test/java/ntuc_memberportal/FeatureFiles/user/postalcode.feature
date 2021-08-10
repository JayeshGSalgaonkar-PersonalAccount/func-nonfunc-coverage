@user
Feature: User Micro-service (POSTAL CODE)

  Background:
    * url baseURL
    * header Accept = 'application/json'

    # To GET response from User POSTAL CODE micro-service and verify status
  Scenario: PRODUCT BACKLOG ITEM 416 - 1
    Given path 'user-service/v1/postal-code/{code}'
    And param code = 310145
    When method Get
    Then status 200
    And print response
    Then response.metadata.status ="SUCCESS"
    Then response.content.id =
    Then response.content.id == 1
    Then response.content.postalCode == "310145"
    Then response.content.street == "Lorong 2 Toa Payoh"
    Then response.content.block == "Blk 145"
    Then response.content.buildingName == "Building"