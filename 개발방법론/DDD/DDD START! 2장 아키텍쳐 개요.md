# 2장. 아키텍쳐의 개요

```
Q. 스프링MVC프레임워크가 왜 표현영역인가?

표현영역은 Filter, DispatcherServlet, Handler, Controller 와 같은 서블릿계열에 해당하는 것으로 이해했기에

Q. 서비스영역에서 호출할 메소드가
   MVC중 (DAO, Mapper)에서 호출할 메소드와 1대1 매칭이 되는 경우... 나는 누구고 여긴 어디인가...
   
   
board
  └	src
     ├ member
     |   ├ service (≒서비스)
     |   ├ dao     (≒인프라스트럭쳐)
     |   └ model   (≒도메인)
     |
     └ article
     |   ├ service
     |   ├ dao
     |   └ model
     ├ reply
     |   ├ dao
     
인터페이스의 역할 : 구현객체 교체의 용이함을 위해서
 예) fly()  
  - 비행기의 엔진점화
  - 참새의 날갯짓
  위 두 가지의 구체적인 방식에는 관심없다.
  fly가 중요할 뿐.
  인터페이스가 없다면 flyByEngine(), flyByWing()과  같이 개별 메소드시그니처를 갖게됨
  객체교체시 클라이언트 코드의 코드수정이 요구되는 불편함 발생
   
```

# 4가지 영역

## - 표현 영역

- `사용자의 HTTP요청`을 받음

- 이 요청을 응용영역이 원하는 형식으로 변환하여 `응용영역에 전달`

- 응용영역이 리턴하는 결과를 `JSON형식`으로 가공하여 `HTTP응답`

  

## - 응용  영역

- 사용자에게 제공할 `기능`구현

- 하단 `도메인 영역`의 `도메인모델`을 이용하여 응용영역의 `기능`구현

- `도메인영역`으로 `메세지`를 전달

- ```java
  public class CancelOrderServie{
      @Transactional
      public void cancelOrder(String orderId){
          Order order = findOrderById(orderId);
          if(order == null) throw new OrderNotFoundException(orderId);
          order.cancel();  
      }
  }
  ```

- 

## - 도메인 영역

- 응용영역이 전달한 `메세지`에 대응하는 `도메인모델`을 구현

- 도메인모델 은 `핵심로직`을 담고있다

  


## -인프라스트럭쳐 영역

- `구현기술` 을 다룸
  - DBMS연동
  - 메시징 큐
  - SMTP메일발송
  - REST API 호출(서버-서버) : openfeign, okhttp (http클라이언트 라이브러리)
- 도메인영역에 `구현기술`을 제공



# DIP

## - 도입배경

**서비스영역**

```java
public class CalculateDiscountService{
    private DroolsRuleEngine ruleEngine;
    
    public CalculateDiscountService(){
        ruleEngin = new DroolsRuleEngine();
    }
    
    public 리턴형 기능1();
    public 리턴형 기능2();
    public 리턴형 기능3();
    
}
```

**인프라스트럭쳐영역**

```java
public class DroolsRuleEngine{
    ...어쩌구 저쩌구
    //구현기술이 담겨있음
}
```

- **위 코드의 문제점**
  - 서비스영역의 `CalculateDiscountService` 클래스를 테스트하기 어렵다
    - `DroolsRuleEngine` 에 의존하고 있기 때문에 `DroolsRuleEngine` 의 구현이 완벽하게 완료될 때까지 테스트진행이 불가능함
  - 구현방식을 변경하기 어렵다.
    - `CalculateDiscountService` 는 `Drools 관련 로직`을 `정확히 알고있다`
    - `Drools`에 특화된 코드명 'discountCalculation' 을 지님

- **해결책**

  - 구체적인 `Drools` 를 모르게 하고

  - 추상적인 `책임` 만 (인터페이스) 알게하라

  - 고수준모듈이 인터페이스에 의존하게 하라

  - ```java
    public interface RuleDiscounter{
        public Money applyRules(Customer customer, List<OrderLine> orderLines);
    }
    ```

    ```java
    public class CalculateDiscountService{
        private RuleDiscounter ruleDiscounter;
        
        public CalculateDiscountService(RuleDiscounter ruleDiscounter){
            this.ruleDiscounter = ruleDiscounter;
        }
        
        public Money calculateDiscount(List<OrderLine> orderLines, String customerId){
            Customer customer = findCustomer(customerId);
            return ruleDiscounter.applyRules(customer, orderLines);
        }
        
        
    }
    ```

  -  따라서 가라로(??) 만든 `Stub` 객체로 교체하여 테스트가 가능함

- **도출에 관한 주의사항**

  - 고수준모듈과점에서 인터페이스를 도출할 것

