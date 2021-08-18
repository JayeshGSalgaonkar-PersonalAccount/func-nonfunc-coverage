@member-service @all

Feature: Member-Service (CreateOrder)
  This feature will test POST method for CreateOrder API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

#  POST response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 244 - Validate POST method for CreateOrder under Member-service
    Given path 'member-service/v1/payment/create-order'
#    * def createOrderData = {"content":{endDate: "<endDate>",startDate: "<startDate>",paymentType: "<paymentType>",amount: "<amount>",isOneTimePayment: "<isOneTimePayment>",isRecurringPayment: "<isRecurringPayment>",membershipid: "<membershipid>"}}
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceCreateOrder.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response == requestBody
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceCreateOrder.csv') |
