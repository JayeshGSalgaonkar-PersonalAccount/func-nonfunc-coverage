
# PUT is used to UPDATE the values in the source
# PATCH is used to alter some values in the source

Feature: Validate PUT request

    Feature Description

    Background: PUT response
    
    * url baseURL
    # baseURL is a global variable declared in karate-config.js file

    Scenario: PUT response
    Given path 'users/2'
    And request {"name": "morpheus", "job": "zion residentsss"}
    When method Put
    Then status 200
    Then print response
