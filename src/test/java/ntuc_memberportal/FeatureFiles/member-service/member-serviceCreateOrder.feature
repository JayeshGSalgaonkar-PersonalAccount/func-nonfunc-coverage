@member-service @all

Feature: Member-Service (CreateOrder)

  This feature will test POST method for CreateOrder API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

    #POST response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 5 - Validate GET method for CreateOrder under Member-service
    Given path 'member-service/v1/payment/create-order'
    * def orderData = {"content":{"address":{"blockHSENo":"<blockHSENo>","buildingName":"<buildingName>","floor":"<floor>","homeTelNo":"<homeTelNo>","postalCode":"<postalCode>","residentialStatus":"<residentialStatus>","street":"<street>","unit":"<unit>"},"user":{"status":"<status>","applicationSource":"<applicationSource>","bankAccountNumber":"<bankAccountNumber>","bankName":"<bankName>","companyBusinessNature":"<companyBusinessNature>","companyName":"<companyName>","dob":"<dob>","email":"<email>","emailVerified":"<emailVerified>","gender":"<gender>","highestEducationLevel":"<highestEducationLevel>","lastLogin":"#ignore","lastLoginReminderSent":"<lastLoginReminderSent>","maritalStatus":"<maritalStatus>","mobileNumber":"<mobileNumber>","mobileNumberVerified":"<mobileNumberVerified>","monthlyGrossSalary":"<monthlyGrossSalary>","name":"<name>","nricFin":"<nricFin>","occupation":"<occupation>","occupationalGroup":"<occupationalGroup>","officeTelNo":"<officeTelNo>","race":"<race>","scid":"<scid)"},"membership":{"createdBy":"<membership>","deletedBy":"<deletedBy>","deletedDttm":"#ignore","lastPaidDate":"#ignore","membershipTypeCode":"<membershipTypeCode>","modifiedBy":"<modifiedBy>","optInNebo":"<optInNebo>","relationship":"<relationship>","startDate":"#ignore","status":"<status>","unionCode":"<unionCode>","unionName":"<unionName>"}}}
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceCreateOrder.json")
    And request requestBody
    When method Post
    Then status 200
#    Then print response
    Then match response == orderData
    Examples:
      | read('ntuc_memberportal/resources/Response/member-serviceCreateOrder.json') |
