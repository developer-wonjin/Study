

https://www.janua.fr/how-to-install-keycloak-with-mariadb/ 참고

mariadb연동하는 코드 및 keycloak테이블 auto ddl

```xml
<datasources>
    <datasource jndi-name="java:jboss/datasources/ExampleDS" pool-name="ExampleDS" enabled="true" use-java-context="true" statistics-enabled="${wildfly.datasources.statistics-enabled:${wildfly.statistics-enabled:false}}">
        <connection-url>jdbc:h2:mem:test;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE</connection-url>
        <driver>h2</driver>
        <security>
            <user-name>sa</user-name>
            <password>sa</password>
        </security>
    </datasource>
    <datasource jndi-name="java:jboss/datasources/KeycloakDS" pool-name="KeycloakDS">
        <connection-url>jdbc:mariadb://localhost:3306/keycloak</connection-url>
        <driver-class>org.mariadb.jdbc.Driver</driver-class>
        <driver>mariadb</driver>
        <security>
            <user-name>root</user-name>
            <password>1234</password>
        </security>
    </datasource>
    <drivers>
        <driver name="h2" module="com.h2database.h2">
            <xa-datasource-class>org.h2.jdbcx.JdbcDataSource</xa-datasource-class>
        </driver>
        <driver name="mariadb" module="com.mariadb">
            <driver-class>org.mariadb.jdbc.Driver</driver-class>
        </driver>
    </drivers>
</datasources>
```



module.xml

```xml
<?xml version="1.0" ?>
<module xmlns="urn:jboss:module:1.3" name="com.mariadb">
 <resources>
   <resource-root path="mariadb-java-client-3.0.4.jar"/>
 </resources>
 <dependencies>
   <module name="javax.api"/>
   <module name="javax.transaction.api"/>
 </dependencies>
</module>
```

