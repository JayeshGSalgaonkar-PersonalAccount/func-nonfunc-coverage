Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')
    * def val = function(max){ return "ESD344Z" + Math.floor(Math.random() * max)}

#-----------------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Valid Token)
    Given path 'notification-service/v1/user-notification'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def id = parseInt(id)
    * def userId = parseInt(userId)
    * def isRead = Boolean(~~isRead)
    * def notificationId = parseInt(notificationId)
    * def notificationSent = Boolean(~~notificationSent)
    * def notificationParameters = Boolean(~~notificationParameters)
    When method Get
    * print response
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/notification-serviceGetProfile.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceGetProfile.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#   Post
  Scenario Outline: PRODUCT BACKLOG - XX - POST register user-device(With Token)
    Given path 'notification-service/v1/user-device-token/register-device'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
#    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceDevice.json')
    * def requestBody =
  """
  {
  "deviceOS": "#(deviceOS)",
  "deviceToken": "#(val(100000))",
  }
  """
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceDevice.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#   Post
  Scenario Outline: PRODUCT BACKLOG - XX - Verify notification details
    Given path 'notification-service/v1/user-device-token/register-device/open'
    * def userId = parseInt(userId)
#    * def requestBody = read('ntuc_memberportal/resources/Request/notification-serviceRegisterDevice.json')
    * def requestBody =
  """
  {
  "deviceOS": "#(deviceOS)",
  "deviceToken": "#(val(100000))",
  "userId": "#(userId)"
  }
  """

    * print requestBody
    And request requestBody
    When method Post
    * print response
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceRegisterDevice.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM XX - POST request for notification-service (With Token)
    Given path 'notification-service/v1/user-notification'
    * def count = parseInt(count)
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/notification-servicePostNotf.json')
    And request requestBody
    When method Post
    * print response
    Then status 200
    Then match response.metadata.status == "SUCCESS"

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-servicePostNotf.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - XX
    Given path 'notification-service/v1/user-notification/<id>'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def isRead = Boolean(~~isRead)
    * def notificationId = parseInt(notificationId)
    * def notificationSent = Boolean(~~notificationSent)
    * def userId = parseInt(userId)
    When method Get
    Then status 200
    * def expectedResponse = read('ntuc_memberportal/resources/Response/notification-serviceGetNotifID.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/notification-serviceGetNotifID.csv') |
