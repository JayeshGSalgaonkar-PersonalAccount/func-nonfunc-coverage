Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken

#   Post
  Scenario Outline: Verify notification details
    Given path 'notification-service/v1/user-device-token/register-device/open'
    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceDeviceToken.json')
    And request requestBody
    When method Post
    Then status 200
    * print response
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceDeviceToken.csv') |

  Scenario Outline: Verify notification details (with Valid Token)
    Given path 'notification-service/v1/user/notifications'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/notification-serviceGetProfile.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceProfile.csv") |

  Scenario Outline: Verify notification details (with Valid Token)
    Given path 'notification-service/v1/user-notification'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/notification-serviceGetProfile.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceProfile.csv") |