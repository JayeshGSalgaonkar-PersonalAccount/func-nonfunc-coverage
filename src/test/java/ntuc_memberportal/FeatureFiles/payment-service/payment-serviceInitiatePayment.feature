@payment-service @all

Feature: Payment-Service
  This feature will test GET/POST HTTP methods for Payment service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - PUT request for member service
    Given path 'payment-service/v1/payment/payId'
    * def paymentID = {"content":{"payId":<payId>,"modifiedDttm":"<modifiedDttm>","createdDttm":"<createdDttm>","errorDescription":"<errorDescription>","errorCode":"<errorCode>","recurringCardType":"<recurringCardType>","recurringPaymentMethod":"<recurringPaymentMethod>","recurringPaymentStatus":"<recurringPaymentStatus>","recurringToken":"<recurringToken>","recurringMerchantId":"<recurringMerchantId>","oneTimeCardType":"<oneTimeCardType>","oneTimePaymentMethod":"<oneTimePaymentMethod>","oneTimePaymentStatus":"<oneTimePaymentStatus>","oneTimeCardExpiryDate":"<oneTimeCardExpiryDate>","oneTimeMerchantId":"<oneTimeMerchantId>","pgOrderId":"<pgOrderId>","orderStatus":"<orderStatus>","paymentType":"<paymentType>","isOneTimePayment":"<isOneTimePayment>","isRecurringPayment":"<isRecurringPayment>","orderAmount":"<orderAmount>","clientOrderId":"<clientOrderId>","id":"<id>"}}
    When method Get
    Then status 200
#    Then print response
    Then match response == paymentID

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/payment-serviceId.csv") |
