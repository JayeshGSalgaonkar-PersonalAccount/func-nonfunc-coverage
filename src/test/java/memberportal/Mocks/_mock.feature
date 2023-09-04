@ignore
Feature:

  Background:
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }

  Scenario: pathMatches('/api/member-service/v1/payment/create-order')
    * def responseStatus = 200
    * def response = { feeType: "OUTSTANDING", endDate: "02022021", startDate: "01012021",serviceType: "SIGN_UP",amount: "100",isOneTimePayment: true,isRecurringPayment:true,membershipId:1}

  Scenario: pathMatches('/api/member-service/v1/membership/nfm/main/2')
    * def responseStatus = 200
    * def response = {status: "SUCCESS"}

  Scenario: pathMatches('/api/member-service/v1/membership/nfm/main/scid=5')
    * def responseStatus = 200
    * def response = {status: "SUCCESS"}

  Scenario: pathMatches('/api/member-service/v1/membership/nfm/main/scid=6')
    * def responseStatus = 401
    * def response = {errorCode: "RECORD_NOT_FOUND", errorDescription: "Not Valid"}