Feature: JWT Feature
  Background: JWT Background
    * def test_secret = read('classpath:Test_Secret.json')
    * def user = 'ishsh@hotmail.com'
    * def secret = test_secret[user]


  Scenario: JWT Scenario
    Given url 'https://preprod-auth.ntuclink.com.sg/oauth/token'
    And form field audience = "https://api.ntucmp.org.sg"
    And form field client_id = "8TmhK0rYCJfamFt96L8yi9eUa2wOMlel"
    And form field grant_type = "http://auth0.com/oauth/grant-type/password-realm"
    And form field username = user
    And form field password = secret
    And form field realm = "NE-Digital-ID-Platform-Connection"
    And form field scope = "openid profile scid:read:profile scid:update:profile scid:update:preferences scid:verify:myinfo scid:update:account_security offline_access"
    When method post
    Then status 200

    * def dynamicAccessToken = response.access_token
    * print dynamicAccessToken


