# Stage 1: Build with Maven
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY studentspring/. .
RUN mvn clean package -DskipTests

# Stage 2: Run the packaged JAR
FROM openjdk:17jdk-alpine
WORKDIR /app
COPY studentspring/. .
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
