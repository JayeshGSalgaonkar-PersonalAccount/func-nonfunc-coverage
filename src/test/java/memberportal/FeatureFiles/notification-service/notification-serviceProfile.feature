@all
@notification-service

Feature: Notification-service
  This feature will test HTTP methods for Notification service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#---------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Valid Token)
    Given path 'notification-service/v1/user-notification'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    * print response
    Then status 200
    * def expectedResponse = read('memberportal/resources/Response/notification-serviceGetProfile.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('memberportal/resources/TestData_File/notification-serviceGetProfile.csv') |

# ---------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - 11 - Verify Notification Template (with Valid Token)
    Given path 'notification-service/v1/notification/open'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * param userId = <userID>;
    * def id = parseInt(id)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('memberportal/resources/Response/notification-serviceOpenUser.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].type contains "PAYMENT_STATUS"
    Then match response.content[0].templateName contains expectedResponse.content[0].templateName
    Then match response.content[0].title contains "Your Union Membership application is successful!"
    Then match response.content[0].state contains "PUBLISH"
    Examples:
      | read('memberportal/resources/TestData_File/notification-serviceOpenUser.csv') |

#---------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - 11 - GET method to verify notification details (with Invalid Token)
    Given path 'notification-service/v1/user-notification'
    And header Authorization = 'Bearer ' + "XCDERFWRONGVALUE"
    When method Get
    Then status 401
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | status            | errorCode         | errorDescription |
      | "UNAUTHENTICATED" | "UNAUTHENTICATED" | "jwt malformed"  |

#---------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG - 458 Notification id
    Given path 'notification-service/v1/user-notification/<id>'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def isRead = Boolean(isRead)
    * def notificationId = parseInt(notificationId)
    * def notificationSent = Boolean(notificationSent)
    * def userId = parseInt(userId)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('memberportal/resources/Response/notification-serviceGetNotifID.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.notification.templateName == expectedResponse.content.notification.templateName
    Then match response.content.notification.title == expectedResponse.content.notification.title
    Then match response.content.notification.state == expectedResponse.content.notification.state
    Then match response.content.notification.message == expectedResponse.content.notification.message
    Then match response.content.notification.type == expectedResponse.content.notification.type
    Then match response.content.notification.shownIn == expectedResponse.content.notification.shownIn
    Then match response.content.isRead == expectedResponse.content.isRead
    Then match response.content.userId == expectedResponse.content.userId
    Then match response.content.notificationSent == expectedResponse.content.notificationSent
    Examples:
      | read('memberportal/resources/TestData_File/notification-serviceGetNotifID.csv') |

#--------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - 11 - NEGATIVE TEST (with Valid Token)
    Given path 'notification-service/v1/user-notification/<id>'
    * string user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | id    | status           | errorCode          | errorDescription                        | username            |
      | 10102 | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "Selected User Notification not found." | "ohklohk@gmail.com" |

# -----------------------------------------------------------------------------------------------------------------------
# POST
  Scenario Outline: PRODUCT BACKLOG ITEM 318 - POST request for READ notification-service (With Token)
    Given path 'notification-service/v1/user-notification/read'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody =
  """
  {
  "ids": "#(ids)",
  }
  """
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('memberportal/resources/TestData_File/notification-servicePostNotf.csv') |

#-----------------------------------------------------------------------------------------------------------------------
    # POST
  Scenario Outline: PRODUCT BACKLOG ITEM 318 - POST request for UNREAD notification-service (With Token)
    Given path 'notification-service/v1/user-notification/unread'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody =
  """
  {
  "ids": "#(ids)",
  }
  """
    And request requestBody
    When method Post
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('memberportal/resources/TestData_File/notification-servicePostNotf.csv') |

#-----------------------------------------------------------------------------------------------------------------------
# DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 141 : Delete
    Given path 'notification-service/v1/user-notification'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('memberportal/resources/Request/notification-serviceDelete.json')
    And request requestBody
    When method Delete
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('memberportal/resources/TestData_File/notification-serviceDelete.csv') |
