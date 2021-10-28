@all
@deal-service

Feature: Deal-service
  This feature will test HTTP methods for Deals service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'


#   GET
  Scenario Outline: PRODUCT BACKLOG - 15 - View Deal's Details page
    Given path 'deal-service/v1/user/deals'
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response == read('ntuc_memberportal/resources/Response/deal-serviceDealID.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/deal-serviceDeal.csv') |