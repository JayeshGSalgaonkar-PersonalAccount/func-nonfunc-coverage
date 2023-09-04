# OUT OF SCOPE FOR AUTOMATION TESTING AS IT IS THIRD PARTY API
# Please keep below lines [4-13] un-commented for successful execution of scripts in the pipeline

@ignore
@all
@member-service

Feature: My-Info Member-Service
  This feature will test HTTP methods for My-Info integration Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
#
#  GET
#  Scenario Outline: PRODUCT BACKLOG - 368 Signup using MyInfo
#    Given path 'member-service/v1/callback'
#    When method Get
#    Then status 200
#    Then match response == read('memberportal/resources/Response/member-serviceMyInfo.json')
#    Examples:
#      | read('memberportal/resources/TestData_File/member-serviceMyInfo.csv') |
#
