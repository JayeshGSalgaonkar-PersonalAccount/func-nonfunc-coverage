@ignore
Feature:

  Background:
    * def curId = 0
    * def nextId = function(){ return ~~curId++ }
    * def cats = {}

  Scenario: pathMatches('/v1/cats/{id}')
    * def responseStatus = 201
    * def obj = read('ntuc_memberportal/Mocks/test.json')
    * def response = obj.id

  Scenario: pathMatches('api/user-service/v1/postal-code/310145')
    * def responseStatus = 206
    * def response = { obj1 : "Sujit", obj2 : "Jayesh"}


  Scenario: pathMatches('/greeting')
    * json response = read('ntuc_memberportal/Mocks/test.json')