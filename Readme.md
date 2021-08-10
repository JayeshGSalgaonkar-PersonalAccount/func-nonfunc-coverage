# Run on IDE (preferred - Intellij)
* Execute TestRunnerParallel.java

# Run on local cli - Execute all tests
* mvn clean
* mvn test -Dtest=TestRunnerParallel
  
# Run test of specific microservice (example here for "membership" microservice)
* mvn test "-Dkarate.options=--tags @membership" -Dtest=TestRunnerParallel 

# DockerFile (root folder)
* docker build -t karate-docker .
* docker run -it -e mcr={<microservice_to_test>} -e url={<microservice_endpoint>} karate-docker

# Reporting
* Default karate-report -> /src/target/surefire-reports/karate-summary.html
* Custom report -> /src/target/cucumber-html-reports/overview-tags.html

