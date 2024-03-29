Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------
# Create User

  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Create User-Profile (With Token)
    Given path 'user-service/v1/user'

#Ignoring below steps, using hard code value
#    * string user = username
#    * def secret = test_secret[user]
#    * def setup = call read('../commonFeatures/auth.feature')
#    * def dynamicAccessToken = setup.dynamicAccessToken

    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    * def expectedResponse = read('memberportal/resources/Request/user-serviceUser.json')
    And request expectedResponse
    When method Post
    * print response
    Then status 200
    Then match response.content.monthlyGrossSalary == expectedResponse.monthlyGrossSalary
    Then match response.content.name == expectedResponse.name
    Then match response.content.dob == expectedResponse.dob
    Then match response.content.gender == expectedResponse.gender
    Then match response.content.mobileNumber == expectedResponse.mobileNumber
    Then match response.content.email == expectedResponse.email
    Examples:
      | read('memberportal/resources/TestData_File/user-serviceUser.csv') |

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

#------------------------------------------------------------------------------------------------------------
  Scenario Outline: Validate GET method for Postalcode from USER-service
    Given path 'user-service/v1/postal-code/<postalCode>'
    And header karate-name = 'v1/postal-code/postal-code'
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | postalCode |
      | 543269     |

#------------------------------------------------------------------------------------------------------------
#  GET
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
    * def expectedResponse = read("memberportal/resources/Response/user-serviceStaticData.json")
    Then match response.metadata.status == expectedResponse.metadata.status

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 417 - Verify user GET method via SCID
    Given path 'user-service/v1/user/userId/<scid>'
    And header karate-name = 'v1/user/userID/scid'
    * def id = parseInt(id)
    When method Get
    Then status 200
    And print response
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read("memberportal/resources/TestData_File/user-serviceSCID.csv") |
#------------------------------------------------------------------------------------------------------------

#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 766 - Search Company name for OA Sign up
    Given path '/user-service/v1/company/ucem-upsert'
    * def requestBody = read("memberportal/resources/Request/user-serviceUCEMUPSERT.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content == true
    Examples:
      | read('memberportal/resources/TestData_File/user-serviceUCEMUPCERT.csv') |