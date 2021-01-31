# 1. 계정생성

설치진행 후 root 계정으로 db접속

~~~
create database 디비명 default character set utf8 //DB생성

CREATE USER '[계정]' @ '[호스트url]' identified by '[비번]'

GRANT [권한목록] ON [데이터베이스].[테이블명] TO '[계정]'@'[호스트url]'

//권한목록
select, insert, update, delete, create, drop
~~~

# 2. 테이블 생성

~~~
create table MEMBER(
	MEMBERID VARCHAR(10) NOT NULL PRIMARY KEY,
    PASSWORD VARCHAR(10) NOT NULL,
    NAME     VARCHAR(20) NOT NULL,
    EMAIL    VARCHAR(80)
)engine=innoDB	default character set = utf8;
~~~



# 3. Java

## 3.1 JDBC 

- API





