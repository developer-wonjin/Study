# 3장. 애그리거트

## 3.1 애그리거트

`도메인 모델간의 관계파악` 을 위한 거시적 방법

- Before
  - 하위수준 (개별객체단위) : 개념파악 어려움, 개별구성요소 위주의 파악은 시간이 오래걸림
- After
  - 상위수준 (애그리거트) : 관련 객체들을 하나의 군으로 생각

### 3.1.1 애그리거트 특징

- 거시적으로 모델을 이해하게끔 도와줌
- 애그리거트 단위로 일관성을 관리하는데 도움을 줌
- 한 애그리거트 내에 속한 객체는 `유사한 라이프사이클`을 갖음
  - 함께 `생성 / 변경 / 소멸`되는 객체
  - 애그리거트(군집)은 자신이 속한 객체만 관리할 뿐 다른 애그리거트의 객체는 신경쓰지 않는다
- 에그리거트에 있는 `에그리거트 루트` 와 `그 외 모델(엔티티)`의 관계는 `일대다` 이다.
- 메세지 전달의 방향성
  - 루트에그리거트(1)에서 그외모델(多)로 단향적인 메세지 전달만 있는 것이 아니다!
  - `Order` 루트에그리거트 와 `OrderLine` 모델
    - `OrderLine`의 `Quantity`를 변경하면 `Order`의 `totalCount` 도 업데이트해야한다. 

### 3.1.2. 애그리거트에 관한 오해 (상품 vs 리뷰)

- **상품이 소멸되면 리뷰가 소멸됨(그렇다고 해서 같은 애그리거트가 아님)**
- 상품을 생성한다고 리뷰가 생성되지 않음
- 상품을 변경한다고 리뷰 변경되지 않음
- 상품을 변경하는 주체는 판매자, 리뷰를 변경하는 주체는 고객
- 즉,  도메인간에 관계가 `일대다 관계` 같은 포함관계라고 하더라도 ''무조건 같은 애그리거트이다''라고 오해하지 말것 

​	

- 
