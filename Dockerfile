FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy maven wrapper
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Fix permissions (Windows -> Linux)
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# Expose port (Render uses this)
EXPOSE 8080

# ✅ FIX: use EXACT jar name
CMD ["java", "-jar", "/app/target/sweet-shop-0.0.1-SNAPSHOT.jar"]
