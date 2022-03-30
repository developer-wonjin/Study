```sql
connect edu01@tws


-- 출력 컬럼수 조정
SET LINESIZE 200
-- 출력 로우수 조정
SET PAGESIZE 999

--힌트 갯수
SELECT count(*) 
FROM v$sql_hint;

--현재소유한 테이블
SELECT table_name
FROM user_tables
ORDER BY table_name;

--화면정리
clear screen


