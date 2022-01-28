@all
@member-service

Feature: Member-Service (Payment)
  This feature will test member Payments for Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#--------------------------------------------------------------------------------------------------------------------------------
#  POST API calls needs to be re-validated (SUJIT to take necessary actions)
#  Scenario Outline: PRODUCT BACKLOG ITEM 244 - Validate POST method for CreateOrder under Member-service
#    Given path 'member-service/v1/payment/create-order'
#    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceCreateOrder.json")
#    And request requestBody
#    When method Post
#    Then status 200
#    * print response
#    Then match response == read("ntuc_memberportal/resources/Response/member-serviceCreateOrder.json")
#    Examples:
#      | read('ntuc_memberportal/resources/TestData_File/member-serviceCreateOrder.csv') |
#--------------------------------------------------------------------------------------------------------------------------------

#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 244 - NEGATIVE Tests
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

#------------------------------------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 350 - Validate GET method for Show-payment-option
    Given path 'member-service/v1/payment/show-payment-option'
    * def showPaymentOption = Boolean(~~showPaymentOption)
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceShowPayOptions.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceShowPayOtions.csv') |

#--------------------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 88 - Validate GET method for Payment Order-Id
    Given path 'member-service/v1/payment/<orderId>'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read("ntuc_memberportal/resources/Response/member-servicePayOrderID.json")
    * print expectedResponse
    Then match response.content.payment.serviceType == expectedResponse.content.payment.serviceType
    Then match response.content.payment.recurringMerchantId == expectedResponse.content.payment.recurringMerchantId
    Then match response.content.payment.orderAmount == expectedResponse.content.payment.orderAmount
    Then match response.content.payment.clientOrderId == expectedResponse.content.payment.clientOrderId
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePayOrderId.csv') |

#--------------------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 88 - NEGATIVE Tests
    Given path 'member-service/v1/payment/<orderId>'
    When method Get
    Then status 404
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Then match response.content.errorCode == <errorCode>
    Examples:
      | orderId | status             | errorDescription                                        | errorCode          |
      | 5       | "RECORD_NOT_FOUND" | "Error fetching order by order id 5. Record not found." | "RECORD_NOT_FOUND" |

#--------------------------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG ITEM - 244 OA membership Sign-up fee
    Given path 'member-service/v1/payment/get-signup-fee/<membershipId>'
    * def amount = parseInt(amount)
    * def month = parseInt(month)
    * def feeType = parseInt(feeType)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceSignUpFee.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.amount == expectedResponse.content.amount
    Then match response.content.month == expectedResponse.content.month
    Then match response.content.feeType == expectedResponse.content.feeType
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceSignUpFee.csv') |

#--------------------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM  - 244 - NEGATIVE Test
    Given path 'member-service/v1/payment/get-signup-fee/<membershipId>'
    When method Get
    Then status 400
    Then match response.content.errorCode == <errorCode>
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | membershipId | status        | errorCode          | errorDescription                                          |
      | (*&          | "BAD_REQUEST" | "VALIDATION_ERROR" | "Caught Validation Error for /payment/get-signup-fee/(*&" |

#------------------------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG ITEM - 88 - Membership Renewal fees
    Given path 'member-service/v1/payment/membership-renewal-fees'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceRenewalFee.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceRenewalFee.csv') |

#--------------------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM - 249 - Membership Payment history
    Given path 'member-service/v1/payment/history'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-servicePayHistory.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePayHistory.csv') |

#--------------------------------------------------------------------------------------------------------------------------------

