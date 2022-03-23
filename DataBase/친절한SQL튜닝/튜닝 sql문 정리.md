```sql
connect edu01@tws


-- 출력 컬럼수 조정
SET LINESIZE 200
-- 출력 로우수 조정
SET PAGESIZE 999

--힌트 갯수
SELECT count(*) FROM v$sql_hint;

--현재소유한 테이블
SELECT table_name
FROM user_tables
ORDER BY table_name;

--화면정리
clear screen


/*
실행계획 확인하는 방법
*/

-- 1. PLAN_TABLE생성
@?/rdbms/admin/utlxplan.sql

-- 2. 실행계획생성
explain plan for
select * from emp where empno = 7900;
--해석되었습니다.

-- 3-1. 실행계획확인(오라클이 제공하는 utlxpls.sql스크립트 이용)
-- 어디까지나 예상실행계획
@?/rdbms/admin/utlxpls

-- 3-A. 더 많은 정보확인
SELECT * FROM table(dbms_xplan.display(null, null, 'all'));
SELECT * FROM table(dbms_xplan.display(null, null, 'serial'));
SELECT * FROM table(dbms_xplan.display(null, null, 'parallel'));
SELECT * FROM table(dbms_xplan.display(null, null, 'outline'));
SELECT * FROM table(dbms_xplan.display(null, null, 'alias'));
SELECT * FROM table(dbms_xplan.display(null, null, 'projection'));
SELECT * FROM table(dbms_xplan.display(null, null, 'advanced'));





```

