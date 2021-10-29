@ignore
@all
@user-service

Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
#
##  POST response
#  Scenario Outline: PRODUCT BACKLOG ITEM 526 - Validate POST method for user address and details under User-service
#    Given path 'user-service/v1/user/aggregate'
#    * def requestBody = read("ntuc_memberportal/resources/Request/user-serviceAggregate.json")
#    And request requestBody
#    When method Post
#    Then status 200
#    Then match response == read("ntuc_memberportal/resources/Response/user-serviceAggregate.json")
#    Examples:
#      | read("ntuc_memberportal/resources/TestData_File/user-serviceAggregate.csv") |
#
##   POST response
#  Scenario Outline: PRODUCT BACKLOG ITEM 526 - Validate POST method for Open user Aggregate
#    Given path 'user-service/v1/user/open/aggregate'
#    And def requestBody = read("ntuc_memberportal/resources/Request/user-serviceAggregate.json")
#    And request requestBody
#    When method Post
#    Then status 200
#    Then match response == read("ntuc_memberportal/resources/Response/user-serviceAggregate.json")
#    Examples:
#      | read("ntuc_memberportal/resources/TestData_File/user-serviceAggregate.csv") |
#
##  POST response
#  Scenario Outline: PRODUCT BACKLOG ITEM 526 - NEGATIVE TEST
#    Given path 'user-service/v1/user/open/aggregate'
#    And def requestBody = read("ntuc_memberportal/resources/Request/user-serviceAggregate.json")
#    And request requestBody
#    When method Post
#    Then status 400
#    Then match response.metatdata.status == <status>
#    Then match response.content.errorCode == <errorCode>
#    Then match response.content.errorDescription == <errorDescription>
#
#    Examples:
#      | status      | errorCode          | errorDescription                                   |
#      | "SYS_ERROR" | "VALIDATION_ERROR" | "Caught Validation Error for /user/open/aggregate" |