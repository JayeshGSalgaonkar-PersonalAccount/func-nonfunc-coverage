# Run on IDE (preferred - Intellij)
* Execute "TestRunnerParallel.java" manually

# Functional Test 
    CLI - Execute all tests
* `mvn clean`
* To run in dev-environment - execute - `mvn test -Dtest=TestRunnerParallel` 
* To run in pre-prod environment - execute - `mvn test -Dtest=TestRunnerParallel -Dkarate.env="preprod"`

# CLI - Execute specific microservice as tag
* `mvn test "-Dkarate.options=--tags @member-service" -Dtest=TestRunnerParallel` 

    tags to be replaced by micro-service name -
    - @member-service
    - @user-service
    - @payment-service

# Non-functional Test (Performance)
    CLI - Execute all tests (only option)
* To run in dev-environment - execute - `mvn clean test-compile gatling:test`
* To run in pre-prod environment - execute - `mvn clean test-compile -Dkarate.env="preprod" gatling:test`


# DockerFile (root folder)
    create - docker image
* `docker build -t nmp-tests .`

#    docker run & test execution
* `docker run -it -e mcr=<microservice_to_test> -e url='microservice_endpoint' nmp-tests`

    **mcr** to be replaced by micro-service name -
    - @member-service
    - @user-service
    - @payment-service
    - @all --> to run all microservices


**url** example -> docker run -it -e mcr=@member-service -e url='https://devma.ntuc.org.sg/api/' nmp-tests
# Reporting
* Default karate-report -> /src/target/surefire-reports/karate-summary.html
* Custom report -> /src/target/surefire-reports/cucumber-html-reports/overview-tags.html
* Retrieve the container ID : docker ps -al

Test artifacts from docker container needs to be copied -> `docker cp "container_id":/app/target .`





------------------------------------------------------------------------------------------------------------------------


