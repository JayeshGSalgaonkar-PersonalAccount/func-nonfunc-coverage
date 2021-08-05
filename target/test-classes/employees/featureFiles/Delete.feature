
Feature: Validate Delete API

    Feature Description

    Background: 
    * url baseURL
    # baseURL is a global variable declared in karate-config.js file

# Below sceanrio will delete the resource at given path i.e. 2, 204 is usually the status when the resource is not available at the source
    Scenario: Validate Delete API
    Given path 'users/2'
    When method Delete
    Then status 204
    # Printing response to verify whether the resource @2ß has been deleted or not
    Then print response