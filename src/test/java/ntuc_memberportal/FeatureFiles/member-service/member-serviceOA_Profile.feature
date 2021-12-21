@all
@member-service

Feature: OA Member-Service
  This feature will test HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 142 GET method to verify membership details
    Given path 'member-service/v1/membership'
    * def user = username
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

#-----------------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG - 527 GET method to verify membership DRAFT details
    Given path 'member-service/v1/membership/draft'
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    * print response
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceDraft.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.membership[0].nameOnCard == expectedResponse.content.membership[0].nameOnCard
    Then match response.content.user.address.buildingName == expectedResponse.content.user.address.buildingName
    Then match response.content.user.address.unit == expectedResponse.content.user.address.unit
    Then match response.content.user.address.homeTelNo == expectedResponse.content.user.address.homeTelNo
    Then match response.content.user.address.blockHSENo == expectedResponse.content.user.address.blockHSENo
    Then match response.content.user.address.street == expectedResponse.content.user.address.street
    Then match response.content.user.address.residentialStatus == expectedResponse.content.user.address.residentialStatus
    Then match response.content.user.address.postalCode == expectedResponse.content.user.address.postalCode
    Then match response.content.user.address.floor == expectedResponse.content.user.address.floor
    Then match response.content.user.gender == expectedResponse.content.user.gender

    Then match response.content.user.race == expectedResponse.content.user.race
    Then match response.content.user.employmentType == expectedResponse.content.user.employmentType
    Then match response.content.user.nricFin == expectedResponse.content.user.nricFin
    Then match response.content.user.mobileNumber == expectedResponse.content.user.mobileNumber
    Then match response.content.user.bankName == expectedResponse.content.user.bankName
    Then match response.content.user.exchangeId == expectedResponse.content.user.exchangeId

    Then match response.content.user.occupationalGroup == expectedResponse.content.user.occupationalGroup
    Then match response.content.user.dob == expectedResponse.content.user.dob
    Then match response.content.user.bankAccountNumber == expectedResponse.content.user.bankAccountNumber
    Then match response.content.user.highestEducationLevel == expectedResponse.content.user.highestEducationLevel
    Then match response.content.user.officeTelNo == expectedResponse.content.user.officeTelNo
    Then match response.content.user.email == expectedResponse.content.user.email
    Then match response.content.user.maritalStatus == expectedResponse.content.user.maritalStatus
    Then match response.content.user.scid == expectedResponse.content.user.scid

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceDraft.csv') |

#--------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG - 527 Verify DRAFT membership with NRIC and DOB details
    Given path 'member-service/v1/membership/draft/<nric>/<dob1>'
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read("ntuc_memberportal/resources/Response/member-service2DRAFT.json")
    Then match response.content.membership[0].nameOnCard == expectedResponse.content.membership[0].nameOnCard
    Then match response.content.membership[0].status == expectedResponse.content.membership[0].status
    Then match response.content.membership[0].membershipTypeCode == expectedResponse.content.membership[0].membershipTypeCode
    Then match response.content.user.monthlyGrossSalary == expectedResponse.content.user.monthlyGrossSalary
    Then match response.content.user.occupation == expectedResponse.content.user.occupation
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceDraft2.csv") |

#--------------------------------------------------------------------------------------------------------------
#   Patch - XX
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - PUT request for member service
    Given path 'member-service/v1/membership/oa/<MemID>'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceMemOAPatch.json')
    And request requestBody
    When method Patch
    * print response
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
  Scenario Outline: PRODUCT BACKLOG 530 - Get all membership types the user can apply to.
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
      | Type | status    | username            |
      | "OA" | "SUCCESS" | "ishsh@hotmail.com" |

#--------------------------------------------------------------------------------------------------------------
#    GET - XX
  Scenario Outline: PRODUCT BACKLOG 299 - OA Membership terms-and-conditions
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
  Scenario Outline: PRODUCT BACKLOG 299 - NEGATIVE TEST
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
  Scenario Outline: PRODUCT BACKLOG 299 - Accept Terms and Condition
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
#   POST - XX
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - POST request for member service (With Token)
    Given path 'member-service/v1/membership/oa/'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceMemOA.json")
    And request requestBody
    When method Post
    * print response
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
#   POST -1
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - POST request for member service (Without Token)
    Given path 'member-service/v1/membership/open/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceOpenMemOA.json")
    And request requestBody
    * def email = '<email>'
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content.membership.membershipTypeCode == "OA"
    Then match response.content.membership.status == "DRAFT"
    * print response.content.user.email == email
    Then match response.content.user.race == "MY"
    Then match response.content.user.bankName == "DBS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceOpenMemOA.csv') |

#--------------------------------------------------------------------------------------------------------------
#  POST-1
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - NEGATIVE SCENARIO
    Given path 'member-service/v1/membership/open/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceOpenMemOA.json")
    And request requestBody
    When method Post
    * print requestBody
    Then status 409
    Then match response.metadata.status == "CONFLICT"
    Then match response.content.errorCode == "RECORD_EXISTS_DRAFT"
    Then match response.content.errorDescription == "Existing OA membership in draft, please retrieve the draft."
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceOpenMemOA.csv') |

#--------------------------------------------------------------------------------------------------------------
#  GET -1
  Scenario Outline: PRODUCT BACKLOG 16 - Retrieve all cards by user Id.
    Given path 'member-service/v1/membership/cards'
    * string user = username
    * def uLive = Boolean(uLive)
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceCards.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceCards.csv') |

#-----------------------------------------------------------------------------------------------------------------------
##  GET
#  Scenario Outline: PRODUCT BACKLOG 1214 - Retrieve Membership status details i.e. Active or DRAFT status
#    Given path 'member-service/v1/membership/has-draft-or-active-membership'
#    * string user = username
#    * def secret = test_secret[user]
#    * def setup = call read('../commonFeatures/auth.feature')
#    * def dynamicAccessToken = setup.dynamicAccessToken
#    And header Authorization = 'Bearer ' + dynamicAccessToken
#    When method Get
#    Then status 200
#    Then match expectedResponse == read('')
#    Then match response.metadata.status == expectedResponse.metadata.status
##    Then match response.content.types contains types
#
#    Examples:
#      | read('') |
#
#
##--------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG 143 - Membership Association
    Given path 'member-service/v1/membership/membershipAssociation'
    * param last4Nric = last4Nric
    * param dob = dob
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceAssociation.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.phone[0] == expectedResponse.content.phone[0]
    Then match response.content.email[0] == expectedResponse.content.email[0]

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceAssociation.csv') |