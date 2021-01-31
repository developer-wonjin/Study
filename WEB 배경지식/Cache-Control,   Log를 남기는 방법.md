# Cache-Control



-  사용목적

  요청과 응답 내의 **캐싱 메커니즘을 위한 디렉티브를 정하기 위해** 사용

- 특징
  - **단방향성**
    -  이는 요청 내에 주어진 디렉티브가 응답 내에 주어진 디렉티브와 동일하지 않다.

| Header type                     | [General header](https://developer.mozilla.org/ko/docs/Glossary/General_header) |
| :------------------------------ | ------------------------------------------------------------ |
| Forbidden header name           | no                                                           |
| CORS-safelisted response-header | yes                                                          |

## 문법

- 대소문자를 구분하지 X

- 토큰과 따옴표로 둘러쌓인 문자열 문법 모두를 사용할 수 있는 부가적인 인자를 가진다.

- 다중 디렉티브

  -  쉼표로 구분

    

### 캐시 요청 디렉티브

HTTP 요청 내에서 **클라이언트에 의해 사용될 수 있는** 표준 `Cache-Control` 디렉티브.

```
Cache-Control: max-age=<seconds>
Cache-Control: max-stale[=<seconds>]
Cache-Control: min-fresh=<seconds>
Cache-control: no-cache 
Cache-control: no-store
Cache-control: no-transform
Cache-control: only-if-cached
```

### 캐시 응답 디렉티브

HTTP 응답 내에서 **서버에 의해 사용될 수 있는** 표준 `Cache-Control` 디렉티브.

```
Cache-control: must-revalidate
Cache-control: no-cache
Cache-control: no-store
Cache-control: no-transform
Cache-control: public
Cache-control: private
Cache-control: proxy-revalidate
Cache-Control: max-age=<seconds>
Cache-control: s-maxage=<seconds>
```

### 확장 `Cache-Control` 디렉티브

확장 `Cache-Control` 디렉티브는 **핵심 HTTP 캐싱 표준 문서에 속하지 않는다**. 지원 여부는 [호환성 테이블](https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Cache-Control#Browser_compatibility)을 확인하길......

```
Cache-control: immutable 
Cache-control: stale-while-revalidate=<seconds>
Cache-control: stale-if-error=<seconds>
```



## 디렉티브

### 캐시 능력

- `public`

  응답이 어떤 캐시에 의해서든 캐시된다는 것을 나타냅니다.

- `private`

  응답이 단일 사용자를 위한 것이며 공유 캐시에 의해 저장되지 않아야 한다는 것을 나타냅니다. 사설 캐시는 응답을 저장할 수도 있습니다.

- `no-cache`

  캐시된 복사본을 사용자에게 보여주기 이전에, **재검증을 위한 요청을 원 서버로 보내도록 강제합니다.**

  최신본을 사용장에게 보여주기위함.

- `only-if-cached`

  **새로운 데이터를 내려받지 않음**을 나타냅니다.  **서버에 요청해선 안됩니다**. 최신본에 관심없음

### 만료

- `max-age=`

  **리소스가 최신 상태라고 판단할 최대 시간을 지정합니다.** `Expires`에 반해, 이 디렉티브는 요청 시간과 관련이 있습니다.

- `s-maxage=`

  `max-age` 혹은 `Expires` 헤더를 재정의하나, **(프록시와 같은) 공유 캐시에만 적용**되며 사설 캐시에 의해서는 무시됩니다.

- `max-stale[=]`

  클라이언트가 **캐시의 만료 시간을 초과한 응답을 받아들일지를 나타냅니다**. 부가적으로, 초 단위의 값을 할당할 수 있는데, 이는 응답이 결코 만료되서는 안되는 시간을 나타냅니다.

- `min-fresh=`

  클라이언트가 지정된 시간(초단위) 동안 **신선한 상태로 유지될 응답을 원한다는 것**을 나타냅니다.

- `stale-while-revalidate=` 

  비동기 적으로 백그라운드 에서 새로운 것으로 **체크인하는 동안 클라이언트가 최신이 아닌 응답을 받아 들일 것임을 나타냅니다.** 초 값은 클라이언트가 최신이 아닌 응답을 받아 들일 시간을 나타냅니다.

- `stale-if-error=` 

  ...

### 재검증과 리로딩

- `must-revalidate`

  캐시는 사용하기 이전에 기존 **리소스의 상태를 반드시 확인**해야 하며 **만료된 리소스는 사용되어서는 안됩니다.** (공유캐시 + 사설캐시)

- `proxy-revalidate`

  `must-revalidate`와 동일하지만, **(프록시와 같은)공유 캐시에만 적용**되며 사설 캐시에 의해서는 무시됩니다.

  (공유캐시만 해당)

- `immutable`

  응답 본문이 계속해서 변하지 않을 것이라는 것을 나타냅니다. 응답은, 만료되지 않은 경우라면, 서버 상에서 변경되지 않을 것이고 그러므로 **클라이언트는 업데이트 검사를 위해 (`If-None-Match` 혹은 `If-Modified-Since`과 같은)그에 대한 조건부의 재검증을 전송해서는 안 됩니다.** 이 확장을 감지하지못한 클라이언트는 HTTP 명세에 따라 그것들을 무시해야만 합니다. 파이어폭스에서, `immutable`는 `https://` 트랜잭션 상에서만 부여됩니다. 

### 기타

- `no-store`

  클라이언트 요청 혹은 서버 응답에 관해서 어떤 것도 저장하지X

- `no-transform`

  - 응답에 대해 변형이나 변환이 일어나서는 안됩니다. 
  - Content-Encoding, Content-Range, Content-Type 헤더는 프록시에 의해서 수정되어서는 안됩니다. 
  - 반투명 프록시는, 예를 들어, 캐시 공간을 절약하고 느린 링크 상의 트래픽량을 줄이기 위해 이미지 포맷들을 변환합니다. `no-transform` 디렉티브는 이를 허용하지 않습니다.

## 예제

### 캐싱 막기

- 캐싱을 끄기 위해서, 다음의 디렉티브들을 보낼 수 있습니다. 
  - 추가로, `Expires와` `Pragma` 헤더를 참고하시기 바랍니다.

```bash
Cache-Control: no-cache, no-store, must-revalidate
```

### 정적 에셋 캐싱

- **변경되지 않을 애플리케이션 내 파일들에 대해**, 보통 적극적인 캐싱을 추가할 수 있습니다. 
- 예) 이미지, CSS 파일 그리고 자바스크립트 파일과 같이 애플리케이션에 의해 서브되는 **정적 파일**들을 포함합니다. 추가로, `Expires` 헤더를 참고하시기 바랍니다.

```bash
Cache-Control:public, max-age=31536000
```







# 로그를 남기는 방법

# 1. 설정

## 1-1. Lombok

lombok + spring-test

~~~xml
	<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<version>1.18.0</version>
			<scope>provided</scope>
    </dependency>
	<dependency>
		    <groupId>org.springframework</groupId>
		    <artifactId>spring-test</artifactId>
		    <version>${org.springframework-version}</version>
		    <scope>test</scope>
	</dependency>

~~~

## 1-2. log4j

~~~xml
	<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.17</version>
   	</dependency>
~~~

## 1-3 log설정파일 xml 또는 properties (xml권장)

### Appender

로그의 출력위치 결정(콘솔, 파일, DB)

| 종류                | 설명                                                       |
| ------------------- | ---------------------------------------------------------- |
| ConsoleAppender     | 콘솔화면 출력                                              |
| FileAppender        | 파일에 로깅                                                |
| RollingFileAppender | 지정한 파일에 로그가 계속 누적되므로 파일이 지나치게 커짐. |
| JDBCAppender        | DB에 로그를 출력                                           |

### layout

- Appender의 출렷 포맷

- 일자, 시간, 클래스명등 여러가지 정보를 선택하여 로그정보내용으로 지정
- 일반적으로 PatternLayout을 사용
- **DateLayout**, HTMLLayout, **PatternLayout**, SimpleLayout, XMLLayout

- **%p** 
  - debug, info, warn, error, fatal 등의 priority 가 출력된다. 
- **%m**
  -  로그내용이 출력됩니다
- **%d** 
  - 로깅 이벤트가 발생한 시간을 기록합니다.
  - 포맷 ( SimpleDateFormat에 따른 포맷팅을 하면 된다 ) 
    - %d{HH:mm:ss, SSS}
    - %d{yyyy MMM dd HH:mm:ss, SSS}
- **%t**
  -  로그이벤트가 발생된 쓰레드의 이름을 출력합니다. 
- **%%** 
  - % 표시를 출력하기 위해 사용한다. 
- %n 플랫폼 종속적인 개행문자가 출력된다. \r\n 또는 \n 일것이다. 

# 2. 사용

**FATAL**

 아주 심각한 에러가 발생한 상태. 시스템적으로 심각한 문제가 발생해서 어플리케이션작동이 불가능할 경우가 해당하는데, **일반적으로는 어플리케이션에서는 사용할 일이 없음**

 **ERROR**

 **요청을 처리하는 중** 문제가 발생한 상태를 나타냄

 **WARN**

 **처리 가능한 문제**이지만, 향후 시스템 **에러의 원인**이 될 수 있는 경고성 메시지를 나타냄

 **INFO**

 **로그인, 상태변경**과 같은 **정보성 메시지를** 나타냄

 **DEBUG**

 개발시 **디버그 용도**로 사용한 메시지를 나타냄

 **TRACE**

 log4j1.2.12에서 신규 추가된 레벨로서, **DEBUG 레벨이 너무 광범위한 것을 해결하기 위해서** 좀 더 상세한 상태를 나타냄

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN" "log4j.dtd">
<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">

	<!-- Appenders -->
	<appender name="console" class="org.apache.log4j.ConsoleAppender">
		<param name="Target" value="System.out" />
		<layout class="org.apache.log4j.PatternLayout">
			<param name="ConversionPattern" value="%-5p: %c - %m%n" />
		</layout>
	</appender>
	
	<!-- Application Loggers -->
	<logger name="com.midterm.controller">
		<level value="info" />
	</logger>
	
	<!-- 3rdparty Loggers -->
	<logger name="org.springframework.core">
		<level value="info" />
	</logger>
	
	<logger name="org.springframework.beans">
		<level value="info" />
	</logger>
	
	<logger name="org.springframework.context">
		<level value="info" />
	</logger>

	<logger name="org.springframework.web">
		<level value="info" />
	</logger>

	<!-- Root Logger -->
	<root>
		<priority value="warn" />
		<appender-ref ref="console" />
	</root>
	
</log4j:configuration>

~~~

# 3. 주의사항

- 반드시 Framework에서 제공한 Logger만을 사용한다.
- debug, info, warn, error로 구별하여 사용한다.
- 반드시 **발생 시간**과 **위치** 그리고 **내용**을 포함한다.
- Log는 **한 줄만 출력**한다.(debug log 제외)
- info log는 운영자에게 도움이 될 내용을 기록한다.
- warn log는 error는 아니나 잠재적인 error의 발생이 가능한 내용을 기록한다.
- error log는 error code와 함께 error에 대한 내용을 기록한다.

