@all
@member-service

Feature: Member-Service (Payment)
  This feature will test member Payments for Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 244 - Validate POST method for CreateOrder under Member-service
    Given path 'member-service/v1/payment/create-order'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceCreateOrder.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceCreateOrder.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceCreateOrder.csv') |

#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 244 - NEGATIVE Scenario for CreateOrder under Member-service
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
      | "PAY12MONTHS" | "08082000" | "07072000" | "Sign_UP"   | "1000" | true             | true               | 40           | "BAD_REQUEST" | "Caught Validation Error for /payment/create-order" | "VALIDATION_ERROR" |

#  GET
  Scenario: PRODUCT BACKLOG ITEM 88 - Validate GET method for Show-payment-option
    Given path 'member-service/v1/payment/show-payment-option'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceShowPayOptions.json")

#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 88 - Validate GET method for Payment Order-Id
    Given path 'member-service/v1/payment/<orderId>'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-servicePayOrderID.json")

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePayOrderId.csv') |

#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 88 - NEGATIVE Scenario for Payment order-Id
    Given path 'member-service/v1/payment/<orderId>'
    When method Get
    Then status 500
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Then match response.content.errorCode == <errorCode>

    Examples:
      | orderId | status      | errorDescription                                                                         | errorCode       |
      | 5       | "SYS_ERROR" | "Error fetching order by order id 5. Error - Error: Request failed with status code 500" | "UNKNOWN_ERROR" |

#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM - 244 OA membership Sign-up fee
    Given path 'member-service/v1/payment/get-signup-fee/<membershipId>'
    * def amount = parseInt(amount)
    When method Get
    Then status 200
    And match response == read('ntuc_memberportal/resources/Response/member-serviceSignUpFee.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceSignUpFee.csv') |

#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM  - 244 - NEGATIVE test for Sign-up Fee
    Given path 'member-service/v1/payment/get-signup-fee/<membershipId>'
    When method Get
    Then status 500
    Then match response.content.errorCode == <errorCode>
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | membershipId | status      | errorCode          | errorDescription                      |
      | 1            | "SYS_ERROR" | "RECORD_NOT_FOUND" | "Error while retrieving sign up fee." |

#    GET
  Scenario Outline: PRODUCT BACKLOG ITEM - 88 - Membership Renewal fees
    Given path 'member-service/v1/payment/membership-renewal-fees'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceRenewalFee.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceRenewalFee.csv') |