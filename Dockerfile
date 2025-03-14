FROM openjdk:23

COPY /target/spring-petclinic-3.4.0-SNAPSHOT.jar /home/spring-petclinic-3.4.0.jar 
CMD ["java","-jar","/home/spring-petclinic-3.4.0.jar"]