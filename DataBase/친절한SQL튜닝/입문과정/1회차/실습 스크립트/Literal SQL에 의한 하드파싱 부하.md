```sql
--[literal sql list 추출 활용 및 방법]
--https://cafe.naver.com/dbian/61
--저는 아래와 같이 추출합니다. 아래 쿼리는 10g부터 사용 가능합니다. 참고하세요.


-- Shared Pool의 Library Cache에 저장된 LiteralSQL (바인딩SQL은 해당안됨)
select *
from (
  select parsing_schema_name, sql_id, sql_text, executions
       , sum(executions) over (partition by force_matching_signature ) executions_sum
       , row_number() over (partition by force_matching_signature order by sql_id desc) rnum
       , count(*) over (partition by force_matching_signature ) cnt
       , force_matching_signature
  from   gv$sqlarea s
  where  force_matching_signature != 0
)
where  cnt > 5
--and    rnum = 1
order by cnt desc, sql_text
;



-- -- Shared Pool의 Library Cache에 저장된 바인딩SQL
select sql_text, parse_calls, loads, executions, fetches 
from   v$sql
where  parsing_schema_name = USER
and    sql_text like '%test1%'
and    sql_text not like '%v$sql%'
and    sql_text not like 'declare%' ;
```