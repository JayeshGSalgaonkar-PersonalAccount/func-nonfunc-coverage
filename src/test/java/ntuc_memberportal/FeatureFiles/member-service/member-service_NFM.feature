@all
@member-service

Feature: NFM Member-Service
  This feature will test HTTP methods for NFM Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken

#     GET
  Scenario Outline: PRODUCT BACKLOG - 142 - NFM With Auth Token
    Given path 'member-service/v1/membership/nfm/main/'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response.content.mainMembership == <mainMembership>
    Then match response.metadata.status == <status>
    Examples:
      | mainMembership | status    |
      | true           | "SUCCESS" |

#    GET
  Scenario Outline: PRODUCT BACKLOG - 142 - NFM WithOut Auth Token
    Given path 'member-service/v1/membership/nfm/main/'
    When method Get
    Then status 200
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>

    Examples:
      | errorCode         | errorDescription     | status            |
      | "UNAUTHENTICATED" | "No Token provided." | "UNAUTHENTICATED" |

#    GET
  Scenario Outline: PRODUCT BACKLOG - 142 - NEGATIVE Test
    Given path 'member-service/v1/membership/nfm/main/<scid>'
    When method Get
    Then status 404
    Then match response.content.errorDescription == <errorDescription>
    Then match response.content.errorCode == <errorCode>
    Then match response.metadata.status == <status>

    Examples:
      | scid | errorDescription | errorCode          | status    |
      | *&^  | "NOT FOUND"      | "RECORD_NOT_FOUND" | "SUCCESS" |
      | 876  | "NOT FOUND"      | "RECORD_NOT_FOUND" | "SUCCESS" |