# ── Stage 1: Build the Application JAR with pre-installed Maven ──
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline -B || true

# Copy source code and webapp resources
COPY src ./src

# Package the application skipping tests
RUN mvn clean package -DskipTests -B

# ── Stage 2: Minimal Production Runtime ──
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy the built JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Copy webapp directory so embedded Tomcat finds physical JSP views
COPY src/main/webapp /app/src/main/webapp

# Expose port (Render injects $PORT dynamically)
EXPOSE 8081

# Optimize JVM memory for Render Free Tier (512MB RAM limit)
ENV JAVA_OPTS="-Xmx380m -Xms180m -XX:+UseG1GC"

# Run Spring Boot application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
