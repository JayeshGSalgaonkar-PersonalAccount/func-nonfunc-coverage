@membership
Feature: User Micro-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expected_XXX_Response = read("ntuc_memberportal/resources/Response/userStaticData.json")
