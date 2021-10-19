@all
@user-service
Feature: User service (POSTAL CODE & )

  Background:
    * url baseURL
    * header Accept = 'application/json'

#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/<postalCode>'
    * def id = parseInt(id)
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-servicePostalCode.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-servicePostalCode.csv") |

#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM XXX - Company Search
    Given path 'user-service/v1/company/search'
    * def search =
    """
    {q: '#(name)'}
    """
    And params search
    When method Get
    Then status 200
    * def expected = read("ntuc_memberportal/resources/Response/user-serviceCompanyName.json")
#    Then match response.metadata.status === expected.metadata.status
    Then match response contains any expected
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceCompanyName.csv') |

#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 766 - Search Company name for OA Sign up
    Given path '/user-service/v1/company/ucem-upsert'
    * def requestBody = read("ntuc_memberportal/resources/Request/user-serviceUCEMUPSERT.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content == true

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceUCEMUPCERT.csv') |