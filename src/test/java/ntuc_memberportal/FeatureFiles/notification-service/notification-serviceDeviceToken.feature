@all
@notification-service

Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')
    * def val = function(max){ return "ESD344Z" + Math.floor(Math.random() * max)}

#-----------------------------------------------------------------------------------------------------------------------
#   Post Need to re-validate API (SUJIT to take action)
#  Scenario Outline: PRODUCT BACKLOG - 257 - Verify notification details
#    Given path 'notification-service/v1/user-device-token/register-device/open'
#    * def userId = parseInt(userId)
##    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceRegisterDevice.json')
#    * def requestBody =
#  """
#  {
#  "deviceOS": "#(deviceOS)",
#  "deviceToken": "#(val(100000))",
#  "userId": "#(userId)"
#  }
#  """
#    * print requestBody
#    And request requestBody
#    When method Post
#    * print response
#    Then status 200
#    Then match response.metadata.status == "SUCCESS"
#    Then match response.content == "done"
#    Examples:
#      | read('ntuc_memberportal/resources/TestData_File/notification-serviceRegisterDevice.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#   Post
  Scenario Outline: PRODUCT BACKLOG - 257 - POST register user-device(With Token)
    Given path 'notification-service/v1/user-device-token/register-device'
    * def user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceDevice.json')
    And request requestBody
    When method Post
    * print requestBody
    * print response
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceDevice.csv') |

#-----------------------------------------------------------------------------------------------------------------------