@all
@member-service

Feature: NFM Member-Service
  This feature will test HTTP methods for NFM Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method to verify member service for NFM
  Scenario Outline: PRODUCT BACKLOG - 478 GET method to verify membership details
    Given path 'member-service/v1/membership/nfm/main/<scid>'
    When method Get
    Then status 200
#    * def expected = read('')
    Then match response.content.mainMembership == true
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read("") |

    # GET method to verify member service for NFM
  Scenario Outline: PRODUCT BACKLOG - 478 - NEGATIVE Test
    Given path 'member-service/v1/membership/nfm/main/<scid>'
    When method Get
    Then status 401
    Then match response.content.errorDescription == <errorDescription>
    Then match response.content.errorCode == <errorCode>
    Then match response.metadata.status == <status>

    Examples:
      | scid | errorDescription | errorCode          | status  |
      | *&^  | "NOT FOUND"      | "RECORD_NOT_FOUND" | "SUCCESS" |
      | 876  | "NOT FOUND"      | "RECORD_NOT_FOUND" | "SUCCESS" |