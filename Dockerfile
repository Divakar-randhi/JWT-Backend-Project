# 🏗️ Stage 1: Build stage - Maven tho JAR create cheyyadam
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app

COPY studentspring/ .



# Maven wrapper files (if using ./mvnw)
COPY mvnw .
COPY .mvn/ .mvn/

# JAR build cheyyadam (tests skip chesi)
RUN ./mvnw clean package -DskipTests

# 🚀 Stage 2: Runtime stage - JAR ni run cheyyadam
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Build stage nunchi final JAR ni copy cheyyadam
COPY --from=build /app/target/*.jar app.jar

# Application port expose cheyyadam (Render uses PORT env var)
EXPOSE 8080

# Spring Boot app ni run cheyyadam
ENTRYPOINT ["java", "-jar", "app.jar"]
