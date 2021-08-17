FROM maven:3-jdk-8-alpine

# Create env variables
ENV mcr mcr
ENV url url

#RUN addgroup app && adduser -S -G app appuser
#USER appuser

# Create working directory
RUN mkdir /app
WORKDIR /app

# Maven dependencies caching
COPY pom.xml /app
RUN mvn test-compile -DskipTests

# Copy code / files
COPY . /app

# Access rights
RUN chmod u+x maven_runner.sh

ENTRYPOINT /app/maven_runner.sh $mcr $url