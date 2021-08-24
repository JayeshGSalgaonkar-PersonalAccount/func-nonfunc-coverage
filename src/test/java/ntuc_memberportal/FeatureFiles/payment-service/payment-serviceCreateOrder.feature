@all
@payment-service

Feature: Payment-Service
  This feature will test GET/POST HTTP methods for Payment service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# POST method to verify user request is getting created
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - PUT request for member service
    Given path 'payment-service/v1/payment/create-order'
    * def paymentData = {"content":{"modifiedDttm":"<modifiedDttm>","createdDttm":"<createdDttm>","errorDescription":"<errorDescription>","errorCode":"<errorCode>","recurringCardType":"<recurringCardType>","recurringPaymentMethod":"<recurringPaymentMethod>","recurringPaymentStatus":"<recurringPaymentStatus>","recurringToken":"<recurringToken>","recurringMerchantId":"<recurringMerchantId>","oneTimeCardType":"<oneTimeCardType>","oneTimePaymentMethod":"<oneTimePaymentMethod>","oneTimePaymentStatus":"<oneTimePaymentStatus>","oneTimeCardExpiryDate":"<oneTimeCardExpiryDate>","oneTimeMerchantId":"<oneTimeMerchantId>","pgOrderId":"<pgOrderId>","orderStatus":"<orderStatus>","paymentType":"(#paymentType>","isOneTimePayment":"<isOneTimePayment>","isRecurringPayment":"<isRecurringPayment>","orderAmount":"<orderAmount>","clientOrderId":"<clientOrderId>","id":"<id>"}}
    * def requestBody = read("ntuc_memberportal/resources/Request/payment-serviceCreateOrder.json")
    And request requestBody
    When method Post
    Then status 200
    * print response
    Then match response == paymentData
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/payment-serviceCreateOrder.csv') |