# 순수 JavaScript를 이용한 Ajax
~~~javascript
  function buttonClicked(){
 		      	
             //ajax..
             var xmlhttp = new XMLHttpRequest();
             xmlhttp.onreadystatechange
              = function(){//콜백함수...
                if(xmlhttp.readyState == 4 && xmlhttp.status ==200){//성공적으로 가져왔을 경우
                   var confirmData = JSON.parse(xmlhttp.responseText); //xmlhttp.responseText 는 무조건 텍스트임.
                   
                }
             };
             
             xmlhttp.open("POST","${pageContext.request.contextPath}/confirmCitizen",true);
             xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
             // key=value&key=value&..... 꼴의 데이터 전송
             xmlhttp.send('citi_name='+name.value + '&citi_identify1='+citi_identify1.value + '&citi_identify2='+citi_identify2.value);
    		    
    	 }
~~~

# 제이쿼리를 이용한 Ajax
## JSON객체가 주고받아지는 것이 아니라 JSON 양식을 띈 String이 주고 받아진다. 받은 후에 JSON으로 변환한다.


태그 추가  <script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
## 예제1 (Text를 응답받음)

```
data: {param:"Hello,jquery"}
```
형식을 보면 {key : String} 이며 이것이 표준이다.
~~~javascript
     function fn_process(){
       $.ajax({
         type:"get",
         dataType:"text",
         async:false,  
         url:"http://localhost:8090/pro16/ajaxTest1",
         data: {param:"Hello,jquery"},                  //data를 보낼때는 { key : value }로 보낸다.
         success:function (data,textStatus){
            $('#message').append(data);
         },
         error:function(data,textStatus){
            alert("에러가 발생했습니다.");ㅣ
         },
         complete:function(data,textStatus){
            alert("작업을완료 했습니다");
         }
      });	
   }	
~~~
위 코드로 부터 요청을 받게되는 서블릿코드는 아래와 같다.

### tip) <form> 태크의 <input> 에 있는 value들은 무조건 String으로 맵핑되지만 Ajax를 통해 request에 바인딩되는 객체는 Object 타입이므로 반드시 형변환 (String) 을해주어야 한다.

~~~java
package sec01.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AjaxTest1
 */
@WebServlet("/ajaxTest1")
public class AjaxTest1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandler(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandler(request, response);
	}

	private void doHandler(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

`		String param = (String) request.getParameter("param");
		System.out.println("param = " + param);
		PrintWriter writer = response.getWriter();
		writer.print("안녕하세요.서버입니다.");
	}

}

~~~

## 예제2 (XML을 응답받음)
요청시 xml 양식이 갖춰진 text 전송.
~~~java
package sec01.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AjaxTest2
 */
@WebServlet("/ajaxTest2")
public class AjaxTest2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String result = "";
		PrintWriter writer = response.getWriter();
		result="<main><book>"+
		         "<title><![CDATA[초보자를 위한 자바 프로그래밍]]></title>" +
		         "<writer><![CDATA[인포북스 저 | 이병승]]></writer>" +                             
		         "<image><![CDATA[http://localhost:8090/pro16/image/image1.jpg]]></image>"+
		      "</book>"+
		      "<book>"+
		         "<title><![CDATA[모두의 파이썬]]></title>" +
		         "<writer><![CDATA[길벗 저 | 이승찬]]></writer>" +                 
		        "<image><![CDATA[http://localhost:8090/pro16/image/image2.jpg]]></image>"+
		      "</book></main>";
		System.out.println(result);
		writer.print(result);
	}

}

~~~

### Ajax로 요청및 xml받아오기
응답받을 데이터타입 dataType을 정해주면 그 Type의 데이터가 응답받아짐. 즉, 항상 String은 아니란 말씀!
~~~html
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>도서 정보 출력창</title>
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script type="text/javascript">
      function fn_process(){
        $.ajax({
            
            type:"post",
            async:false, 
            url:"http://localhost:8090/pro16/ajaxTest2",
            dataType:"xml",
            
            success:function (info,textStatus){
              $(info).find("book").each(function(){  //info 라는 xml 데이터에서 book태그 요소선택
	              var title=$(this).find("title").text();
	              var writer=$(this).find("writer").text();
	              var image=$(this).find("image").text();
	              $("#bookInfo").append(
	                  	"<p>" +title+ "</p>" +
		                "<p>" +writer + "</p>"+
	 	                "<img src="+image + "   />"				
	              );
              });
            },
            error:function(data,textStatus){
               alert("에러가 발생했습니다.");ㅣ
            },
            complete:function(data,textStatus){
               //alert("작업을완료 했습니다");
            }
       }); 
     }
  </script>
</head>
<body>
<div id="bookInfo"></div>
<input type=button value="도서정보 요청"  onclick="fn_process()">
</body>
</html>

~~~
