**Oracle(오라클)**에서는 테이블 생성시 날짜와 시간을 저장하는 **DATE** 타입에 아래와 같이 **SYSDATE**로 기본값을 부여할 수 있다.

```sql
CREATE
    TABLE
        ORACLE_TABLE(
            DATE_CREATED DATE DEFAULT SYSDATE
        )
;
```

 

당연한 생각에 **MySQL**에서도 동일한 시도를 해보았다. **MySQL**의 `DATETIME`은 **Oracle**의 `DATE`와 동일한 역할을 하는 타입이다.

```sql
CREATE
    TABLE
        MySQL_Table(
            DateCreated DATETIME DEFAULT NOW()
        )
;
```

당연히 될 줄 알았지만 결과는 오류가 발생했다. 구글링 결과 MySQL 버전에 따라 아래와 같이 처리해야 한다.



#### MySQL v5.6.5 이상일 경우

------

`NOW()` 함수가 아닌 `CURRENT_TIMESTAMP` 함수를 사용해야 한다.

```sql
CREATE
    TABLE
        MySQL_Table(
            DateInserted DATETIME DEFAULT CURRENT_TIMESTAMP
        )
;
```



