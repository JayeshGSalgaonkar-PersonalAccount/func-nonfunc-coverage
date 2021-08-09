@user
Feature: User Micro-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expectedEducationLevelResponse = read("ntuc_memberportal/resources/Response/userStaticData.json")

Scenario:
  * print "RUN"