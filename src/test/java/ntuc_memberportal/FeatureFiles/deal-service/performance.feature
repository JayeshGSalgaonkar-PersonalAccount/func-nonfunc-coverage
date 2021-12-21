Feature: Deal-service
  This feature will test HTTP methods for Deals service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

#---------------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG - 1260 - Carousel
    Given path 'deal-service/v1/deals'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/deal-serviceDealID.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/deal-serviceDeal.csv') |

#---------------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG - 15 - Service
    Given path 'deal-service/v1/deals'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/deal-serviceDealID.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/deal-serviceDeal.csv') |
#---------------------------------------------------------------------------------------------------------------------
