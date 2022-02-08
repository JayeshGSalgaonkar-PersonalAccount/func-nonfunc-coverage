@all
@payment-service

Feature: Payment-Service

  Background:
    * url baseURL
    * header Accept = 'application/json'
#    * header x-api-key = 'bm1wSW50ZXJuYWxTZXJ2aWNl'
    * header x-api-key = 'MzI2YjUyNzYtOGY2MS00MjhlLWFjNTAtOGQ1ZjU0YmE2MjI2'
    * header Content-Type = 'application/json'

    Scenario: Payment Create Order
      Given path 'payment-service/v1/payment/create-order'
      * text requestBody =
      """
      {
        "isRecurringPayment": true,
        "isOneTimePayment": true,
        "amount": "1000",
        "serviceType": "SIGN_UP"
      }
      """
      * request requestBody
      When method post
      Then status 200

      * def clientOrderId = response.content.clientOrderId
      * def metadata_status = response.metadata.status
      * def isOneTimePayment = response.content.isOneTimePayment
      * def orderStatus = response.content.orderStatus

# GET method
#  Scenario Outline: PRODUCT BACKLOG ITEM 88 - GET request for CLientOrderID endpoint
    Given path 'payment-service/v1/payment/' + clientOrderId
    * def isOneTimePayment = Boolean(isOneTimePayment)
    When method Get
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/payment-serviceID.json')
    Then match response.metadata.status == metadata_status
    Then match response.content.clientOrderId == clientOrderId
    Then match response.content.isOneTimePayment == isOneTimePayment
    Then match response.content.orderStatus == orderStatus
#    Examples:
#      | read("ntuc_memberportal/resources/TestData_File/payment-serviceId.csv") |
