```sql
-- 출력 컬럼수 조정
SET LINESIZE 200
-- 출력 로우수 조정
SET PAGESIZE 999

--AutoTrace : 결과집합, 예상실행계획, 실행통계 이 세가지를 보여줌

--1. '실행통계'까지 보여지기 위한 권한설정
@?/sqlplus/admin/plustrce.sql -- v_$sesstat뷰, v_$statname뷰, v_$mystat뷰에 대한 읽기권한을 설정해줌.
                              -- dba, select_catalog_role 등의 룰을 부여받지 않았을 때 유용함.

set autotrace on
select * from emp where empno = 7900;



set autotrace on (set autotrace off) -- resultSet, explain, statistics         
set autotrace on explain             -- resultSet, explain      X    
set autotrace on statistics          -- resultSet,    X     statistics

set autotrace traceonly              --     X      explain, statistics
set autotrace traceonly explain      --     X      explain      X
set autotrace traceonly statistics   --     X         X     statistics

```