@all
@member-service

Feature: NFM Member-Service
  This feature will test HTTP methods for NFM Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#-----------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 142 - NFM With Auth Token
    Given path 'member-service/v1/membership/nfm/main'
    * string user = <username>
    * print user
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response.content.mainMembership == <mainMembership>
    Then match response.metadata.status == <status>
    Examples:
      | mainMembership | status    | username        |
      | false          | "SUCCESS" | "ishsh@hotmail.com" |

#-----------------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - 142 - NFM WithOut Auth Token
    Given path 'member-service/v1/membership/nfm/main'
    When method Get
    Then status 401
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | errorCode         | errorDescription     | status            |
      | "UNAUTHENTICATED" | "Unauthenticated Request."  | "UNAUTHENTICATED" |

  # errorDescription change from "No Token provided." to "Unauthenticated Request."

#-----------------------------------------------------------------------------------------------------------------------