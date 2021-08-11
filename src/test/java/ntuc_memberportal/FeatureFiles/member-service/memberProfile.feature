@member-service @all

Feature: OA Member-Service
  This feature will test GET/POST HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expectedMembershipDetails = read("ntuc_memberportal/resources/Response/memberserviceDetails.json")
    * def expectedMembership_User_Details = read("ntuc_memberportal/resources/Response/memberserviceUserDetails.json")
    * def expectedMembership_Address_Details = read("ntuc_memberportal/resources/Response/memberserviceAddressDetails.json")
    * def expectedMembershipType = read("ntuc_memberportal/resources/Response/memberserviceContent.json")

  # GET
  Scenario: PRODUCT BACKLOG ITEM 142 - Validate GET method from member-service and verify status
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
#    And print response
    * print "responseStatus = " + responseStatus
    * print "responseTime = " + responseTime
    * def status = response.metadata.status == 'SUCCESS'
    * print "status is = " + status

   # GET
  Scenario: PRODUCT BACKLOG ITEM 417 - Validate GET method from member-service and verify Member Type, UnionName, Status and UnionCode
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
#   And print response.content.membership[0]
    And match response.content.membership[0] == expectedMembershipDetails

  # GET
  Scenario: PRODUCT BACKLOG ITEM 417 - Validate GET method from member-service inside USER response
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    * def userResponse = response.content.user
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd")
    * def today = formatter.format(new java.util.Date())
    # * print today
    * match userResponse.lastLogin contains today
    * def userFields = response.content.user
    And match userFields == expectedMembership_User_Details

# GET
  Scenario: PRODUCT BACKLOG ITEM 417 - Validate GET method from member-service inside ADDRESS response
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    * def addressResponse = response.content.address
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd")
    * def today = formatter.format(new java.util.Date())
#   * print today
    * match addressResponse.modifiedDttm contains today
    * def addressFields = response.content.address
    And match addressFields == expectedMembership_Address_Details

# GET
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method when user pass NRIC and DOB as request
    Given path 'member-service/v1/membership/NRIC/DOB'
#    * print NRIC + " " + DOB
    When method Get
    Then status 200
    Then print response
    Examples:
      | NRIC | DOB        |
      | 987W | 2010-01-10 |
#      | 111  | 2015-01-00 |
#      | #$1  | 2020-01-11 |
#      | 123Q | 2030-01-12 |

  # POST
  Scenario: PRODUCT BACKLOG ITEM 101 - POST request for member service
    Given path 'membership'
    And def requestBody = read("ntuc_memberportal/resources/Request/memberserviceRequest.json")
    And request requestBody
    When method Post
    Then status 201
#   Then print response
#   Then match response == expectedResponse