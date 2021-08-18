@user-service @all
Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'

#  To GET response from User Static DATA micro-service and verify response
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
#    And print response
    Then match response == read("ntuc_memberportal/resources/Response/user-serviceProfile.json")

  Scenario Outline: PRODUCT BACKLOG ITEM 417 - Verify user GET method via SCID
    Given path 'user-service/v1/user/scid/<scid>'
    When method Get
    Then status 200
    And match response == read("ntuc_memberportal/resources/Response/user-serviceSCID.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceSCID.csv") |

  Scenario Outline: PRODUCT BACKLOG ITEM 416 - erify user GET method via INCORRECT SCID
    Given path 'user-service/v1/user/scid/<SCID>'
    When method Get
    Then status 400
    * print response
    Then match $.metadata.status == <expected_status>
    And match $.content.errorDescription == <expected_errorDescription>
    And match $.content.errorCode == <expected_errorCode>
    Examples:
      | SCID | expected_status  | expected_errorCode | expected_errorDescription |
      | 1    | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "No matching user found"  |

  #DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method via USERID
    Given path 'user-service/v1/user/<id>'
    When method Delete
    Then status 204
    Then print response
    Then match response == read ("ntuc_memberportal/resources/Response/user-serviceDelete.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceSCID.csv") |

  #DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method with incorrect USERID
    Given path 'user-service/v1/user/<id>'
    When method Delete
    Then status 400
    Then print response.metadata.status == <expected_delete_status>
    Then print response.content.errorDescription == <expected_delete_errorDescription>
    Examples:
      | id  | expected_delete_status | expected_delete_errorDescription |
      | 999 | "BUSINESS_ERROR"       | "Error while deleting user"      |

