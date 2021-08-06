@membership

Feature: Membership microservice
  This feature will test GET/POST HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

    # To GET response from Membership micro-service and verify status
    Scenario: User story number
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    And print response
    * print "responseStatus = " + responseStatus
    * print "responseTime = " + responseTime
    * def status = response.metadata.status == 'SUCCESS'
    * print "status is = " + status

   # To GET response from Membership micro-service and verify content inside response
    Scenario: User story number
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    And print response
    And response.content.membershipType == "OA"
    And response.content.unionName == "NTUC Union"
    And response.content.membershipStatus == "ACTIVE"

   # To GET response from Membership micro-service and verify content inside response
    Scenario: User story number
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    And print response
    And match response.content.membership[0].id == 2
    And match response.content.membership[0].membershipTypeCode == "OA"
    And match response.content.membership[0].optInNebo == true
    And match response.content.membership[0].relationship == "FATHER"
    And match response.content.membership[0].status =="DRAFT"
    And match response.content.membership[0].userId == 1

  # To GET response from Membership micro-service and verify content inside response
    Scenario: User story number
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    And print response
    And match response.content.user.lastLoginReminderSent == false
    And match response.content.user.nricFin == "123456L"
    And match response.content.user.name == "user name"
    And match response.content.user.status == "DRAFT"
    And match response.content.user.email == "email@palo-it.com"
    And match response.content.user.mobileNumber == "8888 8888"
    And match response.content.user.race == "race"
    And match response.content.user.gender == "MALE"
    And match response.content.user.highestEducationLevel == "bachelor"
    And match response.content.user.occupationalGroup == "occup"
    And match response.content.user.companyName == "company name"
    And match response.content.user.companyBusinessNature == "company nature"
    And match response.content.user.occupation == "developer"
    And match response.content.user.monthlyGrossSalary == 9999
    And match response.content.user.officeTelNo == "1234 5678"
    And match response.content.user.bankName == "bank name"
    And match response.content.user.bankAccountNumber == "0000 0000"
    And match response.content.user.emailVerified == false
    And match response.content.user.mobileNumberVerified == false


  # To GET response from Membership micro-service and verify content inside response
    Scenario: User story number
    Given path 'member-service/v1/membership/draft'
    When method Get
    Then status 200
    And match response.content.address.unit == "string"
    And match response.content.address.street == "string"
    And match response.content.address.postalCode == "string"
    And match response.content.address.homeTelNo == "string"
    And match response.content.address.floor == "string"
    And match response.content.address.buildingName == "string"
    And match response.content.address.blockHSENo == "string"
    And match response.content.address.residentialStatus == "SC"

