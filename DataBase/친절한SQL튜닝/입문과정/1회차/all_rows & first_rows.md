```sql

create table t
as
select * from all_objects
order by dbms_random.value;

create index t_idx on t(owner, created);

begin
  dbms_stats.gather_table_stats
  ( ownname          => USER
  , tabname          => 'T'
  , estimate_percent => 100
  , block_sample     => true
  , method_opt       => 'for all columns size auto'
  );
end;
/

set autotrace traceonly exp


------------------------------------------------------------------------------------------
alter session set optimizer_mode = 'ALL_ROWS' ;
select * from t
where owner = 'SYS'
order by created ;
/* ALL_ROWS: 위 쿼리조건을 만족하는 전체데이터를 클라이언트쪽으로 Fetch하는 전제로
 * 가장 빠른 실행계획을 만드는 옵티마이저 모드 
 * 따라서, 인덱스를 구성해 놨어도 레코드의 양이 많기 때문에 TableFullScan하는 것이 더 빠르다고 
 * 옵티마이져가 판단함.
 */

------------------------------------------------------------------------------------------

alter session set optimizer_mode = 'FIRST_ROWS' ;
select * from t
where owner = 'SYS'
order by created ;
/* 전체데이터가 아닌 첫 커서가 가르키는 데이터만 빠르게 부분범위로 가져옴
 * 따라서 IndexRangeScan이더 빠르다고 판단함
 */


------------------------------------------------------------------------------------------

alter session set optimizer_mode = 'ALL_ROWS' ;
select /*+ first_rows */ * from t
where owner = 'SYS'
order by created ;
/*
 *  단, 옵티마이저모드보다 힌트가 더 우선순위가 높다.
 */

```