# Laravel 학습계획

<div style="text-align: right"><b>작 성 일 : 20.05.22</b></div>
<div style="text-align: right"><b>작 성 자 : 도 원 진</b></div>



# 1. 목표 및 일정

### 목표

게시판리스트를 개발한 후, php로 개발된 서비스를 Laravel로 전환할 수 있는 개발역량 갖기

### 일정

총 학습일 :  10일 [2020.05.25(월) ~ 2020.06.05(금)]

| 날짜     | 내용                                                         | 비고 |
| -------- | ------------------------------------------------------------ | ---- |
| 25일(월) | 도서 1회독                                                   |      |
| 26일(화) | 1. 라우팅, 템플링, pdo, 엘로퀀트<br/>2. 게시판 개발 환경설정<br>3. 게시판 개발 |      |
| 27일(수) | 1. 내장클래스, Customizing<br>2. csrf토큰,  OAuth 로그인<br>3. Log클래스<br>4. Nginx rewrite설정 |      |



# 2. 게시판 구현을 위한 학습

도서 '라라벨로 배우는 실전PHP 웹프로그래밍' 학습

## 2.1. Apache, php설치

- Apache설치
- php연동
- 환경변수 path 등록
- http://magic.wickedmiso.com/56
- composer
- Laravel  설치
- 필요한 패키지 설치, 업데이트

## 2.2. 라우팅

- p.16~23
- 라우팅
- 데이터바인딩
- 블레이드
- 템플릿상속

## 2.3. 엘로퀀트 ORM 실습

- p.43, 82
- 간단 쿼리만 실습 후 종료 - 이후 사용 안함

## 2.4. 템플릿

- 단순 템플릿
- 컴파일이 되는 템플릿
- 레이아웃 + 템플릿 구성 방법

## 2.5. PDO

- 많은 종류의 데이터베이스 연결에 대해서 공통적인 인터페이스를 제공
- PDO와 mysqli 차이점 조사
- http://modernpug.github.io/php-the-right-way/#pdo_extension

## 2.6. 게시판리스트 개발 실습

- 게시판 개발진행

- Laravel Custom  class 만들고 통합하기

  

# 3. 회원가입, 로그인을 위한 학습

## 3.1. Laravel 제공 내장클래스를 사용한 개발

- p.79
- 내장 사용자 인증 
  -  `artisan` 명령
  - `RegisterController` 클래스

## 3.2 내장클래스 Customizing하기

- 필요 상황
  - 새로운 사용자를 등록할 때 필수로 입력해야 하는 form 항목을 변경할 때
  - 새로운 사용자가 데이터베이스에 입력되는 방식을 커스터마이징 할 때
-  `RegisterController` 클래스 수정
  - 해당 클래스는 애플리케이션에서 새로운 사용자를 검증하고 생성하는 역할을 함.

## 3.3. csrf토큰 설정

- p. 66, 109, 139, 211, 259
- CSRF 보호 미들웨어 살펴보기
- 토큰 발급하기
- 요청 시 받은 토큰값, 세션의 토큰값 일치여부 확인하기
- Ajax 에서  csrf 토큰 갱신

## 3.4. OAuth 로그인

- socialite 컴포넌트 설치(Laravel 제공)
- 구글, 페이스북, 네이버 진행

## 3.5. Log클래스로 로그기록하기

- Monolog 라이브러리를 *Log* 파사드로 래핑하여 제공

- 로깅 패키지가 여러개.

- https://www.lesstif.com/laravelprog/logging-24445592.html

  

# 4. 개발환경 교체

## 4.1. Apache ---> Nginx 웹서버 변경

-  Apache , Nginx 장단점 조사 - 필요없음
- https://wlsufld.tistory.com/5
- nginx - Laravel rewrite 설정

## 4.2. Php 웹프로젝트 Laravel로 변경

- 키스톤프로젝트 개발환경 교체진행













