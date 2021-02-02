# 스프링 라이브러리 버전 4.1.1로 변경
```xml
		<org.springframework-version>4.1.1.RELEASE</org.springframework-version>
    ...
    <dependency>//spring 4이상사용시 추가
			<groupId>org.springframework</groupId>
			<artifactId>spring-context-support</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>
		<dependency>
			<groupId>javax.mail</groupId>
			<artifactId>javax.mail-api</artifactId>
			<version>1.5.4</version>
		</dependency>
		<dependency>
			<groupId>com.sun.mail</groupId>
			<artifactId>javax.mail</artifactId>
			<version>1.5.3</version>
		</dependency>   
    
```

# web.xml에서 listener가 모든 xml을 로딩할 수 있게설정하자
```xml
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/*.xml</param-value> 
	</context-param>
```

# mail-=context.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
	
<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
  <property name="host" value="smtp.gmail.com" />
  <property name="port" value="587" />
  <property name="username" value="XXXXXXX@gmail.com" />
  <property name="password" value="XXXXX" />
  <property name="javaMailProperties">
    <props>
       <prop key="mail.transport.protocol">smtp</prop>
       <prop key="mail.smtp.auth">true</prop>
       <prop key="mail.smtp.starttls.enable">true</prop>
       <prop key="mail.smtp.socketFactory.class">javax.net.ssl.SSLSocketFactory</prop>
       <prop key="mail.debug">true</prop>
    </props>
  </property>
</bean>
 
<!-- You can have some pre-configured messagess also which are ready to send -->
	<bean id="preConfiguredMessage" class="org.springframework.mail.SimpleMailMessage">
   <property name="to" value="수신자@naver.com"></property>
   <property name="from" value="송신자@gmail.com"></property>
   <property name="subject" value="테스트 메일입니다."/>
	</bean>
</beans>
```

# Controller
```java
package com.myspring.pro28.ex03;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/*@Controller*/
@EnableAsync // service의 Async 메소드를 호출할 수 있따.
public class MailController {
    @Autowired
    private MailService mailService;
 
    @RequestMapping(value = "/sendMail.do", method = RequestMethod.GET)
    public void sendSimpleMail(HttpServletRequest request, HttpServletResponse response) 
                                                          throws Exception{
    	request.setCharacterEncoding("utf-8");
    	response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        mailService.sendMail("수신자@naver.com","테스트 메일","안녕하세요.보낸 메일 내용입니다.");
        mailService.sendPreConfiguredMail("테스트 메일입니다.");
        out.print("메일을 보냈습니다!!");
    }
}
```

# Service
```java
package com.myspring.pro28.ex03;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/*@Service("mailService")*/
public class MailService {
	@Autowired
	 private JavaMailSender mailSender;
    @Autowired
    private SimpleMailMessage preConfiguredMessage;
 
    @Async
	public void sendMail(String to, String subject, String body) {
      MimeMessage message = mailSender.createMimeMessage();
      try {
		MimeMessageHelper messageHelper = 
		new MimeMessageHelper(message, true, "UTF-8");
		//messageHelper.setCc("zzzzzz@naver.com");
		messageHelper.setFrom("송신자@naver.com", "홍길동");
		messageHelper.setSubject(subject);
		messageHelper.setTo(to); 
		messageHelper.setText(body );
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
