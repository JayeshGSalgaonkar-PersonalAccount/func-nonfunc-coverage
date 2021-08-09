@user
Feature: User Micro-service

Background:
  * url baseURL
  * header Accept = 'application/json'
  * def expectedEducationLevelResponse = read("ntuc_memberportal/resources/Response/userStaticData.json")

  # To GET response from User Static DATA micro-service and verify response for EDUCATION LEVEL
Scenario: PRODUCT BACKLOG ITEM 416 - 1
  Given path 'user-service/v1/user/static-data'
  * def expectedCode = ["NE","PR","LS","SE","NI","PS","DP","DG","PG","OT"]
  * def expectedValue = ["BELOW PRIMARY","PRIMARY","LOWER SECONDARY","GCE 'O' OR 'N' LEVEL","NTC / ITC","POST SEC. / GCE 'A' LEVEL","DIPLOMA","DEGREE","POST GRADUATE","OTHERS"]
  When method Get
  Then status 200
#    And print response.content.education_level
  * def code = get expectedEducationLevelResponse.content.education_level[*].code
  * def values = get expectedEducationLevelResponse.content.education_level[*].value
  Then match code == expectedCode
  Then match values == expectedValue

  # To GET response from User Static DATA micro-service and verify response for EDUCATION LEVEL
Scenario: PRODUCT BACKLOG ITEM 416 - 1
  Given path 'user-service/v1/user/static-data'
  * def expectedCode = ["NE","PR","LS","SE","NI","PS","DP","DG","PG","OT"]
  * def expectedValue = ["BELOW PRIMARY","PRIMARY","LOWER SECONDARY","GCE 'O' OR 'N' LEVEL","NTC / ITC","POST SEC. / GCE 'A' LEVEL","DIPLOMA","DEGREE","POST GRADUATE","OTHERS"]
  When method Get
  Then status 200
#    And print response.content.education_level
  * def code = get expectedEducationLevelResponse.content.education_level[*].code
  * def values = get expectedEducationLevelResponse.content.education_level[*].value
  Then match code == expectedCode
  Then match values == expectedValue
