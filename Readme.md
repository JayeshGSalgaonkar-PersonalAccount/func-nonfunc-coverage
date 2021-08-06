# Run on IDE (preferred - Intellij)
* Execute TestRunner.java

# Run on local cli - Execute all tests (root folder)
* mvn clean
* mvn test -Dtest=TestRunner

# DockerFile (root folder)
* docker build -t karate-docker .
* docker run -it -e mcr={<microservice_to_test>} -e url={<microservice_endpoint>} karate-docker

# Reporting
* Default karate-report -> /src/target/res/karate-summary.html
* Custom report -> <in scope of Sprint 4>

