@user @all

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
    Then response.content.id == 1
    Then response.content.postalCode == "310145"
    Then response.content.street == "Lorong 2 Toa Payoh"
    Then response.content.block == "Blk 145"
    Then response.content.buildingName == "Building"

    # To GET details based on POSTAL CODE - NEGATIVE TESTING ON RESPONSE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - 2
    Given path 'user-service/v1/postal-code/{code}'
    And param code = 310145
    And params {id: <id>, postalCode: <postalCode>, street: <street>, block: <block>, buildingName: <buildingName>}
    When method Get
    Then status 200
    Then response.metadata.status ="SUCCESS"
    And match response == <expected>

    Examples:
      | id | postalCode | street        | block     | buildingName  | expected                                                                                       |
      | 1  | "310145"   | "Casa Blanga" | "Blk 145" | 'Compassvale' | {id: #notnull, postalCode: #notnull, street: #string, block: #notnull, buildingName: #notnull} |
      | 2  | null       | null          | "Blk 147" | '24'          | {id: #notnull, postalCode: #notnull, street: #string, block: #notnull, buildingName: #notnull} |