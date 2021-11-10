@all
@deal-service

Feature: Deal-service
  This feature will test HTTP methods for Deals service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

#----------------------------------------------------------------------------------------------------
#  NO DATA for DEALID is present.
#  ----------------------------------------------------------------------------------------------------

#   GET
  Scenario Outline: PRODUCT BACKLOG - 15 - View Deal's Details page
    Given path 'deal-service/v1/user/deals/<id>'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/deal-serviceDealID.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/deal-serviceDealID.csv') |

#   GET
  Scenario Outline: PRODUCT BACKLOG - 15 - NEGATIVE TEST
    Given path 'deal-service/v1/user/deals/<invalidId>'
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>

    Examples:
      | invalidId | status           | errorCode          | errorDescription                                |
      | 123       | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "Selected Deal not found."                      |
      | @#$       | "BAD_REQUEST"    | "VALIDATION_ERROR" | "Caught Validation Error for /user/deals/@%23$" |
