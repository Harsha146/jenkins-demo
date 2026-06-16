# =========================================================================
# Stage 1: Build and compile the application
# =========================================================================
FROM maven:3.9.12-eclipse-temurin-25 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file to download dependencies first (improves build caching)
COPY pom.xml .

# Download all dependencies without building the source code
RUN mvn dependency:go-offline -B

# Copy the actual application source code
COPY src ./src

# Compile and package the application into a JAR file, skipping unit tests
RUN mvn clean package -DskipTests

# =========================================================================
# Stage 2: Minimal runtime environment
# =========================================================================
FROM eclipse-temurin:25-jre

# Set a non-root directory for security purposes
WORKDIR /app

# Copy only the compiled JAR file from the builder stage
# Replace "myapp.jar" if you have specified a different finalName in your pom.xml
COPY --from=builder /app/target/*.jar myapp.jar

# Expose the application port (adjust 8080 to match your application configuration)
EXPOSE 8080

# Run the application using the Java 25 JRE
ENTRYPOINT ["java", "-jar", "myapp.jar"]
