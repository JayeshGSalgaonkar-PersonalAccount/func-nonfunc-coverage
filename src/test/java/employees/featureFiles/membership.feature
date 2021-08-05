@debug

Feature: Get API demo

    This feature will test various GET calls to validate results

    # Background will run before every test
    Background:
        * url 'https://devma.ntuc.org.sg/api/member-service/v1/api-docs/#/'
        # baseURL is a global variable declared in karate-config.js file
        * header Accept = 'application/json'

    ## To GET all users on page 2 and print RESPONSE, Status, Time, Header
    Scenario: Get all users from Page 2
        Given path 'LinkPoint/GetLinkpointBalance'
        When method Get
        Then status 200
        And print response
        And print responseStatus
        And print responseTime
        And print responseHeaders
        And print responseCookies