# JPA



## Mybatis와 비교

- 사용자 입력값을 받는 DTO객체를 Mybatis API의 파라미터로 사용된다.
- Mybatis API의 리턴값으로 DTO객체가 리턴되는데 위 DTO객체와 무관함.

## JPA의 Entity

- INPUT 할 때 사용되는 Entity객체와

  OUTPUT할 때 사용되는 Entity객체가 동일하다.

- 두 객체는 Persistence Context에서 관리된다.