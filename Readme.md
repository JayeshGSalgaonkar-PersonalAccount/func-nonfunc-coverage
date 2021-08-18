# Run on IDE (preferred - Intellij)
* Execute TestRunnerParallel.java

# Run on local cli - Execute all tests
* mvn clean
* mvn test -Dtest=TestRunnerParallel
  
# Run test of specific microservice (example here for "membership" microservice)
* mvn test "-Dkarate.options=--tags @member-service" -Dtest=TestRunnerParallel 

tags to be replaced by micro-service name -
- @member-service
- @user-service

# DockerFile (root folder)
* docker build -t nmp-tests .
* docker run -it -e mcr=<microservice_to_test> -e url='microservice_endpoint' nmp-tests

**mcr** to be replaced by micro-service name -
- @member-service
- @user-service
- @all --> to run all microservices
**url** example -> docker run -it -e mcr=@member-service -e url='https://devma.ntuc.org.sg/api/' nmp-tests

# Reporting
* Default karate-report -> /src/target/surefire-reports/karate-summary.html
* Custom report -> /src/target/surefire-reports/cucumber-html-reports/overview-tags.html

------------------------------------------------------------------------------------------------------------------------
# Performance test
* mvn clean test-compile gatling:test

