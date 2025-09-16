# Stage 1: Build with Maven
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY studentspring/. .
RUN mvn clean package -DskipTests

# Stage 2: Run the packaged JAR
FROM openjdk:21jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
