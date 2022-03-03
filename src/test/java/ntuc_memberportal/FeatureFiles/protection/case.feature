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
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceLogin.csv') |

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 1184
    Given path 'protection-service/v1/case/<id>'
    * def id = "<id>"
    * def user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/protection-serviceGETcaseId.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.id == expectedResponse.content.id
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/protection-serviceGETcaseId.csv') |

#------------------------------------------------------------------------------------------------------------
#  POST
  Scenario Outline: PRODUCT BACKLOG - 1184 Create Case
    Given path 'protection-service/v1/case/create'
    * def hasAttachment = Boolean(~~"hasAttachment")
    * def user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read("ntuc_memberportal/resources/Request/protection-servicePOSTcase.json")
    And request requestBody
    * print requestBody
    When method Post
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/protection-servicePOSTcase.json')
    Then match response.metadata.status == "SUCCESS"
    Then match response.content.CreateCaseResult.CaseType == expectedResponse.content.CreateCaseResult.CaseType
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/protection-servicePOSTcase.csv') |

#------------------------------------------------------------------------------------------------------------














































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

#------------------------------------------------------------------------------------------------------------
