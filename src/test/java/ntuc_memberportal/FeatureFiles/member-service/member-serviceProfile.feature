@member-service @all

Feature: OA Member-Service
  This feature will test GET/POST HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

# GET
  Scenario Outline: GET
    Given path 'member-service/v1/membership'
    When method Get
    * def data = { unionName: "<unionName>",unionCode: "<unionCode>",status: "<status>",startDate: "<startDate>",relationship: "<relationship>",optInNebo: "<optInNebo>",modifiedDttm: "<modifiedDttm>",modifiedBy: "<modifiedBy>",membershipType: "<membershipType>",lastPaidDate: "<lastPaidDate>",deletedDttm: "<deletedDttm>",deletedBy: "<deletedBy>",createdDttm: "<createdDttm>",createdBy: "<createdBy>",}
    Then status 200
    Then print response
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceMemShip.json')
    * print data
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceGETResponse.csv") |

# POST method to verify user request is getting created
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - PUT request for member service
    Given path 'membership/create-order'
    * def memberData = {"content":{"address":{"blockHSENo":"<blockHSENo>","buildingName":"<buildingName>","floor":"<floor>","homeTelNo":"<homeTelNo>","postalCode":"<postalCode>","residentialStatus":"<residentialStatus>","street":"<street>","unit":"<unit>"},"user":{"status":"<status>","applicationSource":"<applicationSource>","bankAccountNumber":"<bankAccountNumber>","bankName":"<bankName>","companyBusinessNature":"<companyBusinessNature>","companyName":"<companyName>","dob":"<dob>","email":"<email>","emailVerified":"<emailVerified>","gender":"<gender>","highestEducationLevel":"<highestEducationLevel>","lastLogin":"#ignore","lastLoginReminderSent":"<lastLoginReminderSent>","maritalStatus":"<maritalStatus>","mobileNumber":"<mobileNumber>","mobileNumberVerified":"<mobileNumberVerified>","monthlyGrossSalary":"<monthlyGrossSalary>","name":"<name>","nricFin":"<nricFin>","occupation":"<occupation>","occupationalGroup":"<occupationalGroup>","officeTelNo":"<officeTelNo>","race":"<race>","scid":"<scid)"},"membership":{"createdBy":"<membership>","deletedBy":"<deletedBy>","deletedDttm":"#ignore","lastPaidDate":"#ignore","membershipTypeCode":"<membershipTypeCode>","modifiedBy":"<modifiedBy>","optInNebo":"<optInNebo>","relationship":"<relationship>","startDate":"#ignore","status":"<status>","unionCode":"<unionCode>","unionName":"<unionName>"}}}
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceRequest.json")
    And request requestBody
    When method Post
    Then status 200
#    Then print response
    Then match response == memberData
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePOSTResponse.csv') |

#  PUT method to verify user request is getting created
  Scenario Outline: PRODUCT BACKLOG ITEM 101 - PUT request for member service
    Given path 'membership/create-order'
    * def memberData = {"content":{"address":{"blockHSENo":"<blockHSENo>","buildingName":"<buildingName>","floor":"<floor>","homeTelNo":"<homeTelNo>","postalCode":"<postalCode>","residentialStatus":"<residentialStatus>","street":"<street>","unit":"<unit>"},"user":{"status":"<status>","applicationSource":"<applicationSource>","bankAccountNumber":"<bankAccountNumber>","bankName":"<bankName>","companyBusinessNature":"<companyBusinessNature>","companyName":"<companyName>","dob":"<dob>","email":"<email>","emailVerified":"<emailVerified>","gender":"<gender>","highestEducationLevel":"<highestEducationLevel>","lastLogin":"#ignore","lastLoginReminderSent":"<lastLoginReminderSent>","maritalStatus":"<maritalStatus>","mobileNumber":"<mobileNumber>","mobileNumberVerified":"<mobileNumberVerified>","monthlyGrossSalary":"<monthlyGrossSalary>","name":"<name>","nricFin":"<nricFin>","occupation":"<occupation>","occupationalGroup":"<occupationalGroup>","officeTelNo":"<officeTelNo>","race":"<race>","scid":"<scid)"},"membership":{"createdBy":"<membership>","deletedBy":"<deletedBy>","deletedDttm":"#ignore","lastPaidDate":"#ignore","membershipTypeCode":"<membershipTypeCode>","modifiedBy":"<modifiedBy>","optInNebo":"<optInNebo>","relationship":"<relationship>","startDate":"#ignore","status":"<status>","unionCode":"<unionCode>","unionName":"<unionName>"}}}
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceRequest.json")
    And request requestBody
    When method Put
    Then status 200
#    Then print response
    Then match response == memberData
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePUTResponse.csv') |