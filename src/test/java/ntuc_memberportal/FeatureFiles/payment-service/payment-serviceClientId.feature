@all
@payment-service

Feature: Payment-Service

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method
  Scenario Outline: PRODUCT BACKLOG ITEM 88 - GET request for CLientOrderID endpoint
    Given path 'payment-service/v1/payment/<clientOrderId>'
    When method Get
    Then print read("ntuc_memberportal/resources/Response/payment-serviceID.json")
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/payment-serviceID.json")

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/payment-serviceId.csv") |
