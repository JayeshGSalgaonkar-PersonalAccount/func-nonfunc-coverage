Feature: Payment-Service
  This feature will test GET/POST HTTP methods for Payment service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method
  Scenario Outline: PRODUCT BACKLOG ITEM 88 - GET request for CLientOrderID endpoint
    Given path 'payment-service/v1/payment/<clientOrderId>'
    * def isOneTimePayment = Boolean(isOneTimePayment)
    When method Get
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/payment-serviceID.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.clientOrderId == expectedResponse.content.clientOrderId
    Then match response.content.isOneTimePayment == expectedResponse.content.isOneTimePayment
    Then match response.content.orderStatus == expectedResponse.content.orderStatus
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/payment-serviceId.csv") |
