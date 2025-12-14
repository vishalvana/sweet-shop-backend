# Use Java 17 (Render compatible)
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy maven wrapper files first
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# 🔥 FIX: give execute permission to mvnw
RUN chmod +x mvnw

# Download dependencies (cached layer)
RUN ./mvnw dependency:go-offline

# Copy source code
COPY src src

# Build application
RUN ./mvnw clean package -DskipTests

# Expose Spring Boot port
EXPOSE 8080

# Run app
CMD ["java", "-jar", "target/*.jar"]
