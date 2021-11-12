@all
@member-service

Feature: OA Member-Service
  This feature will test HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')


#   GET
  Scenario Outline: PRODUCT BACKLOG - 244 GET method to verify membership details
    Given path 'member-service/v1/membership'
    * def user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * def expectedResponse = read("ntuc_memberportal/resources/Response/member-serviceMemShip.json")
    * print response.content.membershipTypeCode == expectedResponse.content
    * print response.content.nameOnCard == expectedResponse.content
    * print response.content.status == expectedResponse.content
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceMemShip.csv") |

#--------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 527 GET method to verify membership DRAFT details (with valid Token)
    Given path 'member-service/v1/membership/draft'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response.content == read('ntuc_memberportal/resources/Response/member-serviceDraft.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceDraft.csv') |

#--------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - 527 GET method to verify membership DRAFT details
    Given path 'member-service/v1/membership/draft/nric/dob'
    * def nric = <nric>
    * def dob = <dob>
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceDraft.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceDraft.csv') |

#--------------------------------------------------------------------------------------------------------------
#   PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - PUT request for member service
    Given path 'member-service/v1/membership/oa/<MemID>'
    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceMemOA.json')
    And request requestBody
    When method Put
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content.membershipTypeCode == requestBody.membershipTypeCode
    Then match response.content.status == requestBody.status
    Then match response.content.relationship == requestBody.relationship
    Then match response.content.optInNebo == requestBody.optInNebo
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePUTRequest.csv') |

#--------------------------------------------------------------------------------------------------------------
#   PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - NEGATIVE TEST
    Given path 'member-service/v1/membership/oa/<MemID>+gar'
    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceMemOA.json')
    And request requestBody
    When method Put
    Then status 400
    Then match response.metadata.status == "BAD_REQUEST"
    Then match response.content.errorCode == "VALIDATION_ERROR"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePUTRequest.csv') |

#--------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG 527 - Get all membership types the user can apply to.
    Given path 'member-service/v1/membership/memberships-can-apply'
    * string user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response.content.types contains <Type>
    Then match response.metadata.status == <status>
    Examples:
      | Type  | status    | username            |
      | "OA"  | "SUCCESS" | "ishsh@hotmail.com" |
      | "NFM" | "SUCCESS" | "ishsh@hotmail.com" |

#--------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG 277 - OA Membership terms-and-conditions
    Given path 'member-service/v1/membership/OA/terms-and-conditions/'
    When method Get
    Then status 200
    And print response
    * def expectedResult = read('ntuc_memberportal/resources/Response/member-serviceTermsCond.json')
    * print expectedResult
    Then match response.metadata.status == "SUCCESS"
    Then match response.content.version == expectedResult.content.version
    Then match response.content.content == expectedResult.content.content
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceTermsCond.csv") |

#--------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG 277 - NEGATIVE TEST
    Given path 'member-service/v1/membership/<type>/terms-and-conditions/'
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | type | status        | errorCode          | errorDescription                                                    |
      | OAA  | "BAD_REQUEST" | "VALIDATION_ERROR" | "Caught Validation Error for /membership/OAA/terms-and-conditions/" |

#--------------------------------------------------------------------------------------------------------------
#   PUT
  Scenario Outline: PRODUCT BACKLOG 277 - Accept Terms and Condition
    Given path 'member-service/v1/membership/<membershipId>/terms-and-conditions/accept'
    * def membershipId = parseInt(membershipId)
    * def agreed = Boolean(agreed)
    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceTCAccept.json')
    And request requestBody
    When method Put
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceTCAccept.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceTCAccept.csv') |

#--------------------------------------------------------------------------------------------------------------
#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - POST request for member service (With Token)
    Given path 'member-service/v1/membership/oa/'
    * string user = username
    * print user
    * def secret = test_secret[user]
    * print secret
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceMemOA.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content.membershipTypeCode == requestBody.membershipTypeCode
    Then match response.content.status == requestBody.status
    Then match response.metadata.relationship == requestBody.relationship
    Then match response.metadata.optInNebo == requestBody.optInNebo
    Then match response.metadata.userId == requestBody.userId
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceMemOA.csv') |

#--------------------------------------------------------------------------------------------------------------
#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - POST request for member service (Without Token)
    Given path 'member-service/v1/membership/open/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceOpenMemOA.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content.membershipTypeCode == requestBody.membershipTypeCode
    Then match response.content.status == requestBody.status
    Then match response.metadata.relationship == requestBody.relationship
    Then match response.metadata.optInNebo == requestBody.optInNebo
    Then match response.metadata.userId == requestBody.userId
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceOpenMemOA.csv') |

#--------------------------------------------------------------------------------------------------------------
#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - When API Server is Un-Available (Without Token)
    Given path 'member-service/v1/membership/open/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceOpenMemOA.json")
    And request requestBody
#    * print requestBody
    When method Post
    Then status 500
    Then match response.metadata.status == "SYS_ERROR"
    Then match response.content.errorCode == "UNKNOWN_ERROR"
    Then match response.content.errorDescription == "Error while saving the membership."
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceOpenMemOA.csv') |

#--------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG 88 - Retrieve all cards by user Id.
    Given path 'member-service/v1/membership/cards'
    * string user = username
    * print user
    * def secret = test_secret[user]
    * print secret
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def uLive = Boolean(uLive)
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceCards.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceCards.csv') |