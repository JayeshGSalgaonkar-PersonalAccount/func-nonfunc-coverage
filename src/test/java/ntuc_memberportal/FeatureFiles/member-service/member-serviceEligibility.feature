@member-service @all

Feature: Member-Service (Eligibility)

  This feature will test GET method for Eligibility API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

    #GET response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 5 - Validate GET method for Eligibility under Member-service
    * def data = {NRIC: "<NRIC>",DOB: "<DOB>",BranchCode: "<BranchCode>",Checkclist: "<Checkclist>",ExchangeId: "<ExchangeId>",PaymentArrearMonths: "<PaymentArrearMonths>",PaymentTypeCode: "<PaymentTypeCode>",PaymentTypeName: "<PaymentTypeName>",UnionCode: "<UnionCode>",isnebo: "<isnebo>"}
    Given path 'member-service/v1/membership/check/active/<NRIC>/<DOB>'
    Then status 200
    * print data
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')
#    * print "Data is " + data.DOB + data.NRIC + data.BranchCode + data.ExchangeId + data.PaymentArrearMonths
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/eligibilityGetResponse.csv") |


