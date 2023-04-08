# DDD START! 8장 애그리거트 트랜잭션관리



## 정리

| --            | 선점잠금                 | 비선점 잠금                                 | 오프라인 선점잠금             |
| ------------- | ------------------------ | ------------------------------------------- | ----------------------------- |
| 트랜잭션 범위 | 단일                     | 단일,<br>여러                               | 여러                          |
| 동시성        | X                        | O                                           | X                             |
| 처리방식      | row lock,<br>block, wait | version 번호,<br>no lock, no block, no wait | lock테이블,<br>exception page |



## 선점잠금 vs 비선점 잠금

| --                                                     | Order 도메인객체 | req의 version번호 |
| ------------------------------------------------------ | ---------------- | ----------------- |
| **여러 트랜잭션**<br>VersionConfilctException          | 6                | 5 (쓰임)          |
|                                                        |                  |                   |
| **단일트랜잭션** <br>OptimisticLockingFailureException |                  |                   |
| 시간1                                                  | 5                | X (안쓰임)        |
| 시간2                                                  | 6                | X (안쓰임)        |



```java


public class StartShippingService{//배송상태 변경
    @Transactional
    public void startShipping(StartSHippingRequest req){
        Order order = orderRepository.findById(new OrderNo(req.getOrderNumber()));
        checkOrder(order);        
        if(!order.matchVersion())
        //배송도착지 
        order.startShipping();
    }
}
```





## 질문

- 건수는 JDBC의 기본기능으로 insert, delete 건수를 반환하는데 JPA는?

  - ```java
    Query query = em.createQuery(
      "UPDATE Device d SET d.name =:Name WHERE d.locationId=:id");
    int updateCount = em.executeUpdate();
    int updateCount = em.executeUpdate();
    ```

  
