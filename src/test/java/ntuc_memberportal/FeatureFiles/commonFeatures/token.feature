Feature: Token Feature
  Background: Token Background
    * def test_secret = read('classpath:Test_Secret.json')
    * def user1 = 'asgopal@sg.palo-it.com'
    * def user2 = 'ishsh@hotmail.com'

  Scenario: Token Scenario 1
    Given url 'https://preprod-auth.ntuclink.com.sg/oauth/token'
    And form field audience = "https://api.ntucmp.org.sg"
    And form field client_id = "71zXmrAvrnQDDNCAhh417AgFwqIm8gDO"
    And form field grant_type = "http://auth0.com/oauth/grant-type/password-realm"
    And form field username = user1
    And form field password = test_secret[user1]
    And form field realm = "NE-Digital-ID-Platform-Connection"
    And form field scope = "openid profile scid:read:profile scid:update:profile scid:update:preferences scid:verify:myinfo scid:update:account_security offline_access"
    When method post
    Then status 200

    * def dynamicAccessToken_user1 = response.access_token
    * print dynamicAccessToken_user1

  Scenario: Token Scenario 2
    Given url 'https://preprod-auth.ntuclink.com.sg/oauth/token'
    And form field audience = "https://api.ntucmp.org.sg"
    And form field client_id = "71zXmrAvrnQDDNCAhh417AgFwqIm8gDO"
    And form field grant_type = "http://auth0.com/oauth/grant-type/password-realm"
    And form field username = user2
    And form field password = test_secret[user2]
    And form field realm = "NE-Digital-ID-Platform-Connection"
    And form field scope = "openid profile scid:read:profile scid:update:profile scid:update:preferences scid:verify:myinfo scid:update:account_security offline_access"
    When method post
    Then status 200
    * def dynamicAccessToken_user2 = response.access_token
    * print dynamicAccessToken_user2