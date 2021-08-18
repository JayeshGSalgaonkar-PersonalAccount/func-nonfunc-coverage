@user-service @all
Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'

    # POST response
  Scenario Outline: PRODUCT BACKLOG ITEM XXX - Validate POST method for user address and details under User-service
    Given path 'user-service/v1/user/aggregate'
    And def requestBody = read("ntuc_memberportal/resources/Request/user-serviceAggregate.json")
    And request requestBody
    When method Post
#    Then status 200
    * print requestBody
    * print read("ntuc_memberportal/resources/Response/user-serviceAggregate.json")
    Then match response == read("ntuc_memberportal/resources/Response/user-serviceAggregate.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceAggregate.csv") |