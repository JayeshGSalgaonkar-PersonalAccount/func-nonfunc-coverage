Feature: TestFeature

  Background: TestBackground
    * karate.start({mock: '_mock.feature', port: 9000})
    * url 'http://localhost:9000'
#-------------------------------------------------

  Scenario: Test 1
    Given path '/v1/cats/1'
    When method get
    Then status 201
    * print response

  Scenario: Test 2
    Given path 'greeting'
    When method get
    * def obj = get response[?(@.Id==7)]
    * print obj

  Scenario: Test 3
    Given path 'greeting'
    When method get
    * def obj = get response[?'\\Id\\:\\7']
    * print obj


#----------------------------------------------

  Scenario: MyInfo API
    Given url 'https://sandbox.api.myinfo.gov.sg/com/v3/person-sample/S9812381D'
    When method get
    * print response

