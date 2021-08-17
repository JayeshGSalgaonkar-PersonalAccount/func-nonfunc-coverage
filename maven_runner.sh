 #!/usr/bin/env bash

 mcr=$1
 url=$2

 echo "START: Running functional tests..."

 mvn test -T 3.0C "-Dkarate.options=--tags $mcr" -DbaseURL=$url -Dtest=TestRunnerParallel

 if [[ $? -ne 0 ]] ; then
   echo "FINISH: There are test failures, failing build..."
   echo "Exiting with code 1."
 else
   echo "FINISH: All tests passed!"
   echo "Exiting with code 0."
   exit 0
 fi


  echo "START: Running non-functional tests..."

 mvn clean test-compile -DbaseURL=$url gatling:test

 if [[ $? -ne 0 ]] ; then
   echo "FINISH: There are test failures, failing build..."
   echo "Exiting with code 1."
 else
   echo "FINISH: All tests passed!"
   echo "Exiting with code 0."
   exit 0
 fi