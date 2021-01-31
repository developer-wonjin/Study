# 4 HTML, JavaScript등

# 4-1. jQuery

- 엘리먼트를 선택하는 강력한 방법과 선택된 엘리먼트들을 효율적으로 제어할 수 있는 다양한 수단을 제공하는 자바스크립트 라이브러리



# 4-2. Bootstrap

-  부트스트랩은 트위터에서 사용하는 각종 레이아웃, 버튼, 입력창 등의 디자인을 CSS와 Javascript로 만들어 놓은 것이다. 웹 디자이너나 개발자 사이에서는 웹 디자인의 혁명이라고 불릴 정도로 폭발적은 반응을 얻는 프레임워크이다.

# 4-3. Cache control

- 서버에서 응답한 데이터를 캐시가 보관하고 있는 데이터로 대체되지 않게 설정하는 방법

  ~~~jsp
  <%  
  response.setHeader("Cache-Control","no-store");  
  response.setHeader("Pragma","no-cache");  
  response.setDateHeader("Expires",0);  
  if (request.getProtocol().equals("HTTP/1.1"))
          response.setHeader("Cache-Control", "no-cache");
  %>  
  ~~~

  

# 4-4. RESTFul URL, URI 차이

- 두 url을 비교해보자 http://test.com/test.pdf?docid=111    vs    http://test.com/test.pdf?docid=112 

동일 URL	:	http://test.com/test.pdf

다른 URI 	:	뒤의 쿼리(식별자)가 다름

# 4-5. JSON 기본 개념 정의, 데이터 방식 Gson

- JavaScript Object Notation
  - javaScript가 객체를 표현하는 표기법

- Gson
  - gson은 json구조를 띄는 직렬화된 데이터를 JAVA의 객체로 역직렬화, 직렬화 해주는 자바 라이브러리 입니다. 즉, `JSON Object -> JAVA Object` 또는 그 반대의 행위를 돕는 라이브러리 입니다.

# 4-6. Ajax 기본

1.  자바스크립트 

   ~~~javascript
   //객체 생성부분
   var xmlhttp;  
   if (window.XMLHttpRequest) {  
       xmlhttp = new XMLHttpRequest();
   } 
   else {  
       xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
   }
   
   //Ajax구현부분
   xmlhttp.onreadystatechange = function() {  
       if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            //통신 성공시 구현부분
       }
   }
   xmlhttp.open("GET", "exam.xml", true);  
   xmlhttp.send();  
   ~~~

   - readyState : ajax통신의 진행중인 상태를 알려줍니다. 값에 따라 의미하는 상태는 다음과 같습니다.
     - 0 : 초기화 되지 않은 상태 (open메소드가 아직 호출되지 않은 상태)
     - 1 : open메소드가 호출된 상태 (send메소드는 호출 되지 않은 상태)
     - 2 : 송신완료, 요청을 시작한 상태 ( 요청은 하지 않았지만 데이터가 아직 오지 않은 상태)
     - 3 : 수신 중인 상태 (데이터가 들어오고 있는 상태)
     - 4 : 수신 완료 (데이터를 모두 받은 상태)
   - Status : 데이터 수신의 성공 여부를 판단해주는 속성입니다 값에 따라 의미하는 상태는 다음과 같습니다
     - 0 : 로컬로 접근 성공을 의미합니다.
     - **200** : **해당 url로 접근 성공을 의미합니다.**
     - 403 : 접근이 거부되었음을 의미합니다.
     - **404 : 해당 url이 없음을 의미합니다.**
     - **500** : **서버오류를 의미합니다.**
   - responseXML : 받은 데이터를 XML타입으로 변환 시켜줍니다.
   - **responseText : 받은 데이터를 텍스트 타입으로 변환 시켜줍니다**
   - JSON.parse(xmlhttp.responseText); : json으로 변환해줌

2. jQuery

   - Ajax함수

   ~~~javascript
   $(document).ready(function() {
       $('#ajax').click(function() {
           $.ajax({
               url:'ajax.xml',
               type:'GET',
               dataType: 'xml',
               success: function(data){
                   $('#dictionary').empty();
                   $.each($(data).find('entry'), function(){
                       var $entry = $(this);
                       var html ='<div class="entry">';
                       html +='<h3 class="term">'+ $entry.attr('term'); +'</h3>';
                       html +='<div class="part">'+ $entry.attr('part'); +'</div>';
                       html +='<div class="definition">'+  $entry.text()+'</div>';
                       html +='</div>';
                       $('#dictionary').append(html);
                   });// end each
               }// end
           });// end ajax
           return false;
       });
   });
   ~~~

   - get, post, getJSON 함수도 있음



# 4-7. form태그의 enctype 속성

| Value                             | Description                                        |
| :-------------------------------- | :------------------------------------------------- |
| application/x-www-form-urlencoded | (기본값) 모든 문자 인코딩                          |
| multipart/form-data               | 인코딩 안함. 파일 업로드시 사용                    |
| text/plain                        | 공백은 + 기호로 변환하지만, 특수문자는 인코딩 안함 |

