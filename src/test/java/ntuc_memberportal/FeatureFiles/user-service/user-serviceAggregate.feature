@user-service @all
Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expectedUserDetails = read("ntuc_memberportal/resources/Response/userAggregateDetails.json");

    # POST response
  Scenario: PRODUCT BACKLOG ITEM XXX - Validate POST method for user address and details under User-service
    Given path 'user-service/v1/user/aggregate'
    And def requestBody = read("ntuc_memberportal/resources/Request/useraggregateRequest.json")
    And request requestBody
    #Insert data
    * def expectedUserResponse = {"id":"number","scid":"string","status":"DRAFT","nricFin":"string","name":"string","dob":"#ignore","gender":"MALE","mobileNumber":"string","email":"string","race":"string","maritalStatus":"SINGLE","highestEducationLevel":"string","occupationalGroup":"string","companyName":"string","companyBusinessNature":"string","occupation":"string","monthlyGrossSalary":0,"officeTelNo":"string","bankName":"string","bankAccountNumber":"string","lastLogin":"#ignore","lastLoginReminderSent":true,"applicationSource":"UCEM","emailVerified":true,"mobileNumberVerified":true}
    When method Post
    Then status 200
    Then match response.content.user == {"id":"number","scid":"string","status":"DRAFT","nricFin":"string","name":"string","dob":"#ignore","gender":"MALE","mobileNumber":"string","email":"string","race":"string","maritalStatus":"SINGLE","highestEducationLevel":"string","occupationalGroup":"string","companyName":"string","companyBusinessNature":"string","occupation":"string","monthlyGrossSalary":0,"officeTelNo":"string","bankName":"string","bankAccountNumber":"string","lastLogin":"#ignore","lastLoginReminderSent":true,"applicationSource":"UCEM","emailVerified":true,"mobileNumberVerified":true}
    #And match response[0].address == requestBody.address