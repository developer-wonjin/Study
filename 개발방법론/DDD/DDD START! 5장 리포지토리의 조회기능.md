# 5장 리포지토리의 조회기능



## 5.1. 검색을 위한 스펙

**SpringDataJPA를 사용하는 경우**

```java
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order>{
   //공백   
}
```

위 소스와 같이 `JpaSpecificationExecutor`을 상속하는 것만으로 `Specification`인자를 파라미터로 갖는 메소드를 갖게된다.

```java
T findOne(Specification<T> spec);
List<T> findAll(Specification<T> spec);
Page<T> findAll(Specification<T> spec, Pageable pageable);
List<T> findAll(Specification<T> spec, Sort sort);
long count(Specification<T> spec);
```



**스펙 정의코드**

```java
public class OrderSpec{
    public static Specification<Order> memberName(final String memberName){
        return new Specification<Order>(){
            pulbic Predicate toPredicate(Root<Order> root, CriteriaQuery<?> query, CriteriaBuilder builder){
                //Order엔티티에서 시작
                if(StringUtils.isEmpty(memberName))return null;
                
                Join<Order, Member> m = root.join("member", JoinType.INNER);//Member엔티티 조인
                return builder.equal(m.get("name"), memberName);//입력값 memberName을 갖는 엔티티만 필터링
            }
        };
    }
    
    public static Specification<Order> isOrderStatus(){
        return new Specification<Order>(){
            public Predicate toPredicate(Root<Order> root, CriteriaQuery<?> query, CriteriaBuilder builder){
                
                return builder.equal(root.get("status"), OrderStatus.ORDER);
            }
        }
    }
}
```

**스펙을 사용하는 서비스코드**

```java
import static OrderSpec.*;

//OrderService
public List<Order> findOrders(String name){
	Specification<Order> spec = where(memberName(name)).and(isOrderStatus());
    List<Order> result = orderRepository.findAll(spec);
}
```



## 5.2. 정렬, 페이징

`Criteria` 에 의존하기 보다 QueryDSL 로 구현하는게 더 나을듯



## 5.3. 조회전용 기능 구현

- `Repository`는 `애그리거트`를 저장, 조회, 삭제하는 것에 초점을 둔 저장소이다.

  - 여러 애그리거트를 로딩해야 하는 경우 => Repository를 이용하는 것은 부적절

    - ID로 참조할 때 장점?이 사라짐

      

- **동적인스턴스**

  ```java
  Query query = em.createQuery("SELECT m.username, m.age FROM Member m");//두번쨰 인자로 명확한 지정 아닐때
  List<Object[]> resultList = query.getResultList();
  
  //방법1.
  List<UserDTO> userDTOs = new ArrayList<UserDTO>();
  for(Object[] row : resultList){
      UserDTO userDTO = new UserDTO((String)row[0], (Integer)row[1]);
      userDTOs.add(userDTO);
  }
  
  //방법2 (더 나은 방법)
  TypedQuery<UserDTO> query = em.createQuery(
      "SELECT new 패키지.UserDTO(m.username, m.age) FROM Member m", UserDTO.class);
  List<UserDTO> resultList = query.getResultList();
  ```

- **하이버네이트의 @SubSelect (DB의 View)**
  - 테이블과 맵핑관계를 갖지 않음
  - 쿼리결과와 맵핑관계을 맺음

