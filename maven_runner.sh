 #!/usr/bin/env bash

 echo "START: Running tests..."

# mvn -B -f pom.xml -s settings.xml "-Dkarate.options=--tags @$1" -DbaseURL=$2 prepare-package -Dskip

 mvn test -q -T 3.0C "-Dkarate.options=--tags @$1" -DbaseURL=$2

 if [[ $? -ne 0 ]] ; then
   echo "FINISH: There are test failures, failing build..."
   echo "Exiting with code 1."
   exit 1
 else
   echo "FINISH: All tests passed!"
   echo "Exiting with code 0."
   exit 0
 fi