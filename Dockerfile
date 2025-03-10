FROM eclipse-temurin:17 AS builder
WORKDIR /app
COPY pom.xml ./
COPY src ./src
COPY mvnw ./
COPY .mvn ./.mvn
RUN ./mvnw clean verify

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/target/vitruvserver-1.0-SNAPSHOT.jar /app/app.jar
COPY --from=builder /app/target/libs /app/libs
ENTRYPOINT ["java", "-cp", "/app/app.jar:/app/libs/*", "app.VitruvServerApp"]
