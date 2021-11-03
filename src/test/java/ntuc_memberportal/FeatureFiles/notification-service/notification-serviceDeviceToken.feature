@all
@notification-service

Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'


#   Post
  Scenario Outline: PRODUCT BACKLOG - 10 - GET method to verify notification details
    Given path 'notification-service/v1/user-device-token/register-device/open'
    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceDeviceToken.json')
    And request requestBody
    * print requestBody
    When method Post
#    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/notification-serviceDeviceToken.json')
    * print expectedResponse
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceDeviceToken.csv') |

#   Post
  Scenario Outline: PRODUCT BACKLOG - 10 - GET method to verify notification details (With Token)
    Given path 'notification-service/v1/user-device-token/register-device'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceDevice.json')
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceDevice.csv') |