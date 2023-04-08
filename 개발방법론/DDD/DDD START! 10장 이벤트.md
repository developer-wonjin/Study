# DDD START! 9장 BoundedContext



# 1. 이벤트 등장인물

## 1.1. 이벤트

## 1.2. 이벤트 디스패처

- static 과 ThreadLocal 차이가 뭔지 모르겠다;;
  - ThreadLocal
    - 브라우저로부터 요청을 받는 톰캣은 스레드풀에서 가용 스레드(웨이터)를 꺼내와서 요청을 접대한다.
  - static 필드는 JVM에서 전역적으로 공유해서 사용할 수 있잖아

```java
public class Events {
    private static ThreadLocal<List<EventHandler<?>>> handlers =
            new ThreadLocal<>();
    
    // '이벤트 처리중 여부'를 보관하는 threadLocal --> 이게 어떨 때 쓰이는거지?
    private static ThreadLocal<Boolean> publishing =
            new ThreadLocal<Boolean>() {
                @Override
                protected Boolean initialValue() {
                    return Boolean.FALSE;
                }
            };

    public static void raise(Object event) {
        // [질문] 도메인모델에서 이벤트를 터트렸는데도 처리안하고 끝내는 경우가 있다?
        // 이게 왜 무한재귀를 방지해주는 거임?
        if (publishing.get()) return;

        try {
            publishing.set(Boolean.TRUE);

            List<EventHandler<?>> eventHandlers = handlers.get();
            if (eventHandlers == null) return;
            for (EventHandler handler : eventHandlers) {
                if (handler.canHandle(event)) {
                    handler.handle(event);
                }
            }
        } finally {
            publishing.set(Boolean.FALSE);
        }
    }

    // 메소드 파라미터로 EventHandler<?> handler 함수형인터페이스를 갖음
    public static void handle(EventHandler<?> handler) {
        if (publishing.get()) return;

        List<EventHandler<?>> eventHandlers = handlers.get();
        if (eventHandlers == null) {
            eventHandlers = new ArrayList<>();
            handlers.set(eventHandlers);
        }
        eventHandlers.add(handler);
    }  

    // Thread가 작업을 끝 마치면 내용물을 싹다 비워준다.
    // Thread가 소멸되지 않고 threadPool로 반환돼 재사용되기 때문
    public static void reset() {
        if (!publishing.get()) {
            handlers.remove();
            asyncHandlers.remove();
        }
    }
}
```



## 1.3. 이벤트 처리 핸들러

```java
public interface EventHandler<T> {
    void handle(T event);

    default boolean canHandle(Object event) {
        Class<?>[] typeArgs = TypeResolver.resolveRawArguments(
                EventHandler.class, this.getClass());
        return typeArgs[0].isAssignableFrom(event.getClass());
    }
}
```



## 1.4. 사용코드

```java
@Service
public class CancelOrderService {
    private OrderRepository orderRepository;
    private RefundService refundService;
    private CancelPolicy cancelPolicy;

    @Transactional
    public void cancel(OrderNo orderNo, Canceller canceller) {
        //[등록] 이벤트 처리핸들러 구현체 (람다식으로 handle메소드를 구현)
        Events.handle((OrderCanceledEvent evt) -> refundService.refund(evt.getOrderNumber()));

        Order order = findOrder(orderNo);
        if (!cancelPolicy.hasCancellationPermission(order, canceller)) {
            throw new NoCancellablePermission();
        }
        
        //메소드 내부에서 이벤트가 발행됨. Events.raise 호출
        order.cancel(); 

        //[해제]
        Events.reset();
    }
```

```java
@Entity
@Table(name = "purchase_order")
@Access(AccessType.FIELD)
public class Order {  
	public void cancel() {
        verifyNotYetShipped();
        this.state = OrderState.CANCELED;
        Events.raise(new OrderCanceledEvent(number.getNumber()));
    }
    ...
}
```



## 1.5 [정리] 동기 이벤트 

- [그림 10.7] 을 통해 알 수 있는 것
  - 트랜잭션이 `응용서비스`에서 시작하여 `이벤트 처리 핸들러` 까지 전파되는 것을 알 수 있다.
  - `도메인의 상태변경` 과 `이벤트 처리작업`까지 논리적으로 ALL or Nothing 으로 연결돼있음
  - 





## 1.6. 프록시를 이용한 RESET

```java
@Aspect
@Order(0) // service => reset => transaction 순으로 프록시객체 러시아인형만들기
@Component
public class EventsResetProcessor {
    
    //[질문] 서비스 메소드 중첩 실행갯수 저장할 threadLocal 변수
    private ThreadLocal<Integer> nestedCount = new ThreadLocal<Integer>() {
        @Override
        protected Integer initialValue() {
            return new Integer(0);
        }
    };

    @Around("execution(public * com.myshop..*Service.*(..))")
    public Object doReset(ProceedingJoinPoint joinPoint) throws Throwable {
        nestedCount.set(nestedCount.get() + 1);
        try {
            return joinPoint.proceed();
        } finally {
            nestedCount.set(nestedCount.get() - 1);
            if (nestedCount.get() == 0) {
                Events.reset();
            }
        }
    }
}
```

## 1.7 동기 이벤트의 문제점

> 서비스 => 도메인모델 ==> 이벤트디스패처 => 이벤트처리핸들러

- 낮은성능 (긴 트랜잭션)
  - 이벤트처리핸들러에게 이벤트 전달까지 논리적으로 포함돼있음
- 트랜잭션을 Nothing으로 만들어줘야함 (RollBack)
  - 비동기 이벤트로 진행하면 트랜잭션을 쪼개서 분리함 대신, 여러번의 이벤트 발생 재시도를 함



# 2. 비동기 이벤트

## 2.1. 로컬핸들러

> 도메인모델 => 이벤트 디스패처 => 이벤트처리 비동기핸들러

- 앞서 동기 이벤트에서 다뤘던 내용과 거의 일치, 새 스레드만 추가됐을 뿐
- ExecutorService (비동기 스레드풀) 을 이용
- ExecutorService  의 pool Size 초기화하는 코드가 필요 `AsyncEventsInitializer`



## 2.2.메세징 시스템

**[시스템1]**

> 도메인 모델 => 이벤트 디스패처 => RabbitMQ

**[시스템2]**

>RabbitMQ  =>  MessageListener => 이벤트 처리핸들러

- RabbitMQ는 도메인모델과 다른 별도의 스레드 혹은 프로세스



## 2.3. 이벤트 저장소

**[이벤트 처리방식 2가지]**

- 포워더 (배치성)
- API (배치 클라이언트에서 사용하게끔 API 제공)



**[위 둘의 공통점]**

- 이벤트 저장소를 지님
- 다양한 타입을 갖는 Event 객체를 DB의 EventEntry로 통일시킴



**[모든 응용서비스에 아래 코드를 적용해야함]**

```java
public class CancelOrderService {
    private OrderRepository orderRepository;
    private RefundService refundService;
    private CancelPolicy cancelPolicy;

    @Transactional
    public void cancel(OrderNo orderNo, Canceller canceller) {
	   	// 모든 응용서비스에 핸들러 등록 서비스를 넣어줘야함
        Events.handle((OrderCanceledEvent evt) -> refundService.refund(evt.getOrderNumber()));
 		...       
        
        // 발생된 이벤트를 처리할 수 있게끔
        order.cancel();    
        Events.reset();
    }
}
```



## 2.4. 추가로 고려할 점

- 이벤트 발생 원천위치를 식별하게끔 API를 제공하기

  - 예) Order 도메인모델과 관련된 이벤트만 제공하는 API

- 이벤트 전송실패 횟수 제한하기

- `이벤트 저장소` 방식은 이벤트를 영구적으로 보관한다

  - 반면, `이벤트 비동기 로컬핸들러`는 이벤트 처리 실패시 이벤트를 유실한다

- **[질문]** 이벤트 재처리 할 떄 방식

  - 마지막으로 처리한 이벤트의 순번을 기억해 두었다가 
  - 이미 처리한 순번의 이벤트가 도착하면
  - 해당 이벤트를 처리하지 않고 무시하는 것

- -------------------------------

  **evt_info_chang**   evt   evt_order_cancel   **evt_info_chang**

---------------------

