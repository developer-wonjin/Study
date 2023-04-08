# SQL Trace

# 0. 어려운 방법
```sql
alter session set sql_trace = true;
select * from big_table where id = 10;
select * from dual;
alter session set sql_trace = false;
-- C:\app\ora19c\diag\rdbms\ora19c\ora19c\trace 경로에 트레이스 파일 생성됨
```

```sql
select value from v$diag_info
where name = 'Diag Trace';

select value from v$diag_info
where name = 'Default Trace File';
```





# 1. 아주 편한 SQL Trace확인방법(.trc 파일을 메모리에 로드해서 보기)

## 1.1. sql을 수행하면서 '실제실행계획', '실행통계'를 `메모리상`에 수집하기
```sql
-- 출력 컬럼수 조정
SET LINESIZE 200
-- 출력 로우수 조정
SET PAGESIZE 999


SELECT /*+ gather_plan_statistics */ *  --메모리상에 실행통계가 로드됨.
FROM
    emp
WHERE
    empno = 7900;
```

<br>

## 1.2.a 직전에 수행한SQL의 `'sql_id'`, `'child_number'`를 얻기
```sql
SELECT
    prev_sql_id as sql_id,
    prev_child_number as child_no
FROM
    v$session
WHERE
    sid = userenv('sid')
AND 
    username is not NULL
AND 
    prev_hash_value <> 0;
```

<br>

## 1.2.b 더 이전에 수행한 SQL의 `'sql_id'`, `'child_number'`를 얻기
`v$sql`: 라이브러리캐시에 캐싱된 커서의 수행통계를 저장한 뷰
```sql
SELECT 
    sql_id, child_number, sql_text, last_active_time
FROM 
    v$sql
WHERE
    sql_text LIKE '%' || 'select/* comment */%from%emp%dept%' ||'%'
ORDER BY
     last_active_time DESC;
```

<br>

## 1.3. SQL Trace확인방법1
`v$sql_plan_statistics_all`뷰를 이용한 불편한 방법
```sql
-- 위에서 얻은 sql_id, child_number을 이용해 수행통계를 얻을 수 있다.
SELECT last_output_rows, operation||' '||options
FROM v$sql_plan_statistics_all A
WHERE sql_id = ${sql_id}
AND child_number = ${child_number}
ORDER BY id;

Rows REAL_PLAN
------------------------------------
1    SELECT STATEMENT
1    TABLE ACCESS BY INDEX ROWID
1    INDEX UNIQUE SCAN
```

<br>

## ★★★ 더 좋은 확인방법★★★
## 1.3. SQL Trace확인방법2
`dbms_xplan패키지`의 `display_cursor함수`를 이용하면 더 편하다.
```sql
SELECT *
FROM table(dbms_xplan.display_cursor(${sql_id}, ${child_number}, ${option}));

SELECT *
FROM table(dbms_xplan.display_cursor(null     , null           , 'allstats last'));

-----------------------------------------------------------------------------------------------
--| id |   Operation   |   Name   | Starts | E-Rows | A-Rows |    A-Time    | Buffers | Reads |
                                                      ★★★                  ★★★
-----------------------------------------------------------------------------------------------
--|  1 |     Table Acc |     DEPT |      1 |      1 |      12|00:00:00:00.04|      20 |     18|
--|  2 |      NESTED L |          |      1 |     12 |      25|00:00:00:00.93|       8 |     17|
--|  3 |       TABLE A |     EMP  |      1 |     12 |      12|00:00:00:00.04|       4 |     16|
--|  4 |         INDEX |EMP_SAL_ID|      1 |     12 |      12|00:00:00:00.02|       2 |      8|
--|  5 |       INDEX R | DEPT_PK  |     12 |      1 |      12|00:00:00:00.01|       4 |      1|

-- Starts : 몇번 실행했는가?
-- E-ROWS(Estimated Rows) :  옵티마이저의 예상 실행 레코드
-- A-ROWS(Actual    Rows) : 실제 실행 레코드★★★
-- A-Time(Actual    Time) :  실제 실행 시간
-- Buffers(Consistent Read: CR): 절대일량 = 논리적인I/O   ★★★
-- Reads(Physical Read: PR): 수치가 0일 때는 디스크I/O가 발생하지 않는 상황임. 


위 쿼리를 수행후 트레이스를 살펴보면 Reads 수치가 있음.
단, 또 수행을 하면 물리적I/O가 발생하지 않기 때문에 Reads컬럼이 표에서 안보임.
그땐 sharedpool을 싹 비워준 뒤 다시 쿼리를 실행하면 Reads가 보임.
alter system flush shared_pool;
```
<br>

## [주의사항 2가지]
> 주의사항1)<br>
> 직전SQL이 쿼리툴의 내부적인 동작으로 변경될 때 제대로된 SQLTrace가 나올 수 없는 문제가 있음.
- sqlPlus
  - `set serveroutput off` 로 해결
  ```sql 
  set serveroutput off -- 내부적인 동작을 꺼줌
  
  SELECT /*+ gather_plan_statistics */ *  --메모리상에 실행통계가 로드됨.
  FROM emp;

  SELECT *
  FROM table(dbms_xplan.display_cursor(null     , null           , 'allstats last'));
  ```

- QueryBox
  - AutoTrace 실습을 위해 켜두었던 `세션통계`를 꺼준다.
  ```sql
  --세션통계 비활성화
  SELECT /*+ gather_plan_statistics */ *  
  FROM emp;

  SELECT *
  FROM table(dbms_xplan.display_cursor(null     , null           , 'allstats last')); -- 잘나옴.
  ```

<br>

> 주의사항2)<br>
> Fetch가 아직 덜 된 부분범위처리상태<br>
> 즉, 쿼리에 대한 trace정보를 수집하고 있는 중<br>
> 즉, cursor가 EOF에 도달하지 않은 상태 
- 

```sql
  SELECT /*+ gather_plan_statistics */ *  
  FROM small_table; --68,000건 테이블이나 first_rows옵티마이저 설정때문에 100건 또는 200건만 일단 fetch됨.

  SELECT *
  FROM table(dbms_xplan.display_cursor(null     , null           , 'allstats last')); -- 비정상적으로 나옴.

```
  
  - 해결책A:  cursor가 EOF까지 도달하여 cursor가 종료된 이후에야 trace정보가 셋팅이되는 것임.<br>
    - 따라서 fetch를 모두 마무리해야함쿼리박스 그리드결과 > 우클릭 > 모든데이터Fetch
  - 해결책B:  업무상 끝까지 fetch하지 못하는 상황이면 v$sql에서 sql_id, child_number얻고 그것을 null값대신에 함수의 파라미터로 너어줄 것.

<br><br>
## 2. 전통적인SQL Trace확인
> trace 파일수집
```sql
-- 1. sql을 수행하고 .trc확장자를 갖는 파일로 trace수집하기
alter session set sql_trace = true;
수행할 sql문1
수행할 sql문2
수행할 sql문3
...
alter session set sql_trace = false;
```

> trace파일로 수집됐는지 경로확인
```sql
SELECT value
FROM   v$diag_info
WHERE  name = 'Diag Trace'; -- trace파일 디렉토리경로

value
-----------------------------------
/oracle/diag/rdbms/ora11g/trace


SELECT value
FROM   v$diag_info
WHERE  name = 'Default Trace File'; -- trace파일 파일경로

value
-----------------------------------
/oracle/diag/rdbms/ora11g/trace/ora11g_ora_22827.trc
```

> trace리포트 확인
```sql
-- 3. 리눅스서버에서 리포트생성
$ tkprof ora11g_ora_22827.trc report.prf sys=no -- sys=no 옵션: SQL파싱과정이 내부적으로 수행되는 것을 제외해줌.

-- 4. 파일열람해서 Trace보기
$ vim report.prf
```