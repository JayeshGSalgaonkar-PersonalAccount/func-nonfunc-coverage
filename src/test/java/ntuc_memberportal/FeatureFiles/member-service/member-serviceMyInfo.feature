@all
@member-service

Feature: My-Info Member-Service
  This feature will test HTTP methods for My-Info integration Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

#  GET
  Scenario Outline: PRODUCT BACKLOG - 368 Signup using MyInfo
    Given path 'member-service/v1/callback'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceMyInfo.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceMyInfo.csv') |

#   MyInfo API is not testable at API level