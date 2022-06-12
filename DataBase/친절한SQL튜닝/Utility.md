```sql
-- 테이블이 소유한 인덱스의 구성컬럼 정보
SELECT a.table_name 
     , a.index_name  
     , a.column_name 
  FROM all_ind_columns a 
 WHERE a.table_name = '테이블명' 
 ORDER BY a.index_name
        , a.column_position;

-- 테이블이 소유한 인덱스의 클러스터링펙터
select INDEX_NAME, TABLE_NAME, CLUSTERING_FACTOR from dba_indexes where table_name = 'A_TBL';
```