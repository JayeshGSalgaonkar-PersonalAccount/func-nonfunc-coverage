
Feature: To validate HTTP POST method

    This feature file will test the POST method used in API calls for employee

    Background:
        * url baseURL
        * header Accept = 'application/json'
        * def expectedResponse = read("response1.json")

    # PLEASE NOTE: the json file should be under same folder or else it will fail


    # Simple POST request with payload body
    Scenario: Post method to create/add new employee
        Given path 'api/users'

        #Declaring response body below for POST request
        And request {"name":"Sujit","job":"Automation"}
        When method Post
        Then status 201
        And print response

    # Assertions in POST method to match the response
    Scenario:
        Given path 'api/users'
        And request {"name":"Ambore","job":"QA"}
        When method Post
        Then status 201
        Then match response == {"name":"Ambore", "job":"QA", "id":"#string","createdAt":"#ignore"}
        Then print response

    # Read (RESPONSE) data from JSON file to match the response, this technique is efficient for large assertion scenarios
    Scenario: To verify results in POST request via JSON file
        Given path 'api/users'
        And request {"name":"Ambore", "job":"QA","id":"#string","createdAt":"#ignore"}
        When method Post
        Then status 201
        Then match response == expectedResponse
        Then print response

    # Read (REQUEST) data from external JSON file
    Scenario: To verify results in POST method request body via JSON file
        Given path 'api/users'
        And def requestBody = read("requestPayload.json")
        And request requestBody
        When method Post
        Then status 201
        Then match response == expectedResponse


    # Read (REQUEST- Payload data) from external .JSON file kept under different folder
    Scenario: Pass POST method request body(payload) via JSON file (kept in another folder)
        Given path 'api/users'
        And def projectPath = karate.properties['user.dir']
        #And print projectPath
        #And def filePath = projectPath+'/src/test/java/examples/data_files/requestPayload.json'
        #And print filePath
        And def requestBody = read("requestPayload.json")
        #And def requestBody = filePath
        And request requestBody
        When method Post
        Then status 201
        Then match $ == expectedResponse



# how to set values in paylod
# Examples outline