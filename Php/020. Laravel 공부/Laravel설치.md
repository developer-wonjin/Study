# Laravel 설치

<div style="text-align: right"><b>작 성 일 : 20.06.02</b></div>
<div style="text-align: right"><b>작 성 자 : 도 원 진</b></div>



# 1. Laravel 설치

## 1.1 기본환경

- WebServer(Apache24, NginX)가 설치되있고 php와 연동된 것을 전제함

- WebServer의 가상호스트가 설정되어 있으며 가상호스트의 DocmentRoot가 앞으로 생성될 라라벨 프로젝트의 public 디렉토리로 설정되야 함

  

## 1.2 컴포저 설치_라라벨프로젝트 설치도구

### 1.2.1 PHP 기본기능외에 확장기능을 제공하는 관리자 프로그램( PHP의 의존성 관리도구)

- 자바 의존성관리도구인 Maven과 동일한 기능을 수행한다
-  Composer을 사용하기 위해서는 php의 openssl 확장 기능을 활성화해야 한다. 
-  php.ini 파일에서 아래 부분의 주석을 해제한 후에 웹서버를 재시작한다.

~~~ini
;extension=php_openssl.dll
~~~

- 이외에도, pdo_mysql, mbstring, tokenizer 도 주석을 풀어준다.

- https://packagist.org/  : 컴포저의 메인 저장소이다. 이 곳에서 필요한 라이브러리를 검색하고 composer.json에 기능을 추가하고 cmd 명령어를 통해 설치할 수 있다.
- https://opentutorials.org/course/62/5221 참고

### 1.2.2. 다운로드

- https://getcomposer.org/Composer-Setup.exe



## 1.3. 사용법

### 1.3.1 프로젝트 Import (다른  프로젝트 사용할 때)

- composer.json을 통해 프로젝트가 의존하고 있는 라이브러리를 다운받아옴.

~~~json
{
    "require": {
        "dflydev/markdown": "1.0.3"
    }
} 
~~~

- 아래와 같은 명령을 실행하면 composer.json 의 내용을 읽어와 정의된 라이브러리를 설치한다.

  ~~~
  $php composer.phar install
  ~~~

  

### 1.3.2. 프로젝트 생성하기 (라라벨 프로젝트 생성 - 최신버전)

~~~
$composer create-project laravel/laravel 폴더명 --prefer-dist --verbose
~~~



### 1.3.3.  특정버전의 라라벨 프로젝트 생성

**https://github.com/laravel/laravel 에서 설치가능한 버전 조회**

![20200602_170339](C:\Users\Bizspring\Desktop\20200602_170339.png)

**설치 명령어 실행**

~~~
$composer create-project laravel/laravel="5.8.26" myProject
~~~



