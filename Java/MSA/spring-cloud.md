# Spring Cloud

https://github.com/joneconsulting/msa_with_spring_cloud/

```
mvn spring-boot:run -Dspring-boot.run.jvmArguments='-Dserver.port=9003'
```

```
mvn clean
mvn compile package
java -jar -Dserver.port=9004 ./target/user-service-0.0.1-SNAPSHOT.jar
```

