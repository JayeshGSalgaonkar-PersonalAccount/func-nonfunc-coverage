@all
@member-service

Feature: OA Member-Service
  This feature will test HTTP methods for Membership service to validate results

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def test_secret = read('classpath:Test_Secret.json')

#------------------------------------------------------------------------------------------------------------
#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - POST request for member service
    Given path 'member-service/v1/membership/open/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceOpenMemOA.json")
    And request requestBody
    * def email = '<email>'
    When method Post
    Then status 200
    * print response
    * def expectedResult = read("ntuc_memberportal/resources/Response/member-serviceOpenMemOA.json")
    Then match response.metadata.status == expectedResult.metadata.status
    Then match response.content.membership.membershipTypeCode == "OA"
    Then match response.content.membership.status == "DRAFT"
    * print response.content.user.email == email
    Then match response.content.user.race == "CN"
    Then match response.content.user.bankName == "DBS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceOpenMemOA.csv') |

#------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG - 142 GET method to verify membership details
    Given path 'member-service/v1/membership'
    * def user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * def expectedResponse = read("ntuc_memberportal/resources/Response/member-serviceMemShip.json")
    * print response.content.membershipTypeCode == expectedResponse.content
    * print response.content.nameOnCard == expectedResponse.content
    * print response.content.status == expectedResponse.content
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceMemShip.csv") |

#-----------------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG - 527 GET method to verify membership DRAFT details (VALID AUTH TOKEN)
    Given path 'member-service/v1/membership/draft'
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceDraft.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.membership[0].nameOnCard == expectedResponse.content.membership[0].nameOnCard
    Then match response.content.user.address.buildingName == expectedResponse.content.user.address.buildingName
    Then match response.content.user.address.unit == expectedResponse.content.user.address.unit
    Then match response.content.user.address.homeTelNo == expectedResponse.content.user.address.homeTelNo
    Then match response.content.user.address.blockHSENo == expectedResponse.content.user.address.blockHSENo
    Then match response.content.user.address.street == expectedResponse.content.user.address.street
    Then match response.content.user.address.residentialStatus == expectedResponse.content.user.address.residentialStatus
    Then match response.content.user.address.postalCode == expectedResponse.content.user.address.postalCode
    Then match response.content.user.address.floor == expectedResponse.content.user.address.floor
    Then match response.content.user.gender == expectedResponse.content.user.gender

    Then match response.content.user.race == expectedResponse.content.user.race
    Then match response.content.user.employmentType == expectedResponse.content.user.employmentType
    Then match response.content.user.nricFin == expectedResponse.content.user.nricFin
    Then match response.content.user.mobileNumber == expectedResponse.content.user.mobileNumber
    Then match response.content.user.bankName == expectedResponse.content.user.bankName
    Then match response.content.user.exchangeId == expectedResponse.content.user.exchangeId

    Then match response.content.user.occupationalGroup == expectedResponse.content.user.occupationalGroup
    Then match response.content.user.dob == expectedResponse.content.user.dob
    Then match response.content.user.bankAccountNumber == expectedResponse.content.user.bankAccountNumber
    Then match response.content.user.highestEducationLevel == expectedResponse.content.user.highestEducationLevel
    Then match response.content.user.officeTelNo == expectedResponse.content.user.officeTelNo
    Then match response.content.user.email == expectedResponse.content.user.email
    Then match response.content.user.maritalStatus == expectedResponse.content.user.maritalStatus
    Then match response.content.user.scid == expectedResponse.content.user.scid
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceDraft.csv') |

#--------------------------------------------------------------------------------------------------------------
# GET
  Scenario Outline: PRODUCT BACKLOG - 527 Verify DRAFT membership with NRIC and DOB details
    Given path 'member-service/v1/membership/draft/<nric>/<dob1>'
    * def monthlyGrossSalary = parseInt(monthlyGrossSalary)
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read("ntuc_memberportal/resources/Response/member-service2DRAFT.json")
    Then match response.content.membership[0].nameOnCard == expectedResponse.content.membership[0].nameOnCard
    Then match response.content.membership[0].status == expectedResponse.content.membership[0].status
    Then match response.content.membership[0].membershipTypeCode == expectedResponse.content.membership[0].membershipTypeCode
    Then match response.content.user.monthlyGrossSalary == expectedResponse.content.user.monthlyGrossSalary
    Then match response.content.user.occupation == expectedResponse.content.user.occupation
    Examples:
      | read("ntuc_memberportal/resources/TestData_File/member-serviceDraft2.csv") |

#--------------------------------------------------------------------------------------------------------------
#   Patch
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - Request for member service
    Given path 'member-service/v1/membership/oa/<MemID>'
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceMemOAPatch.json')
    And request requestBody
    When method Patch
    Then status 200
    * print response
    Then match response.metadata.status == "SUCCESS"
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-servicePUTRequest.csv') |

#--------------------------------------------------------------------------------------------------------------
#   GET
  Scenario Outline: PRODUCT BACKLOG 530 - Get all membership types the user can apply to.
    Given path 'member-service/v1/membership/memberships-can-apply'
    * string user = <username>
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    Then match response.content.types contains <Type>
    Then match response.metadata.status == <status>
    Examples:
      | Type | status    | username        |
      | "OA" | "SUCCESS" | "sha@yahoo.com" |

#--------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG 299 - OA Membership terms-and-conditions
    Given path 'member-service/v1/membership/OA/terms-and-conditions/'
    When method Get
    Then status 200
    And print response
    Then match response.metadata.status == <status>
    Then match response.content.version == <version>
    Then match response.content.content == <content>
    Examples:
      | status    | version | content                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | "SUCCESS" | "1"       | "<h2>Terms and conditions</h2>\n<p class=\"p1\">Union Membership refers to a range of membership types depending on the work status of the individual.<br>\n<br>\nNTUC reserves the right to assign successful applicants to an NTUC affiliated union/association. For a full list of affiliated unions/associations, please visit <a href=\"https://www.ntuc.org.sg\">www.ntuc.org.sg</a>. Upon approval, the member will automatically become a member of NTUC Club and NTUC FairPrice.<br>\n<br>\nMembership Fees# ($117 per year) </p>\n<ul class=\"ul1\">\n  <li class=\"li1\"><span class=\"s1\"></span>authorise NTUC or its nominated Agency(s) to obtain Membership Fees [current fees being $9 per month (Jan-Nov); $18 (Dec)] from me in accordance with the prevailing rates of union/association subscriptions. </li>\n</ul>\n<p class=\"p1\">Rules </p>\n<ul class=\"ul1\">\n  <li class=\"li1\"><span class=\"s1\"></span>observe all rules and regulations of NTUC, its affiliated unions/associations, NTUC Social Enterprises, by-laws of NTUC\u2019s cooperatives, and terms and conditions relating to membership benefits and programmes. </li>\n</ul>\n<p class=\"p1\">Transfer Between Membership Types </p>\n<ul class=\"ul1\">\n  <li class=\"li1\"><span class=\"s1\"></span>authorise NTUC and its affiliated unions/associations to assign and transfer my membership depending on eligibility and work status. </li>\n</ul>\n<p class=\"p1\">Loss and Replacement of the NTUC Plus! Card </p>\n<ul class=\"ul1\">\n  <li class=\"li1\"><span class=\"s1\"></span>make a payment of $3 to \u201CNTUC Link Pte Ltd\u201D for any loss or replacement of NTUC Plus! Card. </li>\n</ul>\n<p class=\"p1\">Notice of Termination </p>\n<ul class=\"ul1\">\n  <li class=\"li1\"><span class=\"s1\"></span>give 3 months\u2019 notice in writing for termination* of membership. </li>\n</ul>\n<p class=\"p1\">Collection, Use and Disclosure of Personal Data </p>\n<ol class=\"ol1\">\n  <li class=\"li1\">I consent to my personal data being collected, used and retained by NTUC and my union/association for the purposes of processing, administering and managing my membership.</li>\n  <li class=\"li1\">I acknowledge that the collection, use and/or disclosure of my NRIC/FIN number is necessary to accurately establish my identity to a high degree of fidelity in relation to \"NTUC Gift\", a group insurance policy exclusively for members of NTUC affiliated unions and associations; financial subsidies for skill upgrading and training under the Union Training Assistance Programme (UTAP) and an array of other services including but not limited to legal consultation, job placement and education grants.</li>\n  <li class=\"li1\">I consent to my personal data being disclosed amongst:<br>\na. NTUC and the affiliated union/association of which I will be a member for the purposes of managing my respective membership; and<br>\nb. NTUC/affiliated union/association, the Employment and Employability Institute, and NTUC Social Enterprises^<br>\nfor the purposes of managing and increasing membership benefits and privileges. </li>\n  <li class=\"li1\">I consent to be contacted by NTUC and my assigned union/association via email, text messages, phone calls, fax and/or post for matters relating to employment and employability, industrial relations, training and education, social and recreation as well as to give my opinion/feedback on such matters. </li>\n  <li class=\"li1\">For the purposes of industrial relations and employment-related issues, I consent to NTUC and my union obtaining my personal data and any relevant data relating to my employment from my employer.</li>\n  <li class=\"li1\">I will also keep NTUC and my assigned union/association informed immediately of any changes to my employment status or personal particulars that may affect my membership status and benefits. </li>\n  <li class=\"li1\">I understand that I am also applying for membership to the PLUS! Programme (\u201CPLUS!\u201D) administered by NTUC Link Private Limited (\u201CNTUC Link\u201D). I agree to abide by the terms and conditions of PLUS!<br>\nI acknowledge and consent to: -<br>\na. the collection, use and retention of my personal data by NTUC Link for the purposes of fulfilling, servicing and managing my PLUS! membership;<br>\nb. the disclosure of my personal data between NTUC/union/association and NTUC Link for the purposes of processing, servicing and managing my PLUS! membership; <br>\nc. the disclosure of my personal data by NTUC Link to its LinkPoints Partners/Merchants for the purposes of fulfilling, servicing and managing my PLUS! Membership; <br>\nd. I further consent to be notified by NTUC Link on benefits and privileges pertaining to PLUS! via email, text messages, mail and/or phone calls; and<br>\ne. I can visit <a href=\"https://www.plus.com.sg/\"> www.plus.com.sg </a> to manage my PLUS! membership (including withdrawal of consent) after my successful enrolment to PLUS! </li>\n  <li class=\"li1\">For any enquiries on personal data protection matters, please email to <a href=\"mailto:dpo@ntuc.org.sg\">dpo@ntuc.org.sg</a>. </li>\n</ol>\n<p class=\"p1\">NTUC FairPrice Membership </p>\n<p class=\"p1\">I understand that I will be automatically enrolled into NTUC FairPrice membership administered by NTUC FairPrice Co-operative Limited (\"NTUC FairPrice\") and that I will be eligible for NTUC FairPrice Rebate (\"rebates\") that are distributed annually. Under the \"Join-Now-Pay-Later\" scheme, the first $23 of rebates accumulated will be used to pay for the 20 shares (at $1 each) and $3 entrance fee. I hereby authorise NTUC FairPrice to credit my rebates into the bank account that I have provided. I consent to NTUC disclosing my personal particulars to NTUC FairPrice for the purpose of facilitating my NTUC FairPrice membership. I acknowledge that the maximum amount in purchases at NTUC FairPrice outlets entitled to rebate each financial year is $6,000 \u2013 the rate will be declared at the Annual General Meeting of NTUC FairPrice Cooperative Limited each year.</p>\n<p class=\"p1\">Sign-up Gift Eligibility </p>\n<ol class=\"ol1\">\n  <li class=\"li1\">New member(s) will be entitled to receive the Sign-up Gift upon payment of 6 month(s) of membership fees (non-refundable fees) and activation of Credit/Debit Card Recurring (CCR) arrangement for future membership fee deduction.<br>\na. New members shall mean applicants who are not existing members.<br>\nb. In addition, member(s) must not terminate his/her Membership within 6 month(s) of payment of the membership fees.</li>\n  <li class=\"li1\">The redemption letter for the Sign-up Gift will be mailed to the Member's address as recorded in NTUC's database, within 4 weeks upon approval of Credit/Debit Card Recurring (CCR) Payment arrangement and Membership application. </li>\n  <li class=\"li1\">New member(s) will not be eligible for the Sign-up Gift if he/she has redeemed any Sign-up Gift from Union Membership within 2 years prior to the date of collection of the Sign-up Gift.</li>\n  <li class=\"li1\">This promotion is not in conjunction with other ongoing promotions. </li>\n  <li class=\"li1\">This promotion is only applicable to Unions and union members participating in the General Branch (GB) programme. </li>\n  <li class=\"li1\">While stocks last. </li>\n  <li class=\"li1\">NTUC reserves the right in its sole and absolute discretion to replace the Sign-up Gift at any time with one or more item(s) of equivalent value (such value to be determined by NTUC in its sole and absolute discretion) without having to give any prior notice or reason for such replacement. </li>\n  <li class=\"li1\">In the event of a dispute, NTUC's decision is final. </li>\n</ol>\n<p class=\"p2\"><br></p>\n<p class=\"p1\">#The cycle repeats automatically for the following year.<br>\n*Termination notice may differ for some unions. If you have chosen to receive a sign-up gift, you would be required to fulfil the minimum membership period before giving the notice of termination.<br>\n^For the list of NTUC Social Enterprises, please refer to <a href=\"http://ntucsocialenterprises.sg/\"><span class=\"s2\">ntucsocialenterprises.sg</span></a>. </p>" |

#--------------------------------------------------------------------------------------------------------------
#    GET
  Scenario Outline: PRODUCT BACKLOG 299 - NEGATIVE TEST
    Given path 'member-service/v1/membership/<type>/terms-and-conditions/'
    When method Get
    Then status 400
    Then match response.metadata.status == <status>
    Then match response.content.errorCode == <errorCode>
    Then match response.content.errorDescription == <errorDescription>
    Examples:
      | type | status        | errorCode          | errorDescription                                                    |
      | OAA  | "BAD_REQUEST" | "VALIDATION_ERROR" | "Caught Validation Error for /membership/OAA/terms-and-conditions/" |

#--------------------------------------------------------------------------------------------------------------
##   PUT
#  Scenario Outline: PRODUCT BACKLOG 299 - Accept Terms and Condition
#    Given path 'member-service/v1/membership/<membershipId>/terms-and-conditions/accept'
#    * def membershipId = parseInt(membershipId)
#    * def agreed = Boolean(agreed)
#    * def requestBody = read('ntuc_memberportal/resources/Request/member-serviceTCAccept.json')
#    And request requestBody
#    When method Put
#    Then status 200
#    Then match response == read('ntuc_memberportal/resources/Response/member-serviceTCAccept.json')
#    Examples:
#      | read('ntuc_memberportal/resources/TestData_File/member-serviceTCAccept.csv') |

#--------------------------------------------------------------------------------------------------------------
#  POST
  Scenario Outline: PRODUCT BACKLOG ITEM 142 - NEGATIVE SCENARIO
    Given path 'member-service/v1/membership/open/oa'
    * def requestBody = read("ntuc_memberportal/resources/Request/member-serviceOpenMemOA.json")
    And request requestBody
    When method Post
    * print requestBody
    Then status 409
    Then match response.metadata.status == "CONFLICT"
    Then match response.content.errorCode == "RECORD_EXISTS_DRAFT"
    Then match response.content.errorDescription == "Existing OA membership in draft, please retrieve the draft."
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceOpenMemOA.csv') |

#-----------------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG 1214 - Retrieve Membership status details i.e. Active or DRAFT status
    Given path 'member-service/v1/membership/has-draft-or-active-membership'
    * string user = username
    * def hasDraft = Boolean(~hasDraft)
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceDraftOrActive.json')
    * print expectedResponse
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.hasDraft == expectedResponse.content.hasDraft

    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceDraftOrActive.csv') |

#--------------------------------------------------------------------------------------------------------------
#  GET
  Scenario Outline: PRODUCT BACKLOG 143 - Membership Association
    Given path 'member-service/v1/membership/membershipAssociation'
    * param last4Nric = last4Nric
    * param dob = dob
    * param mobile = mobile
    * string user = username
    * def secret = test_secret[user]
    * def setup = call read('../commonFeatures/auth.feature')
    * def dynamicAccessToken = setup.dynamicAccessToken
    And header Authorization = 'Bearer ' + dynamicAccessToken
    When method Get
    Then status 200
    * print response
    * def expectedResponse = read('ntuc_memberportal/resources/Response/member-serviceAssociation.json')
    Then match response.metadata.status == expectedResponse.metadata.status
    Then match response.content.phone[0] == expectedResponse.content.phone[0]
    Then match response.content.email[0] == expectedResponse.content.email[0]
    Examples:
      | read('ntuc_memberportal/resources/TestData_File/member-serviceAssociation.csv') |
#--------------------------------------------------------------------------------------------------------------
