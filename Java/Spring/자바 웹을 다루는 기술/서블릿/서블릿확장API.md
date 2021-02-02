[URL분석](#URL분석)<br>
[ServletContext & ServletConfig 사용법](#ServletContext_&_ServletConfig_사용법)<br>
[HttpSessionBindingListener를 이용한 로그인 접속자수 표시](#HttpSessionBindingListener를_이용한_로그인_접속자수_표시)<br>

Q. Servlet생성할 때, next 눌러서 체크란에 ingerited abstract methods가 체크되어 있는데 기본으로... 왜그런거임?

# URL분석
## @webServlet("/fisrt/*") , 요청url : localhost:8090/pro10/first/base
### contextPath) request.getContext(); 
컨택스트까지 절대경로<br>
결과: /pro10 
### request.getRequestURL().toString();
요청url전체<br>
결과: http://localhost:8090/pro10/first/base 
### request.getServletPath();
서블릿맵핑값에 대응하는 요청값 전체<br>
결과: /first/base 
### request.getPathInfo();
서블릿맵핑("/first/*")에서 맨 마지막 / 값<br>
결과: /base 
### request.getRequestURI();
<br>
결과: /pro10/first/base<br>

# 포워드 기능
## redirect / Refresh / location
새로운 요청흐름이 발생함. 브라우저에게 강제함.<br>

redirect : response.sendRedirect("***.jsp");<br>
refresh : response.addHeader("Refresh",경과시간(초);url=***.jsp");<br>
location : location.href = '***.jsp';

## dispatch
기존 요청흐름을 유지함. 이전의 request 객체가 계속 유지됨.
RequestDispatcher dis = request.getRequestDispatcher("***.jsp");
dis.forward(req, res);

# ServletContext & ServletConfig 사용법

## ServletContext클래스
### 톰캣컨테이너 실행시 각 컨텍스트(웹어플리케이션)마다 한 개의 컨택스트객체를 생성.
### 톰캣컨테이너 종료시 컨텍스트객체 소멸
### 어플리케이션 내에서 공통 자원이나 정보를 서블릿들끼리 공유
1) 서블릿에서 파일 접근가능하게 함.
2) 자원바인딩 setAttribute, getAttribute
3) 로그파일기능
4) 컨텍스트에서 제공하는 설정 정보 제공 기능
~~~
톰캣컨테이너
    ┗ app1(컨텍스트)
          ┗ ServletContext    // 컨택스트마다 1개
          ┗ A Servlet
              ┗ A ServletConfig // 서블릿마다 1개
          ┗ B Servlet
              ┗ B ServletConfig // 서블릿마다 1개
    ┗ app2(컨텍스트)
    ┗ app3(컨텍스트)
    ┗ ...
~~~
따라서, 단일 웹어플리케이션내에서 모든 사용자가 공통으로 사용하는 데이터는 ServletContext에 바인딩해서 사용할것.
~~~java
//A.java
ServletContext context = getServletContext();
context.setAttribute("name", object);
~~~
~~~java
//B.java
ServletContext context = getServletContext();
Object obj = (형변환)getAttribute("name");
~~~

### ServletContext 의 초기화 파라미터 기능<br>
/WEB-INF/web.xml
~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app ...>
	<context-param>
		<param-name>menu_member</param-name>
		<param-value>회원등록  회원조회 회원수정</param-value>
	</context-param>
	<context-param>
		<param-name>menu_order</param-name>
		<param-value>주문조회  주문등록 주문수정 주문취소</param-value>
	</context-param>
	<context-param>
		<param-name>menu_goods</param-name>
		<param-value>상품조회  상품등록 상품수정 상품삭제</param-value>
	</context-param>
</web-app>
~~~
java소스
~~~java
 ServletContext context = getServletContext();
 String menu_member = context.getInitParameter("menu_member"); // menu_member는 어플리케이션 공용으로 쓰이는 초기화 값임.
~~~
### ServletContext 의 파일 입출력 기능<br>
/WEB-INF/bin/init.txt생성
~~~
회원등록 회원조회 회원수정, 주문조회 주문수정 주문취소, 상품조회 상품등록 상품수정 상품삭제
~~~
java소스파일
~~~java
ServletContext context = getServletContext();
		InputStream is = context.getResourceAsStream("/WEB-INF/bin/init.txt");
		BufferedReader buffer = new BufferedReader(new InputStreamReader(is));

		String menu = null;
		String menu_member = null;
		String menu_order = null;
		String menu_goods = null;
		while ((menu = buffer.readLine()) != null) {
			StringTokenizer tokens = new StringTokenizer(menu, ",");
			menu_member = tokens.nextToken();
			menu_order = tokens.nextToken();
			menu_goods = tokens.nextToken();
		}
~~~

## servletConfig (HttpServlet이 servletConfig인터페이스 자손임)
~~~
Servlet  ServletConfig   // 인터페이스
    \     /
     \   /  (구현)
      \ /
 GenericServlet         // 클래스
       |
       | (상속) ~ 프로토콜에 따라 메소드 service()를 오버라이딩해서 구현함.
       |
  HttpServlet           // 자식클래스 : http프로토콜을 채택하여 웹브라우저 기반 서블릿을 만들 때 상속받아 사용한다.
~~~
### urlPattern과 InitParameter 지정가능
이클립스에서 servlet을 생성할 때 urlPattern과 서블릿초기화파라미터를 지정할 수 있다.
물론 이 방법은 web.xml로 가능하다. 최범균의 JSP프로그래밍 p.536 (지금은 잘 안쓰는 방법)
~~~java
@WebServlet(name="initParamServlet",
        urlPatterns = { "/sInit", "/sInit2" }, initParams = {
		@WebInitParam(name = "email", value = "admin@jweb.com"), 
		@WebInitParam(name = "tel", value = "010-1111-2222") })
public class InitParamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String email = getInitParameter("email");
		String tel = getInitParameter("tel");
	}
}
~~~
### loadOnStartUp지정 및 ServletContext객체 얻기
loadOnStartUp은 web.xml에서도 가능함.(지금은 잘 안쓰는 방법)
ServletContext객체를 얻을 땐, init 메소드의 ServletConfig객체 파라미터를 이용한다.

~~~java
@WebServlet(name = "loadConfig", urlPatterns = { "/loadConfig"},loadOnStartup=1)
//@WebServlet(name = "loadConfig", urlPatterns = { "/loadConfig"})
public class LoadAppConfig extends HttpServlet {
	private ServletContext context;
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("LoadAppConfig의 init 메서드 호출");
		context = config.getServletContext();
		String menu_member = context.getInitParameter("menu_member");
		String menu_order = context.getInitParameter("menu_order");
		String menu_goods = context.getInitParameter("menu_goods");
		
		context.setAttribute("menu_member", menu_member);
		context.setAttribute("menu_order", menu_order);
		context.setAttribute("menu_goods", menu_goods);
	}
}
~~~

# HttpSessionBindingListener를 이용한 로그인 접속자수 표시
HttpSessinoBindingListener 인터페이스를 구현한 클래스의 객체는 Session에 바인딩 / 언바인딩 될 때 이벤트메소드가 실행된다.
~~~java
package sec04.ex01;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoginImpl implements HttpSessionBindingListener {
	String user_id;
	String user_pw;
	static int total_user = 0;

	public LoginImpl() {
	}

	public LoginImpl(String user_id, String user_pw) {
		this.user_id = user_id;
		this.user_pw = user_pw;
	}

	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {
		System.out.println("사용자 접속");
		++total_user;
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		System.out.println("사용자 접속 해제");
		total_user--;
	}
}

~~~

HttpServlet
~~~java
package sec04.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginTest
 */
//@WebServlet("/login")
public class LoginTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		System.out.println(user_id);
		LoginImpl loginUser = new LoginImpl(user_id, user_pw);
		if (session.isNew()) {
			session.setAttribute("loginUser", loginUser);
		}
		

		out.println("<head>");
		out.println("<script  type='text/javascript'>");
		out.println("setTimeout('history.go(0);', 5000)");
		out.println("</script>");
		out.println("</head>");
		out.println("<html><body>");
		out.println("아이디는 " + loginUser.user_id + "<br>");
		out.println("총 접속자수는" + LoginImpl.total_user + "<br>");
		out.println("</body></html>");

	}

}

~~~

# HttpSessionListener를 이용한 접속자수 , 접속자 아이디 표시하기
~~~java
package sec04.ex02;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class LoginImpl
 *
 */
@WebListener
public class LoginImpl implements HttpSessionListener {
	String user_id;
	String user_pw;
	static int total_user = 0;

	public LoginImpl() {
	}

	public LoginImpl(String user_id, String user_pw) {
		this.user_id = user_id;
		this.user_pw = user_pw;
	}

	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		System.out.println("세션 생성");
		++total_user;
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		System.out.println("세션 소멸");
		--total_user;
	}

}
~~~
로그인 서블릿
~~~java
package sec04.ex02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class LoginTest
 */
@WebServlet("/login")
public class LoginTest extends HttpServlet {
	ServletContext context = null;
	List user_list = new ArrayList();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		context = getServletContext();
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		LoginImpl loginUser = new LoginImpl(user_id, user_pw);
		
		if (session.isNew()) {
			session.setAttribute("loginUser", loginUser);
			user_list.add(user_id);
			context.setAttribute("user_list", user_list);
		}
		System.out.println(user_list);
		out.println("<html><body>");
		out.println("아이디는 " + loginUser.user_id + "<br>");
		out.println("총 접속자수는" + LoginImpl.total_user + "<br><br>");
		out.println("접속 아이디:<br>");
		List list = (ArrayList) context.getAttribute("user_list");
		for (int i = 0; i < list.size(); i++) {
			out.println(list.get(i) + "<br>");
		}
		/*for (int i = 0; i < user_list.size(); i++) {
			out.println(user_list.get(i) + "<br>");
		}*/
		out.println("<a href='logout?user_id=" + user_id + "'>로그아웃 </a>");
		out.println("</body></html>");
	}

}

~~~
로그아웃 서블릿
~~~java
package sec04.ex02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutTest
 */
@WebServlet("/logout")
public class LogoutTest extends HttpServlet {
	ServletContext context;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		context = getServletContext();
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String user_id = request.getParameter("user_id");

		session.invalidate();

		List user_list = (ArrayList) context.getAttribute("user_list");
		user_list.remove(user_id);
/*		context.removeAttribute("user_list"); 
		context.setAttribute("user_list",user_list); 
*/		
		
		out.println("<br>로그아웃 했습니다.");
	}

}

~~~
