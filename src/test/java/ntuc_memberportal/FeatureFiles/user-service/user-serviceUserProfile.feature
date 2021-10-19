@all
@user-service

Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken

#  GET
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-serviceStaticData.json")

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

#    POST
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Create User-Profile (With Token)
    Given path 'user-service/v1/user'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-serviceUser.json')
    And request requestBody
    * print requestBody
    When method Post
    Then status 200
    Then match response.scid == request.scid
    Then match response.status == request.status
    Then match response.nricFin == request.nricFin
    Then match response.name == request.name
    Then match response.dob == request.dob
    Then match response.gender == request.gender
    Then match response.mobileNumber == request.mobileNumber
    Then match response.email == request.email
    Then match response.maritalStatus == request.maritalStatus
    Then match response.companyName == request.companyName
    Then match response.monthlyGrossSalary == request.monthlyGrossSalary
    Then match response.lastLogin == request.lastLogin
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceUser.csv') |

#    POST
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE TEST (With Token)
    Given path 'user-service/v1/user'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/user-serviceProfile.json')
    And request requestBody
    When method Post
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Then match response.errorCode == <errorCode>
    Examples:
      | status        | errorDescription                    | errorCode |                                                                           |
      | "BAD_REQUEST" | "Caught Validation Error for /user" | " "        | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') |

#   DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method via USERID
    Given path 'user-service/v1/user'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Delete
    And print response
    Then status 200
    Then match response == read ("ntuc_memberportal/resources/Response/user-serviceDelete.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceDeleteUser.csv') |

#   DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE TEST
    Given path 'user-service/v1/user/<id>'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Delete
    Then status 400
    Then print response.metadata.status == <expected_delete_status>
    Then print response.content.errorDescription == <expected_delete_errorDescription>
    Examples:
      | id  | expected_delete_status | expected_delete_errorDescription |
      | 999 | "BUSINESS_ERROR"       | "Error while deleting user"      |


#    PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Edit User-Profile (With Token)
    Given path 'user-service/v1/user'
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
    Then match response.content.blockHSENo == request.blockHSENo
    Then match response.content.postalCode == request.postalCode

    Then match response.content.residentialStatus == request.residentialStatus
    Then match response.content.exchangeId == request.exchangeId
    Then match response.content.employmentType == request.employmentType
    Then match response.content.status == request.status
    Then match response.content.scid == request.scid
    Then match response.content.race == request.race
    Then match response.content.officeTelNo == request.officeTelNo
    Then match response.content.occupationalGroup == request.occupationalGroup
    Then match response.content.id == request.lastLogin
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') |

