# 파일업로드
## 1. fileupload 라이브러리 다운받기
jakarta.apache.org 접속 Commons클릭 Fileupload 1.3.3버전 zip파일 다운로드
zip 압축풀기후 commons-fileupload-1.3.3.jar 파일 복사 이후 이클립스 lib에 복붙
## 2. I/O 라이브러리 다운받기
https://commons.apache.org/proper/commons-io/download_io.cgi 접속 binaries의 zip파일 다운받기<br>
압축풀고 commons-io-2.6.jar파일을 이클립스 lib에 복붙<br>

uploadForm.jsp
~~~jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    
<html>
<head>
<meta charset="UTF-8">
 <head>
   <title>파일 업로드창</title>
 </head> <body>
   <form action="${contextPath}/upload.do"  method="post" enctype="multipart/form-data" >
      파일1: <input type="file" name="file1" ><br>
      파일2: <input type="file" name="file2" > <br>
      파라미터1: <input type="text" name="param1" > <br>
      파라미터2: <input type="text" name="param2" > <br>
      파라미터3: <input type="text" name="param3" > <br>
 <input type="submit" value="업로드" >
</form>
 </body>
</html>

~~~

FileUpload.java
~~~java
package sec01.ex01;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class FileUpload
 */
@WebServlet("/upload.do")
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
			String encoding = "utf-8";
			File currentDirPath = new File("C:\\file_repo");//업로드할 파일의 디렉토리경로를 지정
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setRepository(currentDirPath);// 파일경로 등록
			factory.setSizeThreshold(1024 * 1024); // 1M byte 임 이유는.... 2^10 이 1k byte이고 2^20이 1M byte이다.

			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List items = upload.parseRequest(request);
				for (int i = 0; i < items.size(); i++) {
					FileItem fileItem = (FileItem) items.get(i);
	
					if (fileItem.isFormField()) {
						System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					} 
				   	else {
						System.out.println("파라미터명:" + fileItem.getFieldName());
						System.out.println("파일명:" + fileItem.getName());
						System.out.println("파일크기:" + fileItem.getSize() + "bytes");
	
						if (fileItem.getSize() > 0) {
							int idx = fileItem.getName().lastIndexOf("\\");
							if (idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx + 1);
							File uploadFile = new File(currentDirPath + "\\" + fileName);
							fileItem.write(uploadFile);
						} // end if
					} // end if
				} // end for
			} catch (Exception e) {
				e.printStackTrace();
			}
	}

}

~~~




# 파일다운로드

first.jsp
~~~jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>       

<%
  request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>파일 다운로드 요청하기</title>
</head>
<body>
 
 <form method="post"  action="result.jsp" >
	 <input type=hidden  name="param1" value="duke.png" /> <br>
	 <input type=hidden  name="param2" value="duke2.jpg" /> <br>
   <input type ="submit" value="이미지 다운로드">	 
 </form> 
</body>
</html>

~~~
result.jsp
~~~jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>       
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<meta charset=”UTF-8">
<c:set var="file1" value="${param.param1}"  />    
<c:set var="file2" value="${param.param2}"  />
 
<title>이미지 파일 출력하기</title>
</head>
<body>

파라미터 1 :<c:out value="${file1}"  /><br>
파라미터 2 :<c:out value="${file2}"  /><br>

<c:if test="${not empty file1 }">
<img src="${contextPath}/download.do?fileName=${file1}"  width=300 height=300 /><br>
</c:if>
<br>
<c:if test="${not empty file2 }">
<img src="${contextPath}/download.do?fileName=${file2}"  width=300 height=300 /><br>
</c:if>
파일 내려받기 :<br>
<a href="${contextPath}/download.do?fileName=${file2}" >파일 내려받기</a><br>
</body>
</html>

~~~
FileDownload.java<br>
output스트림 ( 브라우저로 응답기능)<br>
fileInput스트림 (프로그램안으로 파일데이터 가져오는 기능)
~~~java
package sec01.ex02;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownload
 */
@WebServlet("/download.do")
public class FileDownload extends HttpServlet {
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
		//다운로드할 파일이 위치한 디렉토리
    		String file_repo = "C:\\file_repo"; 
		//다운받을 파일이름
		String fileName = (String) request.getParameter("fileName"); 
		System.out.println("fileName=" + fileName);
		//브라우저로 전송을 담당할 output스트림객체
		OutputStream out = response.getOutputStream(); 
		//다운받을 파일의 전체경로
		String downFile = file_repo + "\\" + fileName; 
		//다운로드받을 파일의 파일객체
		File f = new File(downFile); 
		
    //헤더세팅
    response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + fileName);
		
    //프로그램내부로 파일정보를 input해올 스트림
    FileInputStream in = new FileInputStream(f);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer);// input스트림에서 버퍼로 한번에 읽어드리기
			if (count == -1) // 버퍼로 읽어올 데이터가 더이상 없으면 중지.
				break;
			out.write(buffer, 0, count); // 버퍼에 채워진 데이터를 전송하기
		}
		in.close();
		out.close();
	}

}

~~~

# 부록(최범균 JSP 프로그램) jsp3.0 이상부터 지원되는 part인터페이스를 이용함.
web.xml
~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
		http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
	version="3.1">
    <servlet>
        <servlet-name>UploadServlet</servlet-name>
        <servlet-class>fileupload.UploadServlet</servlet-class>
        <multipart-config>
            <location>C:\practice</location> <--임시파일 경로지정-->
            <max-file-size>-1</max-file-size>
            <max-request-size>-1</max-request-size>
            <file-size-threshold>1024</file-size-threshold>
        </multipart-config>
    </servlet>
    
    <servlet-mapping>
        <servlet-name>UploadServlet</servlet-name>
        <url-pattern>/upload</url-pattern>
    </servlet-mapping>

</web-app>

~~~
업로드서블릿
~~~java
package fileupload;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class UploadServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		resp.setContentType("text/html; charset=utf-8");

		PrintWriter writer = resp.getWriter();
		writer.println("<html><body>");

		String contentType = req.getContentType();
		if (contentType != null
				&& contentType.toLowerCase().startsWith("multipart/")) {
			printPartInfo(req, writer);
		} else {
			writer.println("multipart가 아님");
		}
		writer.println("</body></html>");
	}

	private void printPartInfo(HttpServletRequest req, PrintWriter writer)
			throws IOException, ServletException {
		Collection<Part> parts = req.getParts();
		for (Part part : parts) {
			writer.println("<br/> name = " + part.getName());
			String contentType = part.getContentType();
			writer.println("<br/> contentType = " + contentType);
			if (part.getHeader("Content-Disposition").contains("filename=")) {
				writer.println("<br/> size = " + part.getSize());
				String fileName = part.getSubmittedFileName();
				writer.println("<br/> filename = " + fileName);
				if (part.getSize() > 0) {
					part.write("c:\\temp\\" + fileName);
				//	part.delete();
				}
			} else {
				String value = req.getParameter(part.getName());
				writer.println("<br/> value = " + value);
			}
			writer.println("<hr/>");
		}
	}

}

~~~
