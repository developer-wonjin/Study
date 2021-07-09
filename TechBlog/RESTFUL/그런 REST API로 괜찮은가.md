# REST

# 1. XML-RPC(1998)

- 원격으로 다른 시스템의 메소드를 호출할 수 있는 프로토콜
- 추후 SOAP으로 이름이 바뀜



# 2. REST

**정의: **   분산 하이퍼미디어 시스템(예: 웹)을 위한 아키텍쳐 스타일

(아키텍쳐스타일: 제약조건의 모음)

- 반드시 HyperText - Driven
- Versioning을 하지 말것

## 2.1. REST를 구성하는 제약조건(스타일)

- Client-Server
- Stateless(상태를 유지하지 않음)
- Cache
- **Uniform Interface**
- Layered System
- Code on demand(선택사항)  : 서버에서 클라이언트로 코드를 보내서 실행시킬 수 있어야함

```
[Uniform Interface 제약조건]
1. identification of resources (URI로 식별)
2. manipulation of resources through representations
3. Self-descriptive messages[잘못지켜지고있음]
4. Hypermedia as the engine of application state(HATEOAS) [잘못지켜지고있음]
```

## 2.1.1 Self -descriptive message

- 메세지는 스스로를 설명해야한다.

  - **즉, HTTP요청/응답 메세지만으로 모든 것을 해석해 낼 수 있어야함.**

- Self -descriptive하지 못한 경우

  - (목적지가 없음)

    ```
    GET / HTTP/1.1 
    ```

    

  - (Content-Type을 알려줘야 json문자열을 json으로 파싱가능함)

  - (명세를 밝혀줘야함)

    ```
    HTTP/1.1 200 OK
    [{"op": "remove", "path": "a/b/c"}] 
    ```

    

- 올바른 Self -descriptive

  - ```
    GET / HTTP/1.1
    HOST: www.example.org
    ```

  - ```
    HTTP/1.1 200 OK
    Content-Type: application/json-patch+json
    [{"op": "remove", "path": "a/b/c"}]
    ```

    

## 2.1.2 HATEOAS

- 애플리케이션의 상태는 Hyperlink를 이용해 전이되어야한다.

- 만족하는 예

  - HTML의 `<a href>

  - 응답메세지의 Link헤더

    ```
    HTTP/1.1 200 OK
    Content-Type: application/json
    Link: </articles/1>; rel="previous"
          </articles/3>; rel="next";
    {
    	"title": "The second article",
    	"contents": "blah blah....."
    }
    ```

## 2.2 Uniform Interface을 하는 이유?

- **서버와 클라이언트의 독립적인 진화를 위해**
  - 서버가 기능이 바뀌는 상황(기존의 API가 추가/변경/삭제되는 경우)  클라이언트가 업데이트할 필요가 없어짐.
- UniformInterface를 잘 지키는 웹
  - 웹페이지 변경 --> 브라우저업데이트 안해도 됨.
  - 브라우저업데이트 --> 웹페이지변경 안해도 됨.
  - HTTP명세가 변경 --> 그래도 웹은 잘 동작함
  - HTML명세가 변경 --> 그래도 웹은 잘 동작함.
- 반면에, UniformInterface를 못 지키는 앱
  - 모바일디바이스에 빈번한 앱업데이트를 요구함.....



## 2.3. Rest가 웹의 독립적 진화에 도움을 주었나?

- HTTP에 지속적 영향을 줌
  - Host헤더 추가(Self descriptive)
  - 길이 제한을 다루는 방법이 명시(414 URI Too Long등)
  - URI에서 리소스의 정의가 추상적으로 변경됨:  파일의 위치 ---> **"식별하고자 하는 무언가"**
  - 기타 HTTP와 URI에 많은 영향을 줌
  - HTTP/1.1 명세 최신판에 REST에 대한 언급이 들어감



## 2.4. self-descriptive와 Hateoas가 독립적 진화에 도움이 되는것이 맞는가?

- Self-descriptive
  -  확장가능한 커뮤니케이션을 가능하게 만든다.
  - sefl-descriptive하면 HTTP메세지는 언제나 해석가능함 (서버나 클라이언트의 변경이 발생하더라도)
- Hateoas
  - 애플리케이션 상태의 전이의 late binding
  - 어디서 어디로 전이가 가능한지 미리 결정되지 않는다.
  - 어떤 상태로 전이가 완료되고 나서야 그 다음 전이될 수 있는 상태가 결정된다.
  - **쉽게 말해서: 링크는 동적으로 변경될 수 있다.**

# 3. REST 개발

## 3.1. REST의 필요성

- 시스템전체를 통제할 수 없을 때 
- 시스템의 진화에 관심이 있을 때

## 3.2 REST API 어떻게 개발할까?

## 3.2.1 제약조건을 모두 만족하도록 개발해야함.

- 비교

| --           | 흔한 웹페이지 | HTTP API  |
| ------------ | ------------- | --------- |
| protocol     | HTTP          | HTTP      |
| 커뮤니케이션 | 사람-기계     | 기계-기계 |
| Media Type   | HTML          | JSON      |

| --               | HTML                                           | JSON                                                         |
| ---------------- | ---------------------------------------------- | ------------------------------------------------------------ |
| Hyperlink        | 가능(a태그 등)                                 | 정의X                                                        |
| Self-descriptive | HTML명세를 통해<br>(모든 태그의 정의를 기술함) | 불완전함<br>(문법해석은 가능하나 의미를 해석하려면<br>별도로 API문서가 필요함) |



## 3.2.2. HTML과 JSON비교

**[HTML응답]**

```html
GET /todos HTTP/1.1
Host: example.org

HTTP/1.1 200 ok
Content-Type: text/html

<html>
    <body>
        <a href="https://todos/1">회사 가기</a>
        <a href="https://todos/2">집에 가기</a>
    </body>
</html>
```

HTML의 Self-descriptive측면

- 응답메세지의 Content-Type을 보고 
  - media type이 text/html임을 확인가능하다.
- HTTP명세에는 media type이 IANA에 등록되어있다고 명시함.
- INNA에서 text/html설명을 찾는다.
- INNA에 따르면 text/html의 명세는 http://www.w3.org/TR/html 이므로 링크를 찾아가 명세를 해석함
- 명세에 모든 HTML태그의 해석방법이 구체적으로 나와있으므로 이를 해석할 수 있음

HTML의 HATEOAS측면

- a태그를 통해 다음 상태로 전이될 수 있으므로 HATEOAS를 만족함.



**[JSON응답]**

```json
GET /todos HTTP/1.1
HOST: example.org

HTTP/1.1 200 OK
Content-Type: application/json

[
    {"id": 1, "title": "회사가기"},
    {"id": 2, "title": "집에가기"}
]
```

JSON의 Self-descriptive측면

- 응답메세지의 Content-Type을 보고 
  - media type이 application/json임을 확인가능하다.
- HTTP명세에는 media type이 IANA에 등록되어있다고 명시함.
- INNA에서 application/json의 명세는 draft-ietf-jsonbis-rfc7159bis-04이므로 링크를 찾아가 명세를 해석한다.
- 명세에 JSON문서를 파싱하는 방법이 명시되어있으므로 성공적으로 파싱한다.
- **그러나, "id"가 무엇을 의미하고 "title"이 무엇을 의미하는 방법까지 알 길이 없다.**

JSON의 HATEOAS측면

- 다음 상태로 전이할 링크가 없다. FAIL





## 3.2.3 JSON을 RESTFUL하게 고쳐보자

**Self-descriptive 조건 추가**

방법1: Media type

- 미디어 타입을 하나 정의한다
- 미디어 타입 문서를 작성한다. 이 문서에 "id"가 뭐고 "title"이 뭔지 의미를 정의한다.
- IANA에 미디어타입을 등록한다. 
- 정의한 미디어타입이 적힌 HTTP메세지로부터 메세지의 의미를 온전히 해석할 수 있다.
- 단점: 매번 media type을 정의해야한다.

방법2: profile

```json
GET /todos HTTP/1.1
HOST: example.org

HTTP/1.1 200 OK
Content-Type: application/json
Link: <https://example.org/docs/todos>; rel="profile"

[
    {"id": 1, "title": "회사가기"},
    {"id": 2, "title": "집에가기"}
]
```

- "id", "title"이 뭔지 의미를 정의한 명세를 작성한다.
- Link헤더에 profile relation 으로 해당 명세를 링크한다.
- 이제 메세지를 보는 사람은 명세를 찾아갈 수 있다.
- 이제 문서의 의미를 온전히 해석할 수 있다.
- 단점: 
  - 클라이언트가 Link헤더와 profile을 이해해야한다.
  - Content negotiation을 할 수 없다.



**Hateoas추가**

방법1: data로

- "title" 속성명처럼 "links"를 추가한다.
- 링크를 표현하는 방법을 직접 정의해야함.

방법2: 하이퍼링크를 표현하는 방법을 정의한 명세들을 활용

- JSON API
- HAL
- UBER
- Siren
- Collection+json

단점: 기존 API를 많이 고쳐야함.(침투적)



방법3: Link, Location 헤더로 링크를 표현한다.

**결론: data와 header 모두 활용하는 것을 권장**



Q. Hyperlink는 반드시 URI여야 하는건 아닌가?

A. 상관없음 다 괜찮음

| 종류                    | 예                            |
| ----------------------- | ----------------------------- |
| URI                     | https://toss.im/users/eungjun |
| URI reference(absolute) | /users/eungjun                |
| URI reference(relative) | eungjun                       |
| URI Template            | /users/{username}             |



Q. Media type등록은 필수인가?

A. 하면 좋을 뿐, 응답받는 주체가 이해할 수 있는 API면 등록할 필요없다.







