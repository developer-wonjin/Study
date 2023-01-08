# 4장 리포지토리와 모델구현 JPA중심

## 4.1. 리포지토리 기본구현

- <u>CR</u>U<u>D</u> 중 U를 제외한 저장 / 조회 / 삭제 만 구현
- 애그리거트 루트 엔티티를 기준으로 JPA리포지토리를 작성할 것 (Spring-Data-JPA)

## 4.1. 맵핑구현

- 생성자 : JPA프로바이더가 사용하는 `기본 생성자`

  - 오직 JPA프로바이더만 사용해야 하기 때문에 다른 코드에서 사용하지 못하도록 `protected` 접근제어

- **AttributeConvertor**

  ```java
  public class Length{
      private int value;   // 1000
      private String unit; // 'mm'
  }
  ```

  ```sql
  WIDTH VARCHAR(20)  -- '1000mm'
  ```

- **값타입컬렉션**
  - ![4장 맵핑](C:\Users\eh\Desktop\dev\Study\개발방법론\DDD\4장 맵핑.jpg)

- **저장되는 형태 : 테이블(List) vs 컬럼(Set)**
- **테이블(List)** 
  - 긴 세로, 짧은 가로, 별도의 테이블, 순번idx 이용
- **컬럼(Set)**
  - 긴 가로, 짧은 세로, 한 컬럼에 콤마 ' , '를 이용
- **값타입을 통해 primitive 를 reference로 포장**
  - 식별자에 기능을 추가할 수 있다
  - 식별자의 필드의 `유효성검사` 로직을 `객체지향`적으로 수행가능
  - `Serializable` 인터페이스 구현
  - 식별자는 주소비교를 통한 `동등성` 비교가 아님
  - 식별자는 내용물(데이터)비교를 통한 `동일성` 비교임, 따라서 `equals` `hashcode` 메소드 구현은 필수

-  **값타입이 식별자필드를 갖는다고 해서 엔티티로 착각하지 말자** 

  - 식별자가 아닌 DB fk에 대한 필드다.
  - 즉, 추적불가능하고 공유불가능하고 엔티티에 포함됨
  - ![4장 값타입 1대1](C:\Users\eh\Desktop\dev\Study\개발방법론\DDD\4장 값타입 1대1.jpg)

  - ```java
    //위 그림에 대해서
    Article article = entityManager.find(Article.class, 1L);
    ```

  - 테이블`ARTICLE`을 조회하지만, 실제쿼리는 `ARTICLE`과 `ARTICLE_CONTENT` 를 조인하는 즉시로딩을 수행

  - 지연로딩으로 바꾸면 값타입 ArticleContent가 엔티티취급을 받음 -> 좋은 방법이 아님

  - **값타입이 아닌 엔티티(일대다 관계)가 더 어울리는 경우**

    - 테이블방식의 값타입에서 레코드양이 많을 때
    - 객체지향의 상속기능을 활용하고 싶을 때
    - 참고. 영속성전이(cascade persist, cascade remove) + 고아객체제거(orphan remove) 를 적용 필수



 ## 4.2. 애그리거트완전성 (feat. 트랜잭션, 로딩전략) 

- 애그리거트는 개념적으로 하나다 
- 상태조회시점에는 애그리거트가 불완전해도 된다. 
  - 애그리거트의 모든 요소가 로딩돼 있지 않아도 된다.
- 상태변경시점에는 애그리거트는 완전해야한다.

```java
@Transactional
public void removeOptions(ProductId id, int optIdxToBeDeleted){
    Product product = productRepository.findById(id);
    product.removeOption(optIdxToBeDeleted);
}
```

![4장 트랜잭션, 로딩, 애그리거트완전성](C:\Users\eh\Desktop\dev\Study\개발방법론\DDD\4장 트랜잭션, 로딩, 애그리거트완전성.jpg)

