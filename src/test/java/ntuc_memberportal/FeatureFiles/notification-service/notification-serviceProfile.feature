@all
@notification-service

Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken

#   GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Valid Token)
    Given path 'notification-service/v1/user-notification'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/notification-serviceGetProfile.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceProfile.csv") |

#   GET
  Scenario Outline: PRODUCT BACKLOG - 11 - NEGATIVE TEST (with Valid Token)
    Given path 'notification-service/v1/user/notifications/<scid>'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | scid | status           | errorCode          | errorDescription                        |
      | 765  | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "No matching user found for given scid" |

#     GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Invalid Token)
    Given path 'notification-service/v1/user/notifications'
    And header Authorization = 'Bearer ' + "XCDERFWRONGVALUE"
    When method Get
    Then status 401
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | status            | errorCode         | errorDescription    |
      | "UNAUTHENTICATED" | "UNAUTHENTICATED" | "JsonWebTokenError" |

#    GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Valid Token)
    Given path 'notification-service/v1/user/notifications/<id>'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/notification-serviceGetNotifID.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceGetNotifID.csv') |

#   GET
  Scenario Outline: PRODUCT BACKLOG - 11 - NEGATIVE TEST (with Valid Token)
    Given path 'notification-service/v1/user/notifications/<id>'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | id | status           | errorCode          | errorDescription                        |
      | 12 | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "No matching user found for given scid" |