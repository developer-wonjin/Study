# MySQL 연결

# 1. JDBC

## 1.1 정의 &특징

**정의: 자바 표준 인터페이스(API)이다.(java.sql, javax.sql 에 정의)**

**특징**

- DBMS의 종류에 상관없이 통일된 API 호출.
- Connection 열기와 닫기
2. Statement 준비와 닫기
3. Statement 실행
4. ResultSet Loop처리
5. Exception 처리와 반환
- Transaction 처리
- 이중 try~catch 문이 발생할 수도 있음

**단점**

- 순수 `jdbc`로 데이터베이스에 접근을 하면, 데이터베이스에 접근할 때마다 connection을 맺고 끊는 작업을 한다. 

- DBCP로 해결(DataSource 인터페이스 도입)

  

## 1.2 밴드사별 Driver(통신 어댑터)

- 자바 프로그램의 요청을 DBMS가 이해할 수 있는 프로토콜로 변환

- 클라이언트 사이드 어댑터
- 종류
  - **oracle : oracle.jdbc.driver.OracleDriver**
    - 드라이버 다운로드 : [http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html](https://t.umblr.com/redirect?z=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fdatabase%2Ffeatures%2Fjdbc%2Findex-091264.html&t=ZDYyMTc0YTgyMzdmN2QzMDRjY2Y3MGU2OWU5Njk5MGM3NjBkYTMzZSxrUThBZXkwag%3D%3D&b=t%3A_QUEIcujr5Zcix7dey6M7Q&p=https%3A%2F%2Fcoffee-mark.tumblr.com%2Fpost%2F61393263928%2Fjava-jdbc-%EB%93%9C%EB%9D%BC%EC%9D%B4%EB%B2%84-%EB%A1%9C%EB%94%A9-dbms-%EC%A0%91%EC%86%8D&m=1&ts=1606050172) 접속후 오라클 버전별 선택
  - **mysql : com.mysql.jdbc.Driver**
    - 드라이버 다운로드 : [http://dev.mysql.com/downloads/connector/j/](https://t.umblr.com/redirect?z=http%3A%2F%2Fdev.mysql.com%2Fdownloads%2Fconnector%2Fj%2F&t=NzE4ZTRkMjAzZDEyN2M2MDkyOTYyZWYyZjQwNDIyZTk2NmVhMDMyMCxrUThBZXkwag%3D%3D&b=t%3A_QUEIcujr5Zcix7dey6M7Q&p=https%3A%2F%2Fcoffee-mark.tumblr.com%2Fpost%2F61393263928%2Fjava-jdbc-%EB%93%9C%EB%9D%BC%EC%9D%B4%EB%B2%84-%EB%A1%9C%EB%94%A9-dbms-%EC%A0%91%EC%86%8D&m=1&ts=1606050172) 접속후 platform을 다음과 같이 선택
  - **MSsql : com.microsoft.sqlserver.jdbc.SQLServerDriver**
    - 드라이버 다운로드 : [http://www.microsoft.com/ko-kr/download/details.aspx?id=11774](https://t.umblr.com/redirect?z=http%3A%2F%2Fwww.microsoft.com%2Fko-kr%2Fdownload%2Fdetails.aspx%3Fid%3D11774&t=Y2QwYzBiN2ZlYzczY2Y5MjAwYTc2MmM3ZjM1ODQxMjU3ZGZmODEwMSxrUThBZXkwag%3D%3D&b=t%3A_QUEIcujr5Zcix7dey6M7Q&p=https%3A%2F%2Fcoffee-mark.tumblr.com%2Fpost%2F61393263928%2Fjava-jdbc-%EB%93%9C%EB%9D%BC%EC%9D%B4%EB%B2%84-%EB%A1%9C%EB%94%A9-dbms-%EC%A0%91%EC%86%8D&m=1&ts=1606050172)



## 1.3 밴드사별 URL

DBMS별 url은 다음과 같다. 

- oracle : jdbc:oracle:thin:@127.0.0.1:1521:orcl
- mysql : jdbc:mysql://127.0.0.1:3306/abc
- MSsql : jdbc:microsoft:sqlserver://127.0.0.1:1433;database=xyz

# 2. JDBC 연결

## 2.1 Servlet/JSP 프로그래밍에서의 JDBC

~~~jsp
<%
	// 1. JDBC 드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");
	//Class.forName("");
    //Class.forName("");
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" +
							"useUnicode=true&characterEncoding=utf8";
		String dbUser = "jspexam";
		String dbPass = "jsppw";
		
		String query = "select * from MEMBER order by MEMBERID";
		
		// 2. 데이터베이스 커넥션 생성
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		// 3. Statement 생성
		stmt = conn.createStatement();
		
		// 4. 쿼리 실행
		rs = stmt.executeQuery(query);
		
		// 5. 쿼리 실행 결과 출력
		while(rs.next()) {
%>
<tr>
	<td><%= rs.getString("NAME") %></td>
	<td><%= rs.getString("MEMBERID") %></td>
	<td><%= rs.getString("EMAIL") %></td>
</tr>
<%
		}
	} catch(SQLException ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
	} finally {
		// 6. 사용한 Statement 종료
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		
		// 7. 커넥션 종료
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
~~~



## 2.2 Spring에서 JDBC

### JDBC Driver (maven 이용한 다운로드)

~~~xml
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.22</version>
</dependency>
~~~

Maven Dependencies>mysql-connector-java-8.0.22.jar>com.mysql>jdbc 패키지 생성

### jdbc 테스트

~~~java
package org.zerock.sample;

import static org.junit.Assert.fail;
import java.sql.Connection;
import java.sql.DriverManager;
import org.junit.Test;
import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
    // 5.1.X 이후 버전부터 KST 타임존을 인식하지 못하는 이슈
	String url = "jdbc:mysql://localhost/test?characterEncoding=UTF-8&serverTimezone=UTC";
//	String url = "jdbc:mysql://localhost/test?characterEncoding=UTF-8&amp;serverTimezone=UTC";
    String url_oracle = "jdbc:oracle:thin:@localhost:1521:XE";
    //로딩
	static {
		try {
		   //Class.forName("com.mysql.jdbc.Driver");   // 5.1.X 이전 버전
			Class.forName("com.mysql.cj.jdbc.Driver");// 5.1.X 이후 버전
		} catch (Exception e) {
			//TODO: handle exception
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {
        //연결
		try (Connection con = DriverManager.getConnection(url, "root", "1234")) {
			log.info(con);
		} catch (Exception e) {
			//TODO: handle exception
			fail(e.getMessage());
		}
	}
    
    //오라클
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {

		try (Connection con = DriverManager.getConnection(url_oracle, "book_ex", "book_ex")) {

			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}    
    
    
    
    
    
    
    
}
~~~



## 3. 커넥션풀

**(참고)DataSource** 인터페이스

- https://m.blog.naver.com/PostView.nhn?blogId=sambak99&logNo=90123339642&proxyReferer=https:%2F%2Fwww.google.com%2F
- 데이터베이스에 접근하기 위한 하나의 표준 인터페이스
- DataSource를 JDBC Template에 주입(Dependency Injection)시키고 JDBC Template은
  JDBC Driver를 이용하여 DB에 접근한다.
- **Driver -->  DataSource  -->  JDBC Template  --> DB**
- sqlSessionFactoryBean을 생성할 때 DataSource를 인자로 넘겨준다. 이 과정을 통해 Spring은
  DataSource로 DB와의 연결을 획득한다.

**(참고)JDBC Template**

- JDBC Template 으로 이중 try ~ catch문을 안쓰도록 개선함
  내부적으로 java.sql, javax.sql의 conn, stmt, resultSet 을 호출함.

## 3.1 Commons

https://gmlwjd9405.github.io/2018/05/15/setting-for-db-programming.html

https://d2.naver.com/helloworld/5102792 네이버 개발자 커뮤니티



## 3.2 HikariCP

~~~xml
<!-- https://mvnrepository.com/artifact/com.zaxxer/HikariCP -->
<dependency>
    <groupId>com.zaxxer</groupId>
    <artifactId>HikariCP</artifactId>
    <version>3.3.1</version>
</dependency>

~~~



### 3.2.1 연동

**(방법1)root-context.xml**

jdbcUrl에  `amp;` 추가

~~~xml
<!-- HikariCP configuration -->
<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
<!-- 오라클인 경우 
	<property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"></property>
	<property name="jdbcUrl" value="jdbc:oracle:thin:@localhost:1521:XE"></property> -->
	<property name="driverClassName" value="com.mysql.jdbc.Driver">	</property>
	<property name="jdbcUrl"       
              value="jdbc:mysql://localhost/test?characterEncoding=UTF-8&amp;serverTimezone=UTC">              		</property>
	<property name="username" value="root"></property>
	<property name="password" value="1234"></property>
</bean>

<!-- HikariCP DataSource -->
<!--HikariCP가 제공하는 DataSource이용-->
<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource" destroymethod="close">
	<constructor-arg ref="hikariConfig" />
</bean>
~~~

HikariConfig   ---->   Hikari DataSource

**(방법2)java설정**

jdbcUrl에  `amp;` 삭제

~~~xml
<!-- HikariCP configuration -->
<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
<!-- 오라클인 경우 
	<property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"></property>
	<property name="jdbcUrl" value="jdbc:oracle:thin:@localhost:1521:XE"></property> -->
	<property name="driverClassName" value="com.mysql.jdbc.Driver">	</property>
	<property name="jdbcUrl"       
              value="jdbc:mysql://localhost/test?characterEncoding=UTF-8&amp;serverTimezone=UTC">              		</property>
	<property name="username" value="root"></property>
	<property name="password" value="1234"></property>
</bean>

<!-- HikariCP DataSource -->
<!--HikariCP가 제공하는 DataSource이용-->
<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource" destroymethod="close">
	<constructor-arg ref="hikariConfig" />
</bean>
~~~



~~~java
@Configuration
@ComponentScan(basePackages= {"org.zerock.sample"})
public class RootConfig {
	  @Bean
	  public DataSource dataSource() {
	    HikariConfig hikariConfig = new HikariConfig();
	  //hikariConfig.setDriverClassName("com.mysql.jdbc.Driver");
	    hikariConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");          
	    hikariConfig.setJdbcUrl("jdbc:mysql://localhost/test?characterEncoding=UTF-8&serverTimezone=UTC");

        hikariConfig.setUsername("root");
	    hikariConfig.setPassword("1234");
	    HikariDataSource dataSource = new HikariDataSource(hikariConfig);

	    return dataSource;
	  }
	  
	  @Bean
	  public SqlSessionFactory sqlSessionFactory() throws Exception {
	    SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
	    sqlSessionFactory.setDataSource(dataSource());
	    return (SqlSessionFactory) sqlSessionFactory.getObject();
	  }
}

~~~





