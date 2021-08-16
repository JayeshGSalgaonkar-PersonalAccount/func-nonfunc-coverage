
@payment-service @all

Feature: Payment-Service
  This feature will test GET/POST HTTP methods for Payment service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - PUT request for member service
    Given path 'payment-service/v1/payment/id'
    And param id = <id>
    When method Get
    Then status 200
#    Then print response
    Then match response == paymentID
    Examples:
      | id |
      | 1  |
