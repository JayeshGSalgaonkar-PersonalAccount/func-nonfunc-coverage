@all
@user-service

Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken2 = setup.dynamicAccessToken2

#  GET
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate User Static details
    Given path 'user-service/v1/user/static-data'
    When method Get
    Then status 200
    Then match response == read("ntuc_memberportal/resources/Response/user-serviceStaticData.json")

#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 417 - Verify user GET method via SCID
    Given path 'user-service/v1/user/userId/<scid>'
    * def id = parseInt(id)
    When method Get
    Then status 200
    And print response
    And match response == read("ntuc_memberportal/resources/Response/user-serviceSCID.json")
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/user-serviceSCID.csv") |

#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE TEST
    Given path 'user-service/v1/user/userId/<SCID>'
    When method Get
    Then status 400
    Then match $.metadata.status == <expected_status>
    And match $.content.errorDescription == <expected_errorDescription>
    And match $.content.errorCode == <expected_errorCode>
    Examples:
      | SCID | expected_status  | expected_errorCode | expected_errorDescription |
      | 1    | "BUSINESS_ERROR" | "RECORD_NOT_FOUND" | "No matching user found"  |

#   POST
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Create User-Profile (With Token)
    Given path 'user-service/v1/user'
    # This scenario will always has static SCID, as we need a SCID which is already present inside the DB for this query to run
    And header Authorization = 'Bearer ' + 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlFUazVRVUV6TWpFME5EVkZNRFJFTVRRMk16WkRRVVF6UWtReFEwWXdRa1UyUkVRNFFUbEJPQSJ9.eyJodHRwczovL2NsYWltcy5pZGVudGl0eS5uZWRpZ2l0YWwuc2cvdWlkIjoiMTAxMzI1NzcxNjEwNDQ2MzkxIiwiaXNzIjoiaHR0cHM6Ly9wcmVwcm9kLWF1dGgubnR1Y2xpbmsuY29tLnNnLyIsInN1YiI6ImF1dGgwfDYxNmZkOWViNzU1NWVkMTU1MDRlYjc5ZSIsImF1ZCI6WyJodHRwczovL2FwaS5udHVjbXAub3JnLnNnIiwiaHR0cHM6Ly9wcmVwcm9kLW5lLWlkLm5lZGlnaXRhbC5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNjM1MzE0Njc4LCJleHAiOjE2MzUzMjkwNzgsImF6cCI6IjcxelhtckF2cm5RREROQ0FoaDQxN0FnRndxSW04Z0RPIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBzY2lkOnJlYWQ6cHJvZmlsZSBzY2lkOnVwZGF0ZTpwcm9maWxlIHNjaWQ6dXBkYXRlOnByZWZlcmVuY2VzIHNjaWQ6dmVyaWZ5Om15aW5mbyBzY2lkOnVwZGF0ZTphY2NvdW50X3NlY3VyaXR5IG9mZmxpbmVfYWNjZXNzIiwiZ3R5IjoicGFzc3dvcmQifQ.HQ2S9E_HCTbdzLkYjGIgRE2ioG2t5xOfiFaiKNzI_g3s-aorVW57PiGY6xPcnseEG5ffMfZbZCfaMPRTRq1MaNgyF5UOr_MEIj2mx4jgYlnQ3YbmFVRn0QOszc6EQhRKUOvwYVZBjXwsdySzXdLc655zgoQbPqZ8byztel3mzGPY3v67w8ByB3qUpSK5SJCDhnUgs6he9UfFc31OCsUcs-vE1Q-w10eAaxhxnhMQBCJoRs75q7Jg5qj_K7l7spBqsx-TrVPe-I0ItpqNSTbMqI9vhu7HpJSJ0RTZWRJtNe-dvN4Q4XRTyZQITHuVt4A-LoUaAY5sUUk_0IKL6yx9wg'
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    * def requestBody = read('ntuc_memberportal/resources/Request/user-serviceUser.json')
    And request requestBody
    When method Post
    Then status 200
    Then match response.content.monthlyGrossSalary == requestBody.monthlyGrossSalary
    Then match response.content.name == requestBody.name
    Then match response.content.dob == requestBody.dob
    Then match response.content.gender == requestBody.gender
    Then match response.content.mobileNumber == requestBody.mobileNumber
    Then match response.content.email == requestBody.email
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceUser.csv') |

#    POST
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - NEGATIVE TEST (With Token)
    Given path 'user-service/v1/user'
    And header Authorization = 'Bearer ' + dynamicAccessToken2
    * def requestBody = read('ntuc_memberportal/resources/Request/user-serviceProfile.json')
    And request requestBody
    When method Post
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorDescription == <errorDescription>
    Then match response.errorCode == <errorCode>
    Examples:
      | status        | errorDescription                    | errorCode |                                                                           |
      | "BAD_REQUEST" | "Caught Validation Error for /user" | null      | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') |

#   DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method via USERID
    Given path 'user-service/v1/user'
    And header Authorization = 'Bearer ' + dynamicAccessToken2
    When method Delete
    And print response
    Then status 200
    Then match response == read ("ntuc_memberportal/resources/Response/user-serviceDelete.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceDeleteUser.csv') |

#    PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Edit User-Profile (With Token)
    Given path 'user-service/v1/user'
    And header Authorization = 'Bearer ' + dynamicAccessToken2
    * def requestBody = read('ntuc_memberportal/resources/Request/user-servicePutProfile.json')
    And request requestBody
    * print requestBody
    When method Put
    Then status 200
    Then match response.content.homeTelNo == request.homeTelNo
    Then match response.content.buildingName == request.buildingName
    Then match response.content.street == request.street
    Then match response.content.unit == request.unit
    Then match response.content.floor == request.floor
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceProfile.csv') |

#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 299 - User Login
    Given path 'user-service/v1/user/login'
    And header Authorization = 'Bearer ' + dynamicAccessToken2
    * def requestBody = ""
    And request requestBody
    When method Post
    And print response
    Then status 200
    And match response == read("ntuc_memberportal/resources/Response/user-serviceLogin.json")
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceLogin.csv') |

