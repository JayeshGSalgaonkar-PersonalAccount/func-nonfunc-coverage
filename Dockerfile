FROM maven:3-jdk-8-alpine

ENV mcr mcr
ENV url url

#RUN addgroup app && adduser -S -G app appuser
#USER appuser

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN chmod u+x maven_runner.sh

ENTRYPOINT /app/maven_runner.sh $mcr $url

