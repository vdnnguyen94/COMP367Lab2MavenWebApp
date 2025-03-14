FROM openjdk:23

COPY /target/Maven-Web-App-0.0.1-SNAPSHOT.jar /home/Maven-Web-App-0.0.1-SNAPSHOT.jar
CMD ["java", "-jar", "/home/Maven-Web-App-0.0.1-SNAPSHOT.jar"]