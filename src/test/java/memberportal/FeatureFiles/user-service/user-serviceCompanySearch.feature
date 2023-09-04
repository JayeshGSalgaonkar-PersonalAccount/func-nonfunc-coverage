@all
@user-service

Feature: User service (Company search)

  Background:
    * url baseURL
    * header Accept = 'application/json'


#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG ITEM 766 - Company Search
    Given path 'user-service/v1/company/search'
    * def search =
    """
    {q: '#(name)'}
    """
    And params search
    When method Get
    Then status 200
    * def expected = read("ntuc_memberportal/resources/Response/user-serviceCompanyName.json")
    Then match response contains any expected
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/user-serviceCompanyName.csv') |

#------------------------------------------------------------------------------------------------------------