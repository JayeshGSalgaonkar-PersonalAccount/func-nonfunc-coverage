@all
@case-service

Feature: Case-Service
  This feature will test HTTP methods for Protection service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')
#    * def myFile = 'ntuc_memberportal/resources/TestData_File/image1.png'

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 237
    Given path 'protection-service/v1/case'
    * def user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceLogin.csv') |

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 237 NEGATIVE TEST (without File)
    Given path 'protection-service/v1/attachment/upload'
    * def id =
    """
    {id: '#(id)'}
    """
    And params id
    * def requestBody = read('ntuc_memberportal/resources/Response/protection-serviceFileUpload.json')
    And request requestBody
    When method Post
    Then status 400
    Then match response.metadata.status == "BAD_REQUEST"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/protection-serviceFileUpload.csv') |
