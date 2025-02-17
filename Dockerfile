FROM maven AS build
WORKDIR /app
COPY . .
RUN mvn -q clean package -DskipTests

FROM openjdk
WORKDIR /home
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar .
COPY --from=build /app/start.sh .
RUN chmod +x /home/start.sh
ENTRYPOINT /home/start.sh
