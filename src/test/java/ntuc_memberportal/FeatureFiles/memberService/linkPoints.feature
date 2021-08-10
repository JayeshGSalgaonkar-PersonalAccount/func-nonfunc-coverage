@membership
Feature: Member-Service

  This feature will test GET method for Linkpoints service to validate results

    # Background will run before every test
  Background:
    * url baseURL
        # baseURL is a global variable declared in karate-config.js file
    * header Accept = 'application/json'

    #GET response
  Scenario: PRODUCT BACKLOG ITEM 5 - Validate GET method for Linkpoints under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    When method Get
    Then status 200
    And print response
    And print responseStatus
    And print responseTime
    And print $.balance == #present
    And print $.dollarValue != #null
    And print $.poolID == #number && #present
    And print $.expiryDate != #null
    And print $.poolName == 'LinkPoints'