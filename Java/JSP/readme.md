# 1. HTTP

- 랜더링 : HTML표준에 따라 HTML Document로 화면을 생성하는 과정

## 1.1 요청, 응답

요청데이터

~~~
//요청줄
GET/HTTP/1.1               

//헤더 (헤더이름:헤더값)
HOST:www.daum.net
Connection:keep-alive
Accept: text/html
User-Agent: Mozilla/5.0
Accept-Encoding: gzip. deflate. sdch
Accept-Language: ko, en-US;q=0.8,en;q=0.6

//빈줄

//몸체

~~~



응답데이터

~~~
//요청줄
HTTP/1.1 200 OK               

//헤더 (헤더이름:헤더값)
Date: Wed, 22 Apr 2020 12:53:38 GMT
Expires: Sat, 01, Jan 1970 22:00:00 GMT
Content-Type: text/html;charset=UTF-8
Content-Language:ko

//빈줄

//몸체
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
</body>
</html>
~~~



# 2. JSP 기초

- 메모장으로 jsp 작성

  ~~~jsp
  <%@ page contentType="text/html; charset=UTF-8" %>
  <html>
  <head>
  <title>현재 시간</title>
  </head>
  <body>
  지금 : <%= new java.util.Date() %>
  </body>
  </html>
  ~~~

  

- 저장시 인코딩

  - ~~~jsp
    <%@ page contentType="text/html; charset=UTF-8" %>
    ~~~
  ~~~
  
    
  ~~~
  
- JSP파일을 읽어들여 클라이언트로 응답시 인코딩

  - ```jsp
    <%@page contentType="text/html; charset=UTF-8" %>
    ```

- 톰캣 기본인코딩(파일저장시, 응답 HTML 전송시)
  
  - ISO-8859-1



# 3. 기본객체

## 3.1 request

- 브라우저 정보

  - 
  - 

  | 메서드                 | 리턴 | 설명 |
  | ---------------------- | ---- | ---- |
  | getRemoteAddr()        |      |      |
  | getContentLength()     |      |      |
  | getCharacterEncoding() |      |      |

  

- 서버정보

- 요청정보

  - 요청파라미터
  - 요청헤더
  - 쿠키





