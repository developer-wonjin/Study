# 7장  도메인서비스



## 1. 특징

- `애그리거트`로 취급하기에는 `상태`가 없고 `기능`만 존재함.
- `애그리거트` A 와 B 를 함께 사용하는 기능이 존재하고 둘 중 어느 한 애그리거트에 기능을 종속시키지 못할 때
- 도메인계층에 소속
- 응용영역이 아니다.
  - Repository를 필드로 갖지 않음
  - Repository를 통해 조회, 저장 하지 않음
  - 트랜잭션을 관리하지 않음, 단건 DML은 가능할 듯



**[도메인서비스 도입 전]**

```java
public class Order {
    private Orderer orderer;
    private List<OrderLine> orderLines;
    private List<Coupon> usedCoupons;
    
    //메소드의 리턴값 최종주문금액은 DB에 영속할 정보가 아님
    //따라서 Order 애그리거트의 멤버필드로 속성이 존재하지 않는다.
    private Money calculatePayAmounts() {
        //초기주문금액
        Money totalAmounts = calulateTotalAmounts();
        
        //할인...쿠폰별(중복적용)
        Money dcAmountByCoupon = usedCoupons.stream()
            						.map(coupon -> discountByCoupon(coupon))
            						.reduce(Money(0), (ele1, ele2) -> ele1.add(ele2));
        
        //할인...회원별        
       	Money dcAmountByMember = discountByMember();
        
        return totalAmounts.minus(dcAmountByCoupon).minus(dcAmountByMember);
    }
    
    //List<OrderLine>이 관여됨
    private Moeny calulateTotalAmounts() {...} 
    
    private Money discountByCoupon(Coupon coupon) {...}
    
    private Money discountByMember(Orderer orderer) {...}
}
```

- 영속할 정보가 아니라면 `멤버필드`를 갖지 않는다.
  - (반례) 1장 [그림1.3]에는 totalAmount 가 필드로 있음





**[도메인서비스 도입 후]**

```java
public class DiscountCalulationService {
    public Money calculateDiscountAmounts(List<Coupon> usedCoupons, Orderer orderer){
        //할인...쿠폰별(중복적용)
        Money dcAmountByCoupon = usedCoupons.stream()
            						.map(coupon -> discountByCoupon(coupon))
            						.reduce(Money(0), (ele1, ele2) -> ele1.add(ele2));
        
        //할인...회원별        
       	Money dcAmountByMember = discountByMember(orderer);
        
        return dcAmountByCoupon.add(dcAmountByMember);
    }
    
    private Money discountByCoupon(Coupon coupon) {...}
    
    private Money discountByMember(Orderer orderer) {...}
}
```



