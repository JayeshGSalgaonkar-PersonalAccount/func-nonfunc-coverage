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
    * def expectedResponse = {"content":{"expiryDate":"20221231","balance":"100.00","poolId":"P01","dollarValue":"1.00","expiringBalance":"100.00","poolName":"LinkPoints"}}
    When method Get
    Then status 200
#   And print response
    Then match response.content.balance == expectedResponse.content.balance
    Then match response.content.dollarValue == expectedResponse.content.dollarValue
    Then match response.content.poolID == expectedResponse.content.poolID
    Then match response.content.poolName == expectedResponse.content.poolName

  #GET response
  Scenario: PRODUCT BACKLOG ITEM 5 - Validate GET method for Linkpoints under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    When method Get
    Then status 200
    And print responseStatus
    And print responseTime
    And print $.balance == #present
    And print $.dollarValue != #null
    And print $.poolID == #number && #present
    And print $.expiryDate != #null
    And print $.poolName == 'LinkPoints'