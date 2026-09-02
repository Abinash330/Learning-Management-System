# ── Stage 1: Build the Application JAR ──
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copy Maven wrapper and POM first for layer caching
COPY pom.xml mvnw mvnw.cmd ./
COPY .mvn .mvn

# Make mvnw executable
RUN chmod +x ./mvnw

# Copy source code
COPY src src

# Package the application skipping tests
RUN ./mvnw clean package -DskipTests

# ── Stage 2: Minimal Production Runtime ──
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy the built JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Copy webapp directory so embedded Tomcat finds physical JSP views
COPY src/main/webapp /app/src/main/webapp

# Expose the application port
EXPOSE 8081

# Optimize JVM memory for Render Free Tier (512MB RAM)
ENV JAVA_OPTS="-Xmx400m -Xms200m -XX:+UseG1GC"

# Run Spring Boot application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
