Feature: TestFeature

  Background: TestBackground
    * karate.start({mock: '_mock.feature', port: 8080})
    * url 'http://localhost:8080'

#  Background:
#    * def port = karate.env == 'mock' ? karate.start('_mock.feature').port : 9000
#    * URL 'http://localhost:' + port + '/'

# MEMBER-SERVICE-----------------------------------------------------------------------------

#  Create-Order API
  Scenario: TestScenario
    Given path '/api/member-service/v1/payment/create-order'
    When method get
    * print response.feeType
    * print response.serviceType

# NFM MEMBERSHIP-------------------------------------------------------------------------------

  #  Check if user has NFM main membership
  Scenario: NFM - Positive Scenario
    Given path '/api/member-service/v1/membership/nfm/main/2'
    When method get
    * print response.status

  Scenario: NFM - Main membership
    Given path '/api/member-service/v1/membership/nfm/main/scid=5'
    When method get
    * print response.status

  Scenario: NFM - Main membership - 401 method
    Given path '/api/member-service/v1/membership/nfm/main/scid=6'
    When method get
    * print response.errorDescription
    * print response.errorCode
