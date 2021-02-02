<b>stateless 방식</b> : 웹Page간에 상태나 정보를 공유하지 않는 방식으로 Http프로토콜 통신함.<br>
[쿠키](#쿠키)<br>
[세션](#세션)<br>
# 쿠키
## 팝업창 만들기
자바스크립트를 이용해 브라우저 쿠키를 직접다루기
popupTest.html
~~~
<html>
<head>
  <meta charset="UTF-8">
 <title> 자바스크립트에서 쿠키 사용 </title>
 <script type = "text/javascript">
  // 페이지 로드 이벤트 처리
  window.onload = pageLoad;
  function pageLoad(){
  // 저장된 쿠키 읽어오기
   notShowPop =getCookieValue();
   if(notShowPop!="true"){
      window.open("popUp.html","pop","width=400,height=500,history=no,resizable=no,status=no,scrollbars=yes,menubar=no");
   }
  }

  // 쿠키 읽어오는 함수
  function getCookieValue(){   
     var result="false";
   // 쿠키 여부 확인
    if(document.cookie != ""){
      cookie = document.cookie.split(";"); 
      for(var i=0; i<cookie.length;i++){
	element=cookie[i].split("=");
	value=element[0];				 
	value=value.replace(/^\s*/,''); //정규표현식으로 문자열 공백제거함.
	if(value=="notShowPop"){
	 result= element[1];
        }
      }
   }
   return result;
  }
 function  deleteCookie(){
    document.cookie = "notShowPop=" + "false" + ";path=/; expires=-1" ;
  }
 </script>
</head>
<body>
  <form>
    <input type=button value="쿠키삭제"  onClick="deleteCookie()" >
  </form>
</body>
</html>

~~~
popUp.html
~~~
<html>
  <head>
  <meta charset="UTF-8">
  <script type="text/javascript">
   function setPopUpStart(obj){
      if(obj.checked==true){
         var expireDate = new Date();
	 expireDate.setMonth(expireDate.getMonth() + 1);
	 document.cookie ="notShowPop=" +"true" + ";path=/; expires=" + 
                                               expireDate.toGMTString();
         window.close();
      }
  }
  </script>
  </head>
  <body>
    알림 팝업창입니다.
	<br><br><br><br><br><br><br>
   <form>
    <input type=checkbox  onClick="setPopUpStart(this)" >오늘 더 이상 팝업창 띄우지 않기   
   </form>
  </body>
</html/>

~~~

# 세션
기본적으로 항상 객체가 대기함
## 세션은 브라우저의 요청을 받을 때 항상 세션객체를 대기시켜 놓는다.(기존의 것으로, 만약 없다면 새로 생성)
브라우저로 부터 name이 JSSESSIONID인 쿠키가 전달되지 않으면 새로 생성.<br>
JSESSIONID값이 있으면 그 ID값에 해당하는 세션객체를 대기시켜 놓는다.
이때, 세션이 새로 생성되면 별다른 메소드 없이 브라우저에게 ssessionID가 전송된다.( response.addCookie 같은 메소드를 쓰는 쿠키생성과정과 다름)

## 톰캣의 web.xml에 <session-config>태그로 기본유효시간이 30분으로 설정된 것을 확인할 수 있다.

## 톰캣종료시 session이 삭제되지 않을 경우를 대비
톰캣 context.xml 파일의 <Manager pathname=""/> 태그의 주석을 해제하면 해결됨.

## 세션을 이용한 로그인
~~~
public class SessionTest4 extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		if (session.isNew()){
			if(user_id != null){
				session.setAttribute("user_id", user_id);
				out.println("<a href='login'>로그인 상태 확인</a>");
			}else {
				out.print("<a href='login2.html'>세션new 다시 로그인 하세요!!</a>");
				session.invalidate();
			}
		}else{
			user_id = (String) session.getAttribute("user_id");
			if (user_id != null && user_id.length() != 0) {
				out.print("안녕하세요 " + user_id + "님!!!");
			} else {
				out.print("<a href='login2.html'>다시 로그인 하세요!!</a>");
				session.invalidate();
			}
		}
	}

}
~~~



