https://school.programmers.co.kr/learn/challenges?tab=sql_practice_kit



## 계층형쿼리 (Ansi)

```sql
with DEPTS (F1, F2, F3) AS (
	SELECT 
    	F1,
    	F2,
    	F3,
    FROM
    	T D
    WHERE
    	D.deptno is null
    union all
    SELECT
    	F1,
    	F2,
     	F3,
    FROM
    	T D
    WHERE
    	
)
```



# DATE 타입

기본 형식: `YYYY-MM-DD HH24:MI:SS`

```sql
-- 날짜 차이
SELECT SYSDATE - TO_DATE('2024-12-01', 'YYYY-MM-DD') AS DAY_DIFF
FROM DUAL;

-- 날짜 더하기
SELECT SYSDATE + 7 AS ONE_WEEK_LATER,
       SYSDATE - 30 AS ONE_MONTH_BEFORE
FROM DUAL;

-- 시간 더하기 (세 시간)
SELECT SYSDATE + (3 / 24) AS THREE_HOURS_LATER
FROM DUAL;

-- 연월일 숫자형 추출
SELECT EXTRACT(YEAR FROM SYSDATE) AS CURRENT_YEAR,
       EXTRACT(MONTH FROM SYSDATE) AS CURRENT_MONTH,
       EXTRACT(DAY FROM SYSDATE) AS CURRENT_DAY
FROM DUAL;

CURRENT_YEAR	CURRENT_MONTH	CURRENT_DAY
2024			12				29

```

```sql
-- 문자로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS CURRENT_DATE
FROM DUAL;

CURRENT_DATE
2024-12-29 14:00:00

-- 날짜로 변환
SELECT TO_DATE('2024-12-29 15:30:00', 'YYYY-MM-DD HH24:MI:SS') AS DATE_VALUE
FROM DUAL;

DATE_VALUE
2024-12-29 15:30:00

```

```sql
-- 자르기
SELECT TRUNC(SYSDATE) AS ONLY_DATE,
       TRUNC(SYSDATE, 'MM') AS FIRST_DAY_OF_MONTH
FROM DUAL;

ONLY_DATE	FIRST_DAY_OF_MONTH
2024-12-29	2024-12-01
```



# CHAR 타입

```sql
-- 문자열 자르기

-- 문자열 합치기
select concat('안녕', 123, '하세요') from dual

```





# Number타입

```sql
-- 반올림
ROUND(값, 0) : 소수점 1자리에서 반올림
ROUND(값, 1) : 소수점 2자리에서 반올림

-- AVG
AVG(컬럼)

-- 기본값 (NVL, COALESCE)
SELECT SUM(NVL(column_name, 0)) FROM table_name;
SELECT COALESCE(SUM(column_name), 0) FROM table_name;

```



# 계층쿼리

```sql
-- 업그레이드 된 아이템 구하기
-- https://school.programmers.co.kr/learn/courses/30/lessons/273711

-- 대장균들의 자식의 수 구하기
-- https://school.programmers.co.kr/learn/courses/30/lessons/299305

-- 멸종위기의 대장균찾기
-- https://school.programmers.co.kr/learn/courses/30/lessons/301651

-- 특정 세대의 대장균 찾기
-- https://school.programmers.co.kr/learn/courses/30/lessons/301650

-- 대장균의 크기에 따라 분류하기 1
-- https://school.programmers.co.kr/learn/courses/30/lessons/299307

-- 대장균의 크기에 따라 분류하기 2
-- https://school.programmers.co.kr/learn/courses/30/lessons/301649

-- 부모의 형질을 모두 가지는 대장균 찾기
-- https://school.programmers.co.kr/learn/courses/30/lessons/301647

-- 특정 형질을 가지는 대장균 찾기
-- https://school.programmers.co.kr/learn/courses/30/lessons/301646



```



# 문장정리

```sql
-- ONLINE_SALE 테이블에서 동일한 회원이 동일한 상품을 재구매한 데이터
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(*) >= 2

-- 종류별로 가장 큰 
-- (종류, MAX) 서브쿼리를 통해 (종류, 가장큰 수치)를 메인쿼리에서 활용한다.
-- https://school.programmers.co.kr/learn/courses/30/lessons/293261
SELECT 
    fi.ID,
    fni.FISH_NAME, 
    fi.LENGTH 
FROM FISH_INFO fi
INNER JOIN FISH_NAME_INFO fni
ON fi.FISH_TYPE = fni.FISH_TYPE
WHERE (fi.FISH_TYPE, fi.LENGTH) IN (SELECT FISH_TYPE, MAX(LENGTH)
                                    FROM FISH_INFO
                                    GROUP BY FISH_TYPE)
ORDER BY 1;

-- 연도별로 가장 큰
-- (연도, MAX) 인라인뷰를 만든다

-- 기간컬럼[START, END]에 겹치는지 확인하는 쿼리
상수 여행기간 [a, b]이 주어졌을 때 위 범위에 걸리는지
END >= a && START <= b



```

# 상위  N개

```sql
SELECT 
    ROWNUM rn, A.*
FROM (
	-- 비즈니스쿼리
) A
WHERE rn <= 100
```



# 이진수 포함여부 (&논리 연산자)

```sql
-- https://school.programmers.co.kr/learn/courses/30/lessons/276034
SELECT D.ID, D.EMAIL, D.FIRST_NAME, D.LAST_NAME
FROM DEVELOPERS D
WHERE D.SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME = 'Python')
OR D.SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME = 'C#') 
ORDER BY 1
```



# 매출액

- 주문량 * 상품금액





