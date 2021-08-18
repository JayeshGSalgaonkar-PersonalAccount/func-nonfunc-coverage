@member-service @all

Feature: Member-Service (Linkpoints-Balance)

  This feature will test GET method for Linkpoints API under Member-service microservice.

  Background:
    * url baseURL
    * header Accept = 'application/json'

    #GET response and verify data from Response matches data from .csv file
  Scenario Outline: PRODUCT BACKLOG ITEM 5 - Validate GET method for Linkpoints-Balance under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    And def data = { balance: "<balance>", dollarValue: "<dollarValue>", expiryDate: "<expiryDate>", poolId: "<poolId>", poolName: "<poolName>", expiringBalance: "<expiringBalance>"}
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceLinkpoints.json')
#    * print data
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceLinkpoints.csv") |

#  GET response to verify data-type for Linkpoint service
  Scenario: PRODUCT BACKLOG ITEM 5 - Validate GET method for Linkpoints under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    When method Get
    Then status 200
    * print "responseStatus is = " + responseStatus
    * print "responseTime is = " + responseTime
    And print $.balance == #present
    And print $.dollarValue != #null
    And print $.poolID == #number && #present
    And print $.expiryDate != #null
    And print $.poolName == "LinkPoints"

