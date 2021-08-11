@member-service @all
Feature: Member service

  Background:
    * url baseURL
    * header Accept = 'application/json'

  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Validate member eligibility from NRIC and DOB
    Given path 'member-service/v1/membership/check/active/', nric + "/" +dob
   * print nric + "/" + dob
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"

    Examples:
      | nric | dob      |
      | 999W | 25111990 |
      | WWW1 | 00000000 |

  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Validate member eligibility response content
    Given path 'member-service/v1/membership/check/active/', nric + "/" +dob
   # * print nric + "/" + dob
    When method Get
    Then status 200
    Then print response
    * def expectedContent = {"BranchCode":"GB","Checkclist":true,"ExchangeId":"201800000507","PaymentArrearMonths":0,"PaymentTypeCode":8,"PaymentTypeName":"CREDIT CARD RECURRING","UnionCode":"SMMWU","isnebo":false}
    Then match response.content.BranchCode == expectedContent.BranchCode
    Then match response.content.Checkclist == expectedContent.Checkclist
    Then match response.content.ExchangeId == expectedContent.ExchangeId
    Then match response.content.PaymentArrearMonths == expectedContent.PaymentArrearMonths
    Then match response.content.PaymentTypeCode == expectedContent.PaymentTypeCode
    Then match response.content.PaymentTypeName == expectedContent.PaymentTypeName
    Then match response.content.UnionCode == expectedContent.UnionCode
    Then match response.content.isnebo == expectedContent.isnebo

    Examples:
      | nric | dob      |
      | 999W | 25111990 |
