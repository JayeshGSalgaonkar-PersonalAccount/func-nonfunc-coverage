@user @all
Feature: User-service

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def expectedResponse = read("ntuc_memberportal/resources/Response/userStaticData.json")

    # To GET response from User Static DATA micro-service and verify response for EDUCATION LEVEL
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate Education details of the user
    Given path 'user-service/v1/user/static-data'
    * def expectedCode = ["NE","PR","LS","SE","NI","PS","DP","DG","PG","OT"]
    * def expectedValue = ["BELOW PRIMARY","PRIMARY","LOWER SECONDARY","GCE 'O' OR 'N' LEVEL","NTC / ITC","POST SEC. / GCE 'A' LEVEL","DIPLOMA","DEGREE","POST GRADUATE","OTHERS"]
    When method Get
    Then status 200
#    And print response.content.education_level
    * def educationCode = get expectedResponse.content.education_level[*].code
    * def educationValue = get expectedResponse.content.education_level[*].value
    Then match educationCode == expectedCode
    Then match educationValue == expectedValue

    # To GET response from User Static DATA micro-service and verify response for MARITAL STATUS
  Scenario:  PRODUCT BACKLOG ITEM 372 - Validate Marital details of the user
    Given path 'user-service/v1/user/static-data'
    When method Get
    * def expectedMaritalCODE = ["DEFAULT","S","M","P","D","W"]
    * def expectedMaritalVALUE = ["Marital Status","SINGLE","MARRIED","SEPERATED","DIVORCED","WIDOWED"]
    Then status 200
#    And print response.content.education_level
    * def maritalCode = get expectedResponse.content.marital_status[*].code
    * def maritalValue = get expectedResponse.content.marital_status[*].value
    Then match maritalCode == expectedMaritalCODE
    Then match maritalValue == expectedMaritalVALUE

     # To GET response from User Static DATA micro-service and verify response for RACE
  Scenario:  PRODUCT BACKLOG ITEM 372 - Validate Race details of the user
    Given path 'user-service/v1/user/static-data'
    When method Get
    * def expectedRaceCODE = ["CN","MY","IN","OT","EU"]
    * def expectedRaceVALUE = ["CHINESE","MALAY","INDIAN","OTHERS","EURASIAN"]
    Then status 200
#    And print response.content.education_level
    * def raceCode = get expectedResponse.content.race[*].code
    * def raceValue = get expectedResponse.content.race[*].value
    Then match raceCode == expectedRaceCODE
    Then match raceValue == expectedRaceVALUE

     # To GET response from User Static DATA micro-service and verify response for Residential_status
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate Race details of the user
    Given path 'user-service/v1/user/static-data'
    When method Get
    * def expectedResidentialCODE = ["SC","EP","PR","WP"]
    * def expectedResidentialVALUE = ["SINGAPORE CITIZEN","EMPLOYMENT PASS HOLDER","PERMANENT RESIDENT","WORK PERMIT HOLDER"]
    Then status 200
#    And print response.content.education_level
    * def residentialCode = get expectedResponse.content.residential_status[*].code
    * def residentialValue = get expectedResponse.content.residential_status[*].value
    Then match residentialCode == expectedResidentialCODE
    Then match residentialValue == expectedResidentialVALUE

    # To GET response from User Static DATA micro-service and verify response for BANK
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate Race details of the user
    Given path 'user-service/v1/user/static-data'
    When method Get
    * def expectedBankCODE = ["7010","8828","7454","8253","8217","7931","8411","7047","7065","7083","7108","8129","7117","8855","7418","7135","9025","9043","7986","7214","8606","7171","7463","8581","7737","7393","7199","7764","8697","7409","7287","8864","9186","7241","7250","8712","8509","7153","8703","7490","8785","7302","8235","7621","7427","8156","8518","2000","3000","7339","8749","7056","7870","8439","9034","7366","8615","9999","8527","7852","7038","7144","7791","7472","8837","7092","7658","8846","7126","7232","8934","8475","8280","8688","8800","7685","7357","8110","7375"]
    * def expectedBankVALUE = ["ABN AMRO BANK NV","ABSA BANK LTD","AMERICAN EXPRESS BANK LTD","ARAB BANK PLC","ARAB BANKING CORPORATION BSC","AUSTRALIA AND NEW ZEALAND BANKING GROUP LIMITED","BANCA MONTE DEI PASCHI DI SIENA S.P.A.","BANGKOK BANK PUBLIC COMPANY LTD","BANK OF AMERICA, NA","BANK OF CHINA LIMITED","BANK OF INDIA","BANK OF NEW ZEALAND","BANK OF SINGAPORE LTD","BAYERISCHE HYPOUND VEREINSBANK AKTIENGESELLSCHAFT","BNP PARIBAS","CALYON","CHANG HWA COMMERCIAL BANK LTD","CHINA CONSTRUCTION BANK","CIMB BANK BERHAD","CITIBANK NA","COMMERZBANK AKTIENGESELLSCHAFT","DBS BANK LTD/POST OFFICE SAVINGS BANK (DBS/POSBANK)","DEUTSCHE BANK AG","DEXIA BANQUE INTERNATIONALE A LUXEMBOURG","DNB NOR BANK ASA","DRESDNER BANK AG","FAR EASTERN BANK LTD (FEB)","FIRST COMMERCIAL BANK","FORTIS BANK (NEDERLAND) N.V.","HABIB BANK LTD","HL BANK","HUA NAN COMMERCIAL BANK, LTD","ICICI BANK LIMITED","INDIAN BANK","INDIAN OVERSEAS BANK","INDUSTRIAL & COMMERCIAL BANK OF CHINA","ING BANK N.V.","JPMORGAN CHASE BANK, N.A.","KBC BANK N.V.","KOREA EXCHANGE BANK","KRUNG THAI BANK PCL","MALAYAN BANKING BERHAD","MEGA INTERNATIONAL COMMERCIAL BANK (SINGAPORE BRANCH)","MIZUHO CORPORATE BANK LTD","MOSCOW NARODNY BANK LTD","NATEXIS BANQUES POPULAIRES","NORDEA BANK FINLAND PLC","NTUC","NTUC","OVERSEA-CHINESE BANKING CORPORATION LTD (OCBC)","P.T. BANK MANDIRI (PERSERO)","P.T. BANK NEGARA INDONESIA (PERSERO) TBK","PHILIPPINE NATIONAL BANK","RABOBANK","RAIFFEISEN ZENTRALBANK OSTERREICH AG","RHB BANK BERHAD","SHINHAN BANK","SINGAPORE POST","SKANDINAVISKA ENSKILDA BANKEN","SOCIETE GENERALE","SOUTHERN BANK BERHAD","STANDARD CHARTERED BANK","STATE BANK OF INDIA","SUMITOMO MITSUI BANKING CORPORATION","THE AGRICULTURAL BANK OF CHINA","THE BANK OF EAST ASIA LTD","THE BANK OF NOVA SCOTIA","THE BANK OF TAIWAN","THE BANK OF TOKYOMITSUBISHI UFJ, LTD","THE HONGKONG & SHANGHAI BANKING CORPORATION LTD (HSBC)","THE KOREA DEVELOPMENT BANK","THE MITSUBISHI TRUST & BANKING CORPN","THE NATIONAL BANK OF KUWAIT SAK","THE NORINCHUKIN BANK","THE SIAM COMMERCIAL BANK PCL","UBS AG","UCO BANK","UNION DE BANQUES ARABES ET FRANCAISES","UNITED OVERSEAS BANK (UOB)"]
    Then status 200
#    And print response.content.education_level
    * def bankCode = get expectedResponse.content.bank[*].code
    * def bankValue = get expectedResponse.content.bank[*].value
    Then match bankCode == expectedBankCODE
    Then match bankValue == expectedBankVALUE

    # To GET response from User Static DATA micro-service and verify response for Monthly_Income
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate Race details of the user
    Given path 'user-service/v1/user/static-data'
    When method Get
    * def expectedMonthlyIncomeCODE = ["3","4","6","8","10","15","20","25","30","40","45","50","60","80","99"]
    * def expectedMonthlyIncomeVALUE = ["BELOW $400","$400-$599","$600-$799","$800-$999","$1000 - $1499","$1500 - $1999","$2000 - $2499","$2500 - $2999","$3000 - $3999","$4000 - $4500","$4501 - $4999","$5000 - $5999","$6000 - $7999","$8000 - $9999","$10000 & ABOVE"]
    Then status 200
#    And print response.content.education_level
    * def incomeCode = get expectedResponse.content.monthly_income[*].code
    * def incomeValue = get expectedResponse.content.monthly_income[*].value
    Then match incomeCode == expectedMonthlyIncomeCODE
    Then match incomeValue == expectedMonthlyIncomeVALUE

     # To GET response from User Static DATA micro-service and verify response for Occupation_Group
  Scenario: PRODUCT BACKLOG ITEM 372 - Validate Occupation Group details of the user
    Given path 'user-service/v1/user/static-data'
    When method Get
    * def expectedGroupCODE = ["MG","PF01","PF02","PF03","PF04","PF05","PF06","PF07","PF08","PF09","PF10","PF11","PF12","PF13","PF99","AP01","AP02","AP03","AP04","AP05","AP06","AP07","AP08","AP09","AP10","AP11","AP12","AP13","AP14","AP15","AP16","AP17","AP99","CL","SV","AG","PD","OP","LB","OT01","OT02","OT03","OT","OT04","GS","FL01","FL02","FL03"]
    * def expectedGroupVALUE = ["MANAGERIAL - COMPANY MANAGER\/DIRECTOR, PROPRIETOR, OFFICIAL","PROFESSIONAL - PHYSICAL SCIENCE","PROFESSIONAL - STATISTICIAN, MATHEMATICIAN, RESEARCH ANALYST","PROFESSIONAL - INFORMATION TECHNOLOGY","PROFESSIONAL - ENGINEER, ARCHITECT, TOWN PLANNER, SURVEYOR","PROFESSIONAL - LIFE SCIENCE","PROFESSIONAL - HEALTH (DOCTOR, PHYSICIAN, SURGEON, DENTIST, ETC.)","PROFESSIONAL - TEACHING (UNI\/POLY\/PRI\/SEC SCHOOL)","PROFESSIONAL - BUSINESS, FINANCE","PROFESSIONAL - LEGAL","PROFESSIONAL - LIBRARIAN, ARCHIVIST, CURATOR","PROFESSIONAL - SOCIAL\/POLITICAL SCIENCE, HISTORIAN","PROFESSIONAL - ARTIST\/WRITER","PROFESSIONAL - RELIGIOUS","PROFESSIONAL - OTHERS","SEMI-PROFESSIONAL - ENGINEER ASSISTANT","SEMI-PROFESSIONAL - TECHNICIAN - PHYSICAL SCIENCE","SEMI-PROFESSIONAL - TECHNICIAN - BUILDING\/ENGINEERING","SEMI-PROFESSIONAL - COMPUTER SYSTEMS OPERATOR","SEMI-PROFESSIONAL - OPTICAL\/PHOTO\/ELECTRONIC EQUIP. OPERATOR","SEMI-PROFESSIONAL - TRAFFIC CONTROLLER, TECHNICIAN","SEMI-PROFESSIONAL - BUILDING SAFETY\/HEALTH INSPECTOR","SEMI-PROFESSIONAL - TECHNICIAN - LIFE SCIENCE","SEMI-PROFESSIONAL - HEALTH (NURSE, OPTICIAN, THERAPIST, ETC.)","SEMI-PROFESSIONAL - TEACHING (PRE-PRIMARY\/ECA\/PRIVATE)","SEMI-PROFESSIONAL - FINANCE\/SALES\/REAL ESTATE","SEMI-PROFESSIONAL - GOVERNMENT","SEMI-PROFESSIONAL - ADMINISTRATIVE\/STATISTICAL","SEMI-PROFESSIONAL - SOCIAL WORK","SEMI-PROFESSIONAL - TRANSLATOR\/INTERPRETER","SEMI-PROFESSIONAL - ART, ENTERTAINMENT, SPORTS","SEMI-PROFESSIONAL - RELIGIOUS (NON-ORDAINED)","SEMI-PROFESSIONAL - OTHERS","CLERICAL WORKER ","SERVICE WORKER, SHOP\/MARKET SALES WORKER","AGRICULTURAL\/FISHERY WORKER","PRODUCTION CRAFTSMAN (ELECTRICIAN, FOREMAN, TAILOR, ETC.)","PLANT\/MACHINE OPERATOR, VEHICLE DRIVER, SEAMAN","CLEANER, LABOURER","RETIRED","HOUSEWIFE","UNIFORMED GROUP (SAF, AIR FORCE, NAVY, SCDF, MINDEF, DSTA)","UNCLASSIFIABLE","UNEMPLOYED\/RETRENCHED","OTHERS \u2013 GRADUATING STUDENTS","FREELANCER - MEDIA PROFESSIONALS","FREELANCER - OTHERS","FREELANCER - SPORT COACHES\/TRAINERS"],
    Then status 200
#    And print response.content.education_level
    * def groupCode = get expectedResponse.content.occupation_group[*].code
    * def groupValue = get expectedResponse.content.occupation_group[*].value
    Then match groupCode == expectedGroupCODE
    Then match groupValue == expectedGroupVALUE

  Scenario Outline: PRODUCT BACKLOG ITEM 417 - Verify user GET method via SCID
    Given path 'user-service/v1/user/scid'
    When method Get
    Then status 200
    Then match response.metadata.status == "SUCCESS"
    And match response.content.scid == <expected_scid>
    Examples:
      | scid | expected_scid |
      | 999  | 999           |

  Scenario Outline: PRODUCT BACKLOG ITEM 416 - - Verify user GET method via SCID
    Given path 'user-service/v1/user/scid/SCID'
    When method Get
    Then status 400
    Then match response.metadata.status == expected_status
    And match response.content.errorCode == expected_errorCode
    And match response.content.errorDescription == expected_errorDescription
    Examples:
      | SCID | expected_status | expected_errorCode | expected_errorDescription |
      | 1    | BUSINESS_ERROR  | RECORD_NOT_FOUND   | No matching user found    |

  #DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method via USERID
    Given path 'user-service/v1/user/id'
    When method Delete
    Then status 204
    Then print response.metadata.status == "SUCCESS"
    Examples:
      | id |
      | 1  |

  #DELETE
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method with incorrect  USERID
    Given path 'user-service/v1/user/id'
    When method Delete
    Then status 400
    Then print response.metadata.status == "BUSINESS_ERROR"
    Then print response.content.errorDescription == "Error while deleting user"
    Examples:
      | id  |
      | 999 |

  #PUT
  Scenario Outline: PRODUCT BACKLOG ITEM 416 - Verify user DELETE method with incorrect  USERID
    Given path 'user-service/v1/user/id'
    And def requestBody = read("ntuc_memberportal/resources/Request/userserviceRequest.json")
    And request requestBody
    When method Put
    Then status 200
    Then print response.content == requestBody
#   Then match response == expectedResponse

    Examples:
      | id |
      | 1  |