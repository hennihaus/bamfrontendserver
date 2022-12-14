FROM gradle:7.6.0-jdk11 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle shadowJar --no-daemon

FROM openjdk:11.0.16-jre-slim
EXPOSE 8080:8080
WORKDIR /app
COPY --from=build /home/gradle/src/build/libs/*-all.jar /app/ktor-docker-sample.jar
ENTRYPOINT ["java","-jar","/app/ktor-docker-sample.jar"]