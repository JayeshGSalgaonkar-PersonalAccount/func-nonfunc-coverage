@user-service @all
Feature: User service

  Background:
    * url baseURL
    * header Accept = 'application/json'

  Scenario: PRODUCT BACKLOG ITEM 11 - Validate User service for NOTIFICATION
    Given path 'user-service/v1/user/1/preferences/NOTIFICATION'
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"