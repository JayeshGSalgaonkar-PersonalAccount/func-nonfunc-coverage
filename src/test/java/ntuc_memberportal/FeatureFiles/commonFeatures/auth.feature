@all
@auth

Feature: Generate Auth token

  Background:
    * header Accept = 'application/json'
    * url 'https://devma.ntuc.org.sg/api/'
    * def staticToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlFUazVRVUV6TWpFME5EVkZNRFJFTVRRMk16WkRRVVF6UWtReFEwWXdRa1UyUkVRNFFUbEJPQSJ9.eyJodHRwczovL2NsYWltcy5pZGVudGl0eS5uZWRpZ2l0YWwuc2cvdWlkIjoiODM2OTE0NjAwOTE4MzUzNjYiLCJpc3MiOiJodHRwczovL3ByZXByb2QtYXV0aC5mYWlycHJpY2UuY29tLnNnLyIsInN1YiI6ImF1dGgwfGdvb2dsZS1vYXV0aDJ8MTE2NjM4OTMyOTM2OTk5ODQ2NjU0IiwiYXVkIjpbImh0dHBzOi8vaWQubnR1Y2xpbmsuY29tLnNnIiwiaHR0cHM6Ly9wcmVwcm9kLW5lLWlkLm5lZGlnaXRhbC5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNjI3NTMyNTkxLCJleHAiOjE2Mjc1MzM0OTEsImF6cCI6IjNxS3dQZ2VFQWFrdTVuVHkxNGEyenYzMUFqbWtWZTRyIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBzY2lkOnJlYWQ6cHJvZmlsZSBzY2lkOnVwZGF0ZTpwcm9maWxlIHNjaWQ6dXBkYXRlOnByZWZlcmVuY2VzIHNjaWQ6dmVyaWZ5Om15aW5mbyBzY2lkOnVwZGF0ZTphY2NvdW50X3NlY3VyaXR5IG9mZmxpbmVfYWNjZXNzIn0.oUYT8QDTqq-AJbNqJN30UrbytHkHDWB25AeMNSG0zM8u65x0Ee335GNPl-s9ilLBZIr3lQBUIc8q7YQwEPPpl7CajC5HjjnZQFfvGXxfhYS2Zr-GdQQbn1gPQsrr8QGfQSHIg3mZbidAl-MjSVHOvCo-SThQX6sxSnQ7_xuMy_OkFJQ0TfSc4qU0fUURYMqBfXyGZ36Q4RXjHWSwgfwoLZC8E25akmd9Q9X8N_hTijdXKJ9SaLlgxWBVp4E2owGt2FcX9krnoH7YUPKP-kze2KRV9aaDxKK-JVkBrwzFDD2kBnbx7UWixMg6rNegWS0dZoP_fDWDDNEJVVuS_eWJaQ"

  Scenario: first scenario
    Given path 'token'
#    And form field <word> = <string>
#    * def requestBody = read()
#    And request requestBody
    When method Get
#    Then status 200
    * print response

#    * def dyanicAccessToken = response.access_token
