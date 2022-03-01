@all
@user-service
Feature: User service (POSTAL CODE & Company search)

  Background:
    * url baseURL
    * header Accept = 'application/json'

#------------------------------------------------------------------------------------------------------------
#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 766 - Search Company name for OA Sign up
    Given path '/user-service/v1/company/ucem-upsert'
    * def requestBody = read("ntuc_memberportal/resources/Request/user-serviceUCEMUPSERT.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Then match response.content == true
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceUCEMUPCERT.csv') |

#    ------------------------------------------------------------------------------------------------------------