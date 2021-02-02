# 1. 환경설정

## 1. 1 이클립스

- 별도의 문서로 IDE 사용법 정리할 것

- 1.1.1JRE를 통해 실행

- Lombok 라이브러리 사용을 위한 조치

  

  ~~~ini
  //sts.ini 상단 아래문구 추가
  -vm
  C:\Program Files\Java\jdk1.8.0_261\bin\javaw.exe
  ~~~



## 1.2 프로젝트 생성 후

- **workspace UTF-8설정**
  - 운영체제 window의 'MS949' 인코딩 방식을 따라가지 않도록 방지
  - HTML, CSS, JSP 모두 utf-8로 수정
- 이클립스 주석 색깔 변경
    - https://wangimnida.tistory.com/703
- **maven 다운로드 진행**
- ``C:\Users\사용자이름\ **.**m2`` 폴더에 라이브러리 다운로드



**1.2.1 설정**

- - -

- **pom.xml 설정**

    ~~~xml
    	<properties>
    		<java-version>1.8</java-version>//1.8로 변경
    		<org.springframework-version>5.0.7.RELEASE</org.springframework-version>//5버전으로 변경
    		<org.aspectj-version>1.6.10</org.aspectj-version>
    		<org.slf4j-version>1.6.6</org.slf4j-version>
    	</properties>
    ~~~

    ~~~xml
    		   <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>2.5.1</version>
                    <configuration>
                        <source>1.8</source>// 컴파일러 버전변경
                        <target>1.8</target>// 컴파일러 버전변경
                        <compilerArgument>-Xlint:all</compilerArgument>
                        <showWarnings>true</showWarnings>
                        <showDeprecation>true</showDeprecation>
                    </configuration>
                </plugin>
    ~~~

**(방법1)**

- **설정파일 소개**
  - webapp/WEB-INF/spring/appServlet/**servlet-context.xml**
  - webapp/WEB-INF/spring/**root-context.xml**
  - webapp/WEB-INF/**web.xml**

**(방법2 JAVA설정)**

- web.xml / servlet-context.xml / root-context.xml 모두 삭제
- pom.xml 에러발생하면 플러그인 설정 추가
- pom.xml 의 servlet-api 3.1.0 이상으로 추가

~~~xml
			<!--자바설정 -->
			<plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.2.0</version>
                <configuration>
                    <failOnMissingWebXml>false</failOnMissingWebXml>
                </configuration>
            </plugin>

            <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>javax.servlet-api</artifactId>
                <version>3.1.0</version>
                <scope>provided</scope>
            </dependency>
~~~

- java 설정파일 작성(xml을 대체하는 파일)
  ​		**RootConfig.java**

  - ~~~java
    package org.zerock.config;
    
    import org.springframework.context.annotation.ComponentScan;
    import org.springframework.context.annotation.Configuration;
    
    @Configuration
    @ComponentScan(basePackages= {"org.zerock.sample"})
    public class RootConfig {
    	
    }
    
    ~~~

    **WebConfig.java** (추상클래스 AbstractAnnotationConfigDispatcherServletInitializer를 상속하는)

  - ~~~java
    package org.zerock.config;
    
    import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
    
    public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
    
    	@Override
    	protected Class<?>[] getRootConfigClasses() {
    		// TODO Auto-generated method stub
    		return new Class[] {RootConfig.class};
    	}
    
    	@Override
    	protected Class<?>[] getServletConfigClasses() {
    		// TODO Auto-generated method stub
    		return null;
    	}
    
    	@Override
    	protected String[] getServletMappings() {
    		// TODO Auto-generated method stub
    		return null;
    	}
    
    }
    ~~~

    - getRootConfigClasses()는 아래 xml설정과 동치

      ~~~xml
      <context-param>
      	<param-name>contextConfigLocation</param-name>
      	<param-value>/WEB-INF/spring/root-context.xml</param-value>
      </context-param>
      ~~~

      

## 1.3 tomcat 으로 실행하기

**오류시 상황별 대처**

1. 비정상 종료시, 프로세스가 죽지않아 git repository가 완전히 삭제되지 않을 때
   1. .m2 폴더안의 repository폴더를 삭제한 후 이클리스 재실행
2. Tomcat으로 실행할 떄 'Invalid loc header(bad signature)'
   1.  maven update 진행

## 1.4 Lombok 설치

### 방법1.

1. lombok.jar 다운로드(롬북홈페이지)
2. ``java -jar lombok.jar`` 실행
3. 이클립스IDE 설치경로 설정
4. 이클리스IDE설치폴더에 lombok.jar이 추가된 것 확인

### 방법2.

	1. pom.xml 설정을 lombok 설정
 	2. .m2/repository/org/projectlombok/lombok/1.18.16 폴더에서 lombok.jar 찾기
 	3. ``java -jar lombok.jar`` 실행
	4. 이클립스IDE 설치경로 설정
	5. 이클리스IDE설치폴더에 lombok.jar이 추가된 것 확인

# 2. 의존성 주입 

## 2.1 Spring구버전

**Constructor Injection**

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.2.xsd">
	
	<bean id="tv" class="polymorphism.SamsungTV">
		<constructor-arg ref="sony"></constructor-arg>
	</bean>
	<bean id="sony" class="polymorphism.SonySpeaker"/>
</beans>
~~~

- 클래스 SamsungTV에 constructor 가 정의돼있다. 

- ~~~xml
  <constructor-arg ref=""></constructor-arg>
  ~~~



 **Setter Injection**

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.2.xsd">
	
	<bean id="tv" class="polymorphism.SamsungTV">
		<property name="speaker" ref="apple"></property>
		<property name="price" value="2700000"></property>
	</bean>
	
	<bean id="sony" class="polymorphism.SonySpeaker"/>
	<bean id="apple" class="polymorphism.AppleSpeaker"/>
</beans>
~~~

- 클래스 SamsungTV에 speaker setter/ price setter 메소드가 정의돼있다.

- ~~~xml
  <property name="현 객체의 필드" ref="외부객체의 xml <bean> id속성값"></property>
  ~~~



# 3. MySQL 연동

별도 문서 참고



# 4. Controller

## 4-1. 자동변환

### 방법1

~~~java
@InitBinder
public void InitBinder(WebDataBinder binder) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(sdf, false));
}
// url에   ?dueDate=2018-01-01 쿼리값을 Date 타입의 변수에 형변환하여 자동맵핑해준다.
~~~

### 방법2

~~~java
//DTO의 필드에 어노테이션을 사용
@Data
public class TodoDTO {
	private String  title;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date 	dueDate;
}
~~~



## 4-2. 리턴타입

### 객체타입

~~~XML
<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.10.0</version>
</dependency>
~~~

~~~JAVA
@GetMapping("/ex06")
public @ResponseBody SampleDTO ex06() {
    log.info("/ex06..........");
    SampleDTO dto = new SampleDTO();
    dto.setAge(10);
    dto.setName("홍길동");
    return dto;
}
~~~

~~~JSON
{"name":"홍길동","age":10}
~~~



### ResponseEntity

~~~java
@GetMapping("/ex07")
	public ResponseEntity<String> ex07() {
		log.info("/ex07..........");
		
		String msg = "{\"name\": \"홍길동\"}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		header.add("abc", "def");
		
		return new ResponseEntity<String>(msg, header, HttpStatus.OK);
	}
~~~



## 4-3 파일업로드 처리

- Servlet 3.0이전 commons 의 파일업로드, cos.jar 이용함
- Servlet 3.0이후 Tomcat7 에는 기본적인 기능으로 파일업로드 지원 따라서, 추가적인 라이브러리 필요 X

### Servlet 3.0이전    ( C:/upload/tmp 폴더 생성 )

~~~xml
<!--Servlet 3.0이전 -->
<!-- https://mvnrepository.com/artifact/commons-fileupload/commons-fileupload -->
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.3.3</version>
</dependency>

~~~

~~~xml
<!-- 파일 업로드는 Controller 단에서 처리하므로 servlet-context.xml에 등록 -->
<beans:bean id="multipartResolver"
			class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<beans:property name="defaultEncoding" value="utf-8"></beans:property>
		<!-- 1024 * 1024 * 10 bytes 10MB -->
		<beans:property name="maxUploadSize" value="104857560"></beans:property>
		<!-- 1024 * 1024 * 2 bytes 2MB -->
		<beans:property name="maxUploadSizePerFile"
			value="2097152"></beans:property>
		<beans:property name="uploadTempDir"
			value="file:/C:/upload/tmp"></beans:property>
		<beans:property name="maxInMemorySize" value="10485756"></beans:property>
	</beans:bean>
~~~

- defaultEncoding : 업로드 될 파일의 한글명이 깨지지 않도록
- maxUploadSize : 한 번에 request에 담기는 모든 데이터의 최대 합
- maxUploadSizePerFile: 파일 하나의 최대 크기
- uploadTempDir: 절대경로를 이용하기 위해선 file:/ 명시한다
- maxInMemorySize: 메모리상에 유지되는 최대 크기( 이 크기를 넘어설 경우 uploadTempDir 에 임시파일이 저장된다)

## 4-4. 에러페이지

### 500에러

~~~java
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		log.error("Exception............" + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model);
		return "error_page";
	}
}
~~~

~~~xml
<!-- servelt-context.xml -->
<context:component-scan base-package="org.zerock.exception" />
~~~



### 404에러

- web.xml 에서 에러페이지 지정 가능

~~~xml
<servlet>
		<servlet-name>appServlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>/WEB-INF/spring/appServlet/servlet-context.xml</param-value>
		</init-param>

	    <init-param>
	      <param-name>throwExceptionIfNoHandlerFound</param-name>
	      <param-value>true</param-value>
	    </init-param>
		
		<load-on-startup>1</load-on-startup>
	</servlet>
~~~











