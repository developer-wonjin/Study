# StringBuffer에 저장한 후 문자열 전송

```java
package com.myspring.pro28.ex04;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@EnableAsync
public class MailController {
    @Autowired
    private MailService mailService;
 
    @RequestMapping(value = "/sendMail.do", method = RequestMethod.GET)
    public void sendSimpleMail(HttpServletRequest request, HttpServletResponse response) 
                                                          throws Exception{
    	request.setCharacterEncoding("utf-8");
    	response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
       StringBuffer sb = new StringBuffer();
 	   sb.append("<html><body>");
 		sb.append("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
 		sb.append("<h1>"+"제품소개"+"<h1><br>");
 		sb.append("신간 도서를 소개합니다.<br><br>");
 		sb.append("<a href='http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788956746425&orderClick=LAG&Kc=#N'>");
 		sb.append("<img  src='http://image.kyobobook.co.kr/images/book/xlarge/425/x9788956746425.jpg' /> </a><br>");
 		sb.append("</a>");
 		sb.append("<a href='http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788956746425&orderClick=LAG&Kc=#N'>상품보기</a>");
 		sb.append("</body></html>");
 		String str=sb.toString();
 		mailService.sendMail("ehdnjswls3@naver.com","신상품을 소개합니다.",str);
      
        out.print("메일을 보냈습니다!!");
    }
}
```

```java
package com.myspring.pro28.ex04;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailService {
	@Autowired
	 private JavaMailSender mailSender;
    @Autowired
    private SimpleMailMessage preConfiguredMessage;
 
    @Async
    public void sendMail(String to, String subject, String body)
    {
    	MimeMessage message = mailSender.createMimeMessage();
    	 
    	  try {
    	   MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    	   messageHelper.setSubject(subject);
    	   messageHelper.setTo(to);
    	   messageHelper.setFrom("jiwon@naver.com", "지원");
    	  messageHelper.setText(body,true);
    	   mailSender.send(message);
    	  }catch(Exception e){
    		  e.printStackTrace();
    	  }
    	
    }
 
    @Async
    public void sendPreConfiguredMail(String message) {
            SimpleMailMessage mailMessage = new SimpleMailMessage(preConfiguredMessage);
            mailMessage.setText(message);
            mailSender.send(mailMessage);
    }
}


```
