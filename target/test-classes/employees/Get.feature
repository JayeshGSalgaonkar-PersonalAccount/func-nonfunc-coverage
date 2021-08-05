@membership
Feature: Get API demo

    This feature will test various GET calls to validate results

    # Background will run before every test
    Background: 
    * url baseURL
    # baseURL is a global variable declared in karate-config.js file
    * header Accept = 'application/json'

    ## To GET all users on page 2 and print RESPONSE, Status, Time, Header
    Scenario: Get all users from Page 2
    Given path 'users?page=2'
    When method Get
    Then status 200
    And print response
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print responseCookies
    #And print url

    ## To GET response and Match exact string in response [Assertions]
    Scenario: Validate results from Page 2
    Given path 'users'
    And param page = '2'
    When method Get
    Then status 200
    And print response
    And match response.data[0].id == 7
    And match response.data[0].first_name != null
    And match response.data[0].first_name == 'Michael'
    ## response can also be represented as $
    And match $.data[0].last_name contains 'Lawson'
    

    