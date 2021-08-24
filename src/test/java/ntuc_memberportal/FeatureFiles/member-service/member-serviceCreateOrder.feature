@all
@member-service

Feature: Member-Service (CreateOrder)
  This feature will test POST method for CreateOrder API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

#  POST response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 244 - Validate POST method for CreateOrder under Member-service
    Given path 'member-service/v1/payment/create-order'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceCreateOrder.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceCreateOrder.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceCreateOrder.csv') |

#  POST response and verify data from Response matches data for INVALID scenario
  Scenario Outline: PRODUCT BACKLOG ITEM 244 - Validate POST method for CreateOrder under Member-service for INCORRECT order
    Given path 'member-service/v1/payment/create-order'
    * def requestBody = {"feeType": <feeType>,"endDate": <endDate>,"startDate": <startDate>,"serviceType": <serviceType>, "amount": <amount>, "isOneTimePayment": <isOneTimePayment>,"isRecurringPayment": <isRecurringPayment>,"membershipId": <membershipId>}
    And request requestBody
    When method Post
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Then match response.content.errorCode == <errorCode>
    Examples:
      | feeType       | endDate    | startDate  | serviceType | amount | isOneTimePayment | isRecurringPayment | membershipId | status        | errorDescription                                    | errorCode          |
      | "OUTSTANDING" | "08082000" | "07072000" | "Sign_UP"   | "1000" | true             | true               | 40           | "BAD_REQUEST" | "Caught Validation Error for /payment/create-order" | "VALIDATION_ERROR" |

#  GET response
  Scenario: PRODUCT BACKLOG ITEM 88 - Validate GET method for Show-payment-option
    Given path 'member-service/v1/payment/show-payment-option'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceShowPayOptions.json")
