@membership @all

Feature: Membership microservice
  This feature will test GET/POST HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expectedMembershipDetails = read("ntuc_memberportal/resources/Response/membershipDetails.json")
    * def expectedMembership_User_Details = read("ntuc_memberportal/resources/Response/membershipUserDetails.json")
    * def expectedMembership_Address_Details = read("ntuc_memberportal/resources/Response/membershipAddressDetails.json")

    # To GET response from Membership micro-service and verify status
  Scenario: PRODUCT BACKLOG ITEM 142 - 1
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    And print response
    * print "responseStatus = " + responseStatus
    * print "responseTime = " + responseTime
    * def status = response.metadata.status == 'SUCCESS'
    * print "status is = " + status

   # To GET response from Membership micro-service and verify content inside response
  Scenario: PRODUCT BACKLOG ITEM 142 - 2
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    And print response
    And response.content.membershipType == "OA"
    And response.content.unionName == "NTUC Union"
    And response.content.membershipStatus == "ACTIVE"
    * def date1 = response.content[0].lastPaidDate
    And assert date1 == "2021-07-15T06:12:36.000Z"
#    #Below logic to verify accurate date (NEED TO DISCUSS WITH DEV TEAM ON DATE LOGIC)
#    * def sdf = new java.text.SimpleDateFormat("MM-dd-yyyy")
#    * def today = sdf.format(new java.util.Date())
#    And print today

   # To GET response from Membership micro-service and verify content inside MEMBERSHIP response
  Scenario: PRODUCT BACKLOG ITEM 417 -1
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    And print response.content.membership[0]
    And match response.content.membership[0] == expectedMembershipDetails

  # To GET response from Membership micro-service and verify content inside USER response
  Scenario: PRODUCT BACKLOG ITEM 417 - 2
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
  Scenario: PRODUCT BACKLOG ITEM 417 - 3
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


# To GET response from Membership micro-service and verify content inside ADDRESS response
  Scenario: PRODUCT BACKLOG ITEM
    Given path 'member-service/v1/membership/nric/{NRIC}/dob/{DOB}'
    And param NRIC = '673P'
    And param DOB = '1990-11-11'
    When method Get
    Then status 200
    Then print response

# To GET response from Membership micro-service and verify content using NRIC and DOB
  Scenario: PRODUCT BACKLOG ITEM
    Given path 'member-service/v1/membership/nric/{NRIC}/dob/{DOB}'
    And param NRIC = '673P'
    And param DOB = '1981-06-03'
    When method Get
    Then status 200
    Then print response

    # To GET response from Membership micro-service by passing INCORRECT NRIC AND DOB
  Scenario: PRODUCT BACKLOG ITEM
    Given path 'member-service/v1/membership/nric/{NRIC}/dob/{DOB}'
    And param NRIC = 'XXXXX'
    And param DOB = 'XXXXX'
    When method Get
    Then status 200
    Then print response


    # To POST response from Membership micro-service and verify content using NRIC and DOB
  Scenario: PRODUCT BACKLOG ITEM
    Given path 'membership'
    And def requestBody = read("ntuc_memberportal/resources/Request/membershipRequest.json")
    And request requestBody
    When method Post
    Then status 201
    Then print response
#    Then match response == expectedResponse