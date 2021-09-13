@all
@notification-service

Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonfiles/auth.feature')
    * def dyanicAccessToken = setup.staticToken
#    * def dyanicAccessToken = setup.dyanicAccessToken

#    GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Valid Token)
    Given path 'notification-service/v1/user/notifications'
    And header Authorization = 'Bearer ' + dyanicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/notification-serviceGetProfile.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceProfile.csv") |
