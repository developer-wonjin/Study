# XSS란?

# 1. 정의

게시판이나 웹 메일 등에 자바 스크립트와 같은 **스크립트 코드를 삽입** 해 개발자가 고려하지 않은 기능이 작동하게 하는 치명적일 수 있는 공격이다.

공격대상자 : 웹사용자

# 2. 종류

## 2-1. Reflected XSS

input 태그의 입력값으로 `<script> alert("메롱");</script>` 을 입력하면 개발자가 의도하지 않은 기능이 실행된다.

1. 따라서, 위의 스크립트를 포함하고 있는 URL을 사용자에게 노출시킨다.
2. 사용자가 URL을 클릭하면 스크립트가 포함된 URL을 통해 Request가 전송되고 , 스크립트가 포함된 reponse를 받게 된다.

## 2-2. Stored XSS

Reflected XSS와 달리, 공격자는 script를 게시물에 심어놓고 웹사이트에 업로드를 한다. 게시글의 URL을 사용자에게 노출하고 사용자가 게시글을 확인함으로써 URL에 대한 요청을 서버에 전송한다.

# 3. 위험성

1. 쿠키, 세션ID 탈취

2. 시스템 관리자 권한 획득

3. 악성코드 다운로드
   - 스크립트 자체 다운로드기능은 없지만, 리다이렉트기능으로 악성프로그램을 다운받을 수 있는 사이트로 이동이 가능함

4. 거짓 페이지 노출



# 4. 방지법

### 1. script 필터링

1.  PHP의 eregi함수와 같이 XSS공격에 주로 사용되는 문자필터링함수를 사용
2. 네이버 라이브러리 및 Filter 사용
   - https://osozaki.tistory.com/11



### 2. htmlentities사용

​	모든 특수문자를 html엔티티로 변환한다.

※ HTML 엔티티는 "&약어;" 및 "&#숫자;"의 형태를 표현하는 것을 의미한다. 예를 들어 <는 &lt;로, >는 &gt;로 표현한다.





# SQL Injection

# 1. 논리적 에러 'OR 1 = 1 --

인젝션 전) SELECT * FROM users WHERE id =  'INPUT1'         AND password = 'INPUT2'

인젝션 후) SELECT * FROM users WHERE id =  ' **'OR 1 = 1 --** ' AND password = 'INPUT2'

Users 테이블에 있는 모든 정보를 조회하게 됨으로 써 가장 먼저 만들어진 계정으로 로그인에 성공하게 됩니다. 보통은 관리자 계정을 맨 처음 만들기 때문에 관리자 계정에 로그인 할 수 있게 됩니다. 관리자 계정을 탈취한 악의적인 사용자는 관리자의 권한을 이용해 또 다른 2차피해를 발생 시킬 수 있게 됩니다.



# 2. Union 명령어

인젝션 전) SELECT * FROM Board WHERE title LIKE '%INPUT%' OR contents '%INPUT%'

인젝션 후) SELECT * FROM Board WHERE title LIKE '**%' UNION SELECT null, id, passwd FROM User**s --

사용자의 개인정보가 게시글과 함께 화면에 보여지게 됩니다. 

# 3. BIND SQL INJECTION 

## 	3-1.Boolean based SQL

인젝션 전) SELECT  * FROM Users WHERE id = 'INPUT1' AND PASSWORD = 'INPUT2'

인젝션 후) SELECT  * FROM Users WHERE id = 'abc123' and ASCII(SUBSTR(SELECT name FROM information_schema.tables WHERE table_type='base table' limit 0,1), 1, 1) > 100 --

위의 그림은 Blind Injection을 이용하여 데이터베이스의 테이블 명을 알아내는 방법입니다. (MySQL) 인젝션이 가능한 로그인 폼을 통하여 악의적인 사용자는 임의로 가입한 abc123 이라는 아이디와 함께 abc123’ and ASCII(SUBSTR(SELECT name From information_schema.tables WHERE table_type=’base table’ limit 0,1)1,1)) > 100 -- 이라는 구문을 주입합니다.

## 	3-2. Time Based SQL

인젝션 전) SELECT *FROM Users WHERE id = 'INPUT1' AND password = 'INPUT2'

인젝션 후) SELECT *FROM Users WHERE id = 'abc123' OR (LENGTH(DATABASE())=1 AND SLEEP(2)) --

현재 사용하고 있는 데이터베이스의 길이를 알아내는 방법





