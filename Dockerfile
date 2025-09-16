# 🏗️ Stage 1: Build stage - Maven tho JAR create cheyyadam
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app

# studentspring folder lo pom.xml and src unnayi
COPY studentspring/ .
COPY pom.xml .

COPY mvnw .
COPY .mvn/ .mvn/

RUN mvn clean package -DskipTests

# 🚀 Stage 2: Runtime stage - JAR ni run cheyyadam
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
