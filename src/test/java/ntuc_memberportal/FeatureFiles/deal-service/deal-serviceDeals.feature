@all
@deal-service

Feature: Deal-service
  This feature will test HTTP methods for Deals service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'

#   GET
  Scenario Outline: PRODUCT BACKLOG - 1260 - Carousel
    Given path 'deal-service/v1/deals/carousel'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/deal-serviceCarousel.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content[0].merchant contains "LXP"
    Then match response.content[0].content contains "NTUC members can gain on-the-go access to over 75,000 courses at only $5 per month*!"
    Then match response.content[0].url == '#notnull'
    Then match response.content[0].image == '#notnull'
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/deal-serviceCarousel.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG - 15 - Carousel
    Given path 'deal-service/v1/deals'
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/deal-serviceDealID.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/deal-serviceDeal.csv') |

#-----------------------------------------------------------------------------------------------------------------------
