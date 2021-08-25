@all
@member-service

Feature: OA Member-Service
  This feature will test HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET method to verify member service for OA
  Scenario Outline: PRODUCT BACKLOG - 244 GET method to verify membership details
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    * def expected = read('ntuc_memberportal/resources/Response/member-serviceMemShip.json')
    Then match response == expected

    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceProfile.csv") |

#  GET
  Scenario Outline: PRODUCT BACKLOG - 527 GET method to verify membership DRAFT details
    Given path 'member-service/v1/membership/draft/<scid>'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceProfile.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-servicePOSTResponse.csv") |

#  GET
  Scenario Outline: PRODUCT BACKLOG - 527 NEGATIVE Test
    Given path 'member-service/v1/membership/draft/<scid>'
    When method Get
    Then status 200
    Then match response.metadata.status == <status>
    Then match response.metadata.errorCode == <errorCode>
    Then match response.metadata.errorDescription == <errorDescription>

    Examples:
      | scid | status      | errorCode       | errorDescription                            |
      | @#$  | "SYS_ERROR" | "UNKNOWN_ERROR" | "Unknown error while fetching memberships." |
      | 876  | "SYS_ERROR" | "UNKNOWN_ERROR" | "Unknown error while fetching memberships." |

# POST method to verify user request is getting created
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - POST request for member service
    Given path 'member-service/v1/membership/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceMemOA.json")
    And request requestBody
    When method Post
    Then status 200
#    Then print response
    Then match response == requestBody

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceMemOA.csv') |

#  PUT method to verify user request is getting created
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - PUT request for member service
    Given path 'member-service/v1/membership/<MemID>'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceProfile.json")
    And request requestBody
    When method Put
    Then status 200
    Then match response == memberData

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePUTResponse.csv') |

#   GET
  Scenario Outline: PRODUCT BACKLOG - 527 NEGATIVE Test
    Given path 'member-service/v1/membership/memberships-can-apply/<scid>'
    When method Get
    Then status 200
    Then match response.content.types == <Type>
    Then match response.metadata.status == <status>

    Examples:
      | scid | Type  | status    |
      | 5    | "OA"  | "SUCCESS" |
      | 6    | "NFM" | "SUCCESS" |
      | 7    | "NOK" | "SUCCESS" |