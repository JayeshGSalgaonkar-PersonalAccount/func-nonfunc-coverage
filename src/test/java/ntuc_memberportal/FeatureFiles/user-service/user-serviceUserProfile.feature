@all
@user-service

Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#----------------------------------------------------------------------------------------------------------------
#  GET
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
#    * print response
    * def expectedResponse = read("ntuc_memberportal/resources/Response/user-serviceStaticData.json")
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response == expectedResponse

#----------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 417 - Verify user GET method via SCID
    Given path 'user-service/v1/user/userId/<scid>'
    * def id = parseInt(id)
    When method Get
    Then status 200
    And print response
    And match response == read("ntuc_memberportal/resources/Response/user-serviceSCID.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceSCID.csv") |

#----------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE TEST
    Given path 'user-service/v1/user/userId/<SCID>'
    When method Get
    Then status 400
    Then match $.metadata.status == <expected_status>
    And match $.content.errorDescription == <expected_errorDescription>
    And match $.content.errorCode == <expected_errorCode>
    Examples:
      | SCID | expected_status  | expected_errorCode | expected_errorDescription |
      | 1    | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "No matching user found"  |

#----------------------------------------------------------------------------------------------------------------
#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Create User-Profile (With Token)
    Given path 'user-service/v1/user'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    * def expectedResponse = read('ntuc_memberportal/resources/Request/user-serviceUser.json')
    And request requestBody
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
      | read('ntuc_memberportal/resources/TestData_File/user-serviceUser.csv') |

#----------------------------------------------------------------------------------------------------------------
#    POST
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE TEST (With Token)
    Given path 'user-service/v1/user'
    * string user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-serviceProfile.json')
    And request requestBody
    When method Post
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
#    Then match response.errorCode == <errorCode>
    Examples:
      | status        | errorDescription                    | errorCode |                                                                           | username            |
      | "BAD_REQUEST" | "Caught Validation Error for /user" | null      | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') | "ishsh@hotmail.com" |

#----------------------------------------------------------------------------------------------------------------
#   DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method via USERID
    Given path 'user-service/v1/user'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def id = parseInt(id)
    When method Delete
    And print response
    Then status 200
    Then match response == read ("ntuc_memberportal/resources/Response/user-serviceDelete.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceDeleteUser.csv') |

#----------------------------------------------------------------------------------------------------------------
#    PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Edit User-Profile (With Token)
    Given path 'user-service/v1/user'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePutProfile.json')
    And request requestBody
    * print requestBody
    When method Put
    Then status 200
    Then match response.content.homeTelNo == request.homeTelNo
    Then match response.content.buildingName == request.buildingName
    Then match response.content.street == request.street
    Then match response.content.unit == request.unit
    Then match response.content.floor == request.floor
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') |

#----------------------------------------------------------------------------------------------------------------
#    PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE Tests
    Given path 'user-service/v1/user'
    * string user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePutProfile.json')
    And request requestBody
    When method Put
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Then match response.content.errorCode == <errorCode>
    Examples:
      | status        | errorDescription                    | errorCode          |                                                                           | username            |
      | "BAD_REQUEST" | "Caught Validation Error for /user" | "VALIDATION_ERROR" | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') | "ishsh@hotmail.com" |

#----------------------------------------------------------------------------------------------------------------
#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 299 - User Login
    Given path 'user-service/v1/user/login'
    * def user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = ""
    And request requestBody
    When method Post
    And print response
    Then status 200
    And match response == read("ntuc_memberportal/resources/Response/user-serviceLogin.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceLogin.csv') |

#----------------------------------------------------------------------------------------------------------------