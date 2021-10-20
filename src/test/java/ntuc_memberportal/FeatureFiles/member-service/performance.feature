Feature: Member-Service (Eligibility)

  This feature will test HTTP methods for Eligibility API under Member-service microservice.

  Background:
    * url baseURL + 'member-service/v1/membership/check/active/'
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken

#  GET
  Scenario Outline: Eligibility under Member-service
    Given path '<NRIC>/<DOB>'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceEligibility.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceEligibility.csv") |

  Scenario Outline: Linkpoint-Balance under Member-service
    Given path 'member-service/v1/linkpoint/balance'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceLinkpoints.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceLinkpoints.csv") |

    #   GET
  Scenario Outline: Verify Membership details
    Given path 'member-service/v1/membership'
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceMemShip.json')
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceProfile.csv") |

#   GET
  Scenario Outline: Verify membership DRAFT details (with valid Token)
    Given path 'member-service/v1/membership/draft'
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response == read('ntuc_memberportal/resources/Response/member-serviceDraft.json')
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceDraft.csv') |

  Scenario Outline: CreateOrder under Member-service
    Given path 'member-service/v1/payment/create-order'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceCreateOrder.json")
    And request requestBody
    When method Post
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/member-serviceCreateOrder.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceCreateOrder.csv') |