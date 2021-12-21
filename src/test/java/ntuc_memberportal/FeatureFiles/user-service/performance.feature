Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG ITEM 766 - Company Search
    Given path 'user-service/v1/company/search'
    * def search =
    """
    {q: <name>}
    """
    And params search
    When method Get
    Then status 200

    Examples:
      | name     |
      | ncs      |
      | tis      |
      | ntuc     |
      | deloitte |
      | gong cha |

#------------------------------------------------------------------------------------------------------------
  Scenario Outline: Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/<postalCode>'
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | postalCode |
      | 543269     |
      | 541259     |
      | 520147     |
      | 570150     |
      | 569933     |
      | 247946     |

#------------------------------------------------------------------------------------------------------------
#  GET
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
    * def expectedResponse = read("ntuc_memberportal/resources/Response/user-serviceStaticData.json")
    Then match response.metadata.status == expectedResponse.metadata.status

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 417 - Verify user GET method via SCID
    Given path 'user-service/v1/user/userId/<scid>'
    * def id = parseInt(id)
    When method Get
    Then status 200
    And print response
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceSCID.csv") |
#------------------------------------------------------------------------------------------------------------

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