@membership

Feature: Membership microservice
  This feature will test GET/POST HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expectedMembershipDetails = read("ntuc_memberportal/resources/Response/membershipDetails.json")
    * def expectedMembership_User_Details = read("ntuc_memberportal/resources/Response/membershipUserDetails.json")
    * def expectedMembership_Address_Details = read("ntuc_memberportal/resources/Response/membershipAddressDetails.json")
    * def expectedMembershipType = read("ntuc_memberportal/resources/Response/memberserviceContent.json")

  # To GET response from Membership micro-service and verify status
  Scenario: PRODUCT BACKLOG ITEM 142 - GET response from Membership service and verify status
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
#    And print response
    * print "responseStatus = " + responseStatus
    * print "responseTime = " + responseTime
    * def status = response.metadata.status == 'SUCCESS'
    * print "status is = " + status

   # To GET response from Membership micro-service and verify content inside response
  Scenario: PRODUCT BACKLOG ITEM 142
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    * def actualResponseType = response.content[0].membershipType
    * def actualResponseStatus = response.content[0].status
    * def actualResponseUCode = response.content[0].unionCode
    * def actualResponseUName = response.content[0].unionName
    Then match actualResponseType == expectedMembershipType.membershipType
    Then match actualResponseStatus == expectedMembershipType.status
    Then match actualResponseUCode == expectedMembershipType.unionCode
    Then match actualResponseUName == expectedMembershipType.unionName


   # To GET response from Membership micro-service and verify content inside MEMBERSHIP response
  Scenario: PRODUCT BACKLOG ITEM 417 -1
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
#    And print response.content.membership[0]
    And match response.content.membership[0] == expectedMembershipDetails

  # To GET response from Membership micro-service and verify content inside USER response
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

  # To GET response from Membership micro-service and verify content inside ADDRESS response
  Scenario: PRODUCT BACKLOG ITEM 417 - Validate GET method from member-service inside ADDRESS response
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    * def addressResponse = response.content.address
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd")
    * def today = formatter.format(new java.util.Date())
    #* print today
    * match addressResponse.modifiedDttm contains today
    * def addressFields = response.content.address
    And match addressFields == expectedMembership_Address_Details

# To GET response from Membership micro-service and verify content using NRIC and DOB
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - Validate GET method when user pass NRIC and DOB as request
    Given path 'member-service/v1/membership/nric/NRIC/dob/DOB'
    And param NRIC = "<NRIC>"
    And param DOB = <DOB>
    When method Get
    Then status 200
#   Then print response
    Examples:
      | NRIC | DOB        |
      | 987W | 2010-01-10 |
      | 111  | 2015-01-00 |
      | #$1  | 2020-01-11 |
      | 123Q | 2030-01-12 |

  # To POST response from Membership micro-service and verify content using NRIC and DOB
  Scenario: PRODUCT BACKLOG ITEM 101 - POST request for member service
    Given path 'membership'
    And def requestBody = read("ntuc_memberportal/resources/Request/membershipRequest.json")
    And request requestBody
    When method Post
    Then status 201
#    Then print response
#   Then match response == expectedResponse