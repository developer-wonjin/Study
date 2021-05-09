# Same Origin Policy



```js
document.location.origin
```

## 판단기준

**아래 세 개 조합으로 SameOrigin을 판단함**

- 스키마(프로토콜)
- 호스트
- 포트



# 특징

- Ajax로 다른 SameOrigin으로 요청후 응답을 받을 수 없음
  - window.open() 새로운 창을 만들어도 리소스를 못받음.
  - Iframe을 사용할 때도 적용받음.
- LocalStorage, SessionStorage은 Origin 마다 독립적으로 생성됨. 
  - Same Origin 으로 받은 document나 js에서만 위 storage에 접근 가능함.



# 중요성

- SOP가 없을 경우의 심각성
  - 