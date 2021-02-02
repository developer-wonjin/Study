
[서블릿API_계층구조](#서블릿API_계층구조)<br>
[인코딩 설정](#인코딩)<br>
[서블릿_DB연동하기](#서블릿_DB연동하기)<br>
[톰캣_에러](#톰캣_에러)<br>
[url경로 지정방식](#url경로_지정방식)<br>

<hr>

# 서블릿API_계층구조
~~~
Servlet  ServletConfig   // 인터페이스
    \     /
     \   /  (구현)
      \ /
 GenericServlet         // 클래스
       |
       | (상속) ~ 프로토콜에 따라 메소드 service()를 오버라이딩해서 구현함.
       |
  HttpServlet           // 자식클래스 : http프로토콜을 채택하여 웹브라우저 기반 서블릿을 만들 때 상속받아 사용한다.
~~~

# 이클립스에서 서블릿 클래스를 사용하려면?
서블릿API들(클래스들)은 톰캣의 servlet-api.jar 라이브러리로 제공됨.
~~~
tomcat
  ┗ lib
    ┗ servlet-api.jar
~~~
이클립스 프로젝트 이름 우클릭 > Build Path > Libraries탭 > Add External JARs.. > 위 파일 선택하여 추가한다.
이 과정은 프로젝트에 종속되므로 다른 프로젝트를 생성하면 다시 과정을 밟아나간다.



    
## 인코딩
서블릿 요청데이터 인코딩 설정 / 응답데이터 contentType 설정<br>
요청데이터 : request.setCharacterEncoding("utf-8"); //인코딩 설정<br>
응답데이터 : response.setContentType("text/html;charset=utf-8"); //응답데이터의 데이터타입(MIME-TYPE)<br>

### 응답데이터의 데이터 타입(MIME)을 설정해주는 이유
: 브라우저가 전송받을 데이터의 타입을 알고 있으면 빠르게 처리할 수 있기 때문.
따라서, 톰켓 컨테이너가 미리 제공하는 데이터 타입중 하나를 지정해서 브라우저로 전송함.
미리 제공하는 데이터타입은 MIME-TYPE이라고 함. text/html , text/plain, application/xml 등이 있으며 그 외는 CATALINA_HOME/conf/web.xml에 추가하여 사용가능함.

## 서블릿_DB연동하기

~~~
create table t_member(
id varchar2(10) primary key,
pwd varchar2(10),
name varchar2(50),
email varchar2(50),
joinDate date default sysdate
);

insert into t_member values('hong','1212','홍길동', 'hong@gmail.com',sysdate);
insert into t_member values('lee','1212','이순신', 'lee@gmail.com',sysdate);
insert into t_member values('kim','1212','김유신', 'kim@gmail.com',sysdate);
commit;
select *from t_member;

~~~

### JDBC
JDBC는 ODBC의 영향을 받아서 만들어졌습니다. ODBC란 Window 환경에서 데이터베이스 연동을 위해 제공되는 단일한 프로그래밍 인터페이스입니다. 물론 JABA에서 JDBC 없이 DB 프로그래밍을 할 수 있습니다. 단, native c 코드를 사용해야 하므로 무척 번거롭기 때문에 JDBC를 사용하는 경우가 대부분입니다.
<hr>
오라클DB --- WAS 연동에 필요한 드라이버 ojdbc6.jar를
프로젝트의 /WebContent/WEB-INF/lib 폴더에 복사하여 붙여 넣는다.
ojdbc.jar은 다음 링크를 통해 다운받는다.
Oracle https://www.oracle.com/technetwork/apps-tech/jdbc-112010-090769.html

Mysql https://dev.mysql.com/downloads/connector/j/


~~~java
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String user = "scott";
	private static final String pwd = "tiger";
	private Connection con;
	private Statement stmt;

	public List<MemberVO> listMembers() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		try {
			connDB();
			String query = "select * from t_member ";
			System.out.println(query);
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				MemberVO vo = new MemberVO();
				vo.setId(id);
				vo.setPwd(pwd);
				vo.setName(name);
				vo.setEmail(email);
				vo.setJoinDate(joinDate);
				list.add(vo);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private void connDB() {
		try {
			Class.forName(driver);
			System.out.println("Oracle 드라이버 로딩 성공");
			con = DriverManager.getConnection(url, user, pwd);
			System.out.println("Connection 생성 성공");
			stmt = con.createStatement();
			System.out.println("Statement 생성 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
~~~
위 코드를 통해 웹페이지에 접속하면 Oracle로딩 Connection생성 Statement생성 등 자원을 반복적으로 쓰고있음(단점)

### DBCP(톰캣 컨테이너가 DBCP객체를 가지고 있음)
www.java2s.com/Code/Jar/t/Downloadtomcatdbcp7030jar.htm (html 아님)
ConnectionPool 객체를 구현할 때, Java SE의 javax.sql.DataSource클래스를 이용.
#### JNDI
웹어플리케이션 실행시, 톰캣이 만들어 놓은 ConnectionPool 객체에 접근할 때는 JNDI를 이용.
JNDI란 (Java Naming and Directory Interface) key : value로 설정정보를 가져오는 방법.

이클립스에 톰캣을 추가하면 이클립스가 톰캣설정파일 servers/Tomcat v9.0 Server at localhost-config/context.xml을 생성함.
~~~
    <!-- Uncomment this to disable session persistence across Tomcat restarts -->
    <!--
    <Manager pathname="" />
    -->
    <Resource
    	name="jdbc/oracle"         // DataSource에 대한 JNDI 이름.. 이것을 통해 데이터
    	auth="Container"
    	type="javax.sql.DataSource"
    	driverClassName="oracle.jdbc.OracleDriver"
    	url="jdbc:oracle:thin:@localhost:1521:XE"
    	username="scott"
    	password="tiger"
    	maxActive="50"
    	maxWait="-1"/>
~~~
톰캣실행 시 연결할 데이터베이스 설정정보를 /context.xml에 입력한다.

사용법은 아래와 같다.
~~~java
package sec02.ex01;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	/*
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String user = "scott";
	private static final String pwd = "tiger";
	*/
	
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
	
	public MemberDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env"); 
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle"); //name이 jdbc/oracle인 DataSource를 검색한다.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List listMembers() {
		List list = new ArrayList();
		try {
			//connDB();
			con=dataFactory.getConnection(); //DataSource를 통해 커넥션풀에서 커넥션을 가져온다.
			String query = "select * from t_member ";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				MemberVO vo = new MemberVO();
				vo.setId(id);
				vo.setPwd(pwd);
				vo.setName(name);
				vo.setEmail(email);
				vo.setJoinDate(joinDate);
				list.add(vo);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


/*	private void connDB() {
		try {
			Class.forName(driver);
			System.out.println("Oracle 드라이버 로딩 성공");
			con = DriverManager.getConnection(url, user, pwd);
			System.out.println("Connection 생성 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/
}
~~~
# 톰캣_에러
톰캣실행에러<br>
Server Tomcat v8.5 Server at localhost failed to start.<br>
해결책<br>
tomcat Overview창에서 "Publish module contexts to separate XML files" 체크해준다.<br>

## url경로_지정방식
~~~
p.251 
MemberServlet.java
@WebServlet("/test01/member")
.....
out.print("<a href='/pro07/memberForm.html'>새 회원 가입하기</a>"); 

<--
현재 url ) localhost:8090/pro07/test01/member
<a href='memberForm.html'>새 회원 가입하기</a>        // localhost:8090/pro07/test01/memberForm.html <br>
<a href='./memberForm.html'>새 회원 가입하기</a>      // localhost:8090/pro07/test01/memberForm.html<br>
<a href='../memberForm.html>새 회원 가입하기</a>      // localhost:8090/pro07/memberForm.html<br>
<a href='/pro07/memberForm.html'>새 회원 가입하기</a> // localhost:8090/pro07/memberForm.html<br>
3,4번째 경우만 정답!
-->
~~~
