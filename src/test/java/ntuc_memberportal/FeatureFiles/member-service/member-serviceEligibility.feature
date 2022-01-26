@all
@member-service

Feature: Member-Service (Eligibility)
  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------------------------------------
#  Get
  Scenario Outline: PRODUCT BACKLOG ITEM 415 - Validate GET method for Eligibility under Member-service
    Given path 'member-service/v1/membership/check/active/<NRIC>/<DOB>'
    When method Get
    * def PaymentArrearMonths = parseInt(PaymentArrearMonths)
    * print PaymentArrearMonths
    * def PaymentTypeCode = parseInt(PaymentTypeCode)
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].PaymentTypeName == expectedResponse.content.PaymentTypeName
    Then match response.content[0].PaymentArrearMonths == expectedResponse.content.PaymentArrearMonths
    Then match response.content[0].PaymentTypeCode == expectedResponse.content.PaymentTypeCode
    Then match response.content[0].UnionCode == expectedResponse.content.UnionCode
    Then match response.content[0].ExchangeId == expectedResponse.content.ExchangeId
    Then match response.content[0].BranchCode == expectedResponse.content.BranchCode
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibility.csv") |

#-----------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 415 - NEGATIVE TEST
    Given path 'member-service/v1/membership/check/active/<NRIC>/<DOB>'
    When method Get
    Then status 500
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | NRIC              | DOB      | status      | errorCode       | errorDescription                          |
      | (*&)W             | 13139999 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |
      | @#$%#@            | 12122001 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |
      | jdkdfkjasbdkjasgf | 13139999 | "SYS_ERROR" | "UNKNOWN_ERROR" | "Error fetching membership active status" |

#-----------------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 415 - Validate GET method for Occupation-Group Eligibility under Member-service
    Given path 'member-service/v1/membership/check/eligibility/<NRIC>'
    * def Checkelig = Boolean(Checkelig)
    When method Get
    * print response
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibilityNRIC.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response contains {Checkelig: '##boolean'}
    Then match response contains {Checkclist: '##boolean'}
    Then match response contains {Checkblist: '##boolean'}
    Then match response contains {CheckIneligibleJobFlag: '##boolean'}
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibilityNRIC.csv") |
#-----------------------------------------------------------------------------------------------------------------------

   #   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 415 - Validate GET method for Occupation-Group Eligibility under Member-service
    Given path 'member-service/v1/membership/check/eligibility/<NRIC>'
    * def Checkelig = Boolean(Checkelig)
    * def Checkblist = Boolean(~~Checkblist)
    * def CheckIneligibleJobFlag = Boolean(~~CheckIneligibleJobFlag)
    When method Get
    * print response
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibilityNRIC.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].Checkelig == expectedResponse.content[0].Checkelig
    Then match response.content[0].Checkblist == expectedResponse.content[0].Checkblist
    Then match response.content[0].CheckIneligibleJobFlag == expectedResponse.content[0].CheckIneligibleJobFlag
    Then match response.content[0].ShowBlacklistMessage == expectedResponse.content[0].ShowBlacklistMessage
    Then match response.content[0].ShowActiveMessage == expectedResponse.content[0].ShowActiveMessage

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibilityNRIC.csv") |

#-----------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG ITEM 415 - Blacklisted member
    Given path 'member-service/v1/membership/check/eligibility/<NRIC>'
    * def Checkelig = Boolean(Checkelig)
    * def Checkclist = Boolean(~~Checkclist)
    * def Checkblist = Boolean(Checkblist)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceEligibilityBlackListed.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].BlacklistReason == expectedResponse.content[0].BlacklistReason
    Then match response.content[0].Eligibility == expectedResponse.content[0].Eligibility
    Then match response.content[0].Checkelig == expectedResponse.content[0].Checkelig
    Then match response.content[0].Checkclist == expectedResponse.content[0].Checkclist
    Then match response.content[0].ShowActiveMessage == expectedResponse.content[0].ShowActiveMessage
    Then match response.content[0].ShowBlacklistMessage == expectedResponse.content[0].ShowBlacklistMessage
    Then match response.content[0].Checkblist == expectedResponse.content[0].Checkblist
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceEligibilityBlacklisted.csv') |

#--------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 1215 Validate Membership DETAILS using NRIC and DOB
    Given path 'member-service/v1/membership/details/<NRIC>/<DOB>'
    * def ArrearsinMonth = parseInt(ArrearsinMonth)
    * def ArrearsAmount = parseInt(ArrearsAmount)
    * def EducationalLevel = parseInt(EducationalLevel)
    * def MaritalStatus = parseInt(MaritalStatus)
    When method Get
    Then status 200
    * def expected = read('ntuc_memberportal/resources/Response/member-serviceMemDetailss.json')
    Then match response.metadata.status == expected.metadata.status
    Then match response.content[0].ApplicationSourceName == expected.content[0].ApplicationSourceName
    Then match response.content[0].BranchName == expected.content[0].BranchName
    Then match response.content[0].ApplicationStatusName == expected.content[0].ApplicationStatusName
    Then match response.content[0].BranchCode == expected.content[0].BranchCode
    Then match response.content[0].BranchName == expected.content[0].BranchName
    Then match response.content[0].Businessnature == expected.content[0].Businessnature
    Then match response.content[0].DateofBirth == expected.content[0].DateofBirth
    Then match response.content[0].EducationalLevel == expected.content[0].EducationalLevel
    Then match response.content[0].EducationalLevelDesc == expected.content[0].EducationalLevelDesc
    Then match response.content[0].ExchangeId == expected.content[0].ExchangeId
    Then match response.content[0].GenderDesc == expected.content[0].GenderDesc
    Then match response.content[0].MaritalStatus == expected.content[0].MaritalStatus
    Then match response.content[0].MaritalStatusDesc == expected.content[0].MaritalStatusDesc
    Then match response.content[0].MemberTypeName == expected.content[0].MemberTypeName
    Then match response.content[0].Membershipid == expected.content[0].Membershipid
    Then match response.content[0].Occupation == expected.content[0].Occupation
    Then match response.content[0].PaymentModeName == expected.content[0].PaymentModeName
    Then match response.content[0].RaceDesc == expected.content[0].RaceDesc
    Then match response.content[0].UnionCode == expected.content[0].UnionCode
    Then match response.content[0].UnionName == expected.content[0].UnionName
    Then match response.content[0].PaymentInstructionName == expected.content[0].PaymentInstructionName

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceMemDetails.csv') |
#--------------------------------------------------------------------------------------------------------------
#  GET

  Scenario Outline: PRODUCT BACKLOG 1215- NEGATIVE TEST
    Given path 'member-service/v1/membership/details/<NRIC>/<DOB>'
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription  == <errorDescription>
    Examples:
      | NRIC            | DOB       | status        | errorCode          | errorDescription   |
      | @#E#            | 01011990  | "BAD_REQUEST" | "VALIDATION_ERROR" | "Invalid NRIC/FIN" |
      | @#724537612#    | 090920011 | "BAD_REQUEST" | "VALIDATION_ERROR" | "Invalid NRIC/FIN" |
      | 82745812745     | 090920011 | "BAD_REQUEST" | "VALIDATION_ERROR" | "Invalid NRIC/FIN" |
      | jsfgluisafgjshf | 090920011 | "BAD_REQUEST" | "VALIDATION_ERROR" | "Invalid NRIC/FIN" |

#--------------------------------------------------------------------------------------------------------------