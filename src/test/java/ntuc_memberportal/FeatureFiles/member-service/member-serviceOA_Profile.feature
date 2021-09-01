@all
@member-service

Feature: OA Member-Service
  This feature will test HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

#  GET
  Scenario Outline: PRODUCT BACKLOG - 244 GET method to verify membership details
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceMemShip.json')
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
      | scid  | status      | errorCode       | errorDescription                            |
      | "@#$" | "SYS_ERROR" | "UNKNOWN_ERROR" | "Unknown error while fetching memberships." |
      | "876" | "SYS_ERROR" | "UNKNOWN_ERROR" | "Unknown error while fetching memberships." |

#  PUT method
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

    #  PUT method
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

#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - POST request for member service (With Token)
    Given path 'member-service/v1/membership/oa'
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