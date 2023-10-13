친절한SQL튜닝 p.537

```sql
-- 현재 세션 정보 확인
SELECT sid, serial#, username, status, machine, program
FROM v$session
WHERE username IS NOT NULL;


alter session set sql_trace = true;
select * from emp where empno = 7900;
select * from dual;
alter session set sql_trace = false;

-- 트레이스파일 경로(폴더까지)
select value from v$diag_info
where name = 'Diag Trace';

-- 트레이스파일 경로(파일명까지)
select value from v$diag_info
where name = 'Default Trace File';


```