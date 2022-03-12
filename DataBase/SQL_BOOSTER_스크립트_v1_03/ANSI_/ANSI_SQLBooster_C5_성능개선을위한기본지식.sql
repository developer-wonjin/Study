
-- ************************************************
-- PART II - 1.1.3 SQL1
-- ************************************************

-- 실행계획 만들기
EXPLAIN PLAN FOR
SELECT * FROM T_ORD WHERE ORD_SEQ = 4;


-- ************************************************
-- PART II - 5.1.3 SQL2
-- ************************************************

-- 실행계획 확인하기
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());


-- ************************************************
-- PART II - 5.1.4 SQL1
-- ************************************************

-- 실행계획 생성 및 조회
EXPLAIN PLAN FOR
SELECT  *
FROM    T_ORD T1
        ,M_CUS T2
WHERE   T1.CUS_ID = T2.CUS_ID
AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
AND     T2.CUS_GD = 'A';

SELECT  *
FROM    TABLE(DBMS_XPLAN.DISPLAY());



-- ************************************************
-- PART II - 5.1.4 SQL2
-- ************************************************

-- 좀 더 복잡한 실행계획 생성 및 조회
EXPLAIN PLAN FOR
SELECT  T3.ITM_ID ,SUM(T2.ORD_QTY) ORD_QTY
FROM    T_ORD T1
        ,T_ORD_DET T2
        ,M_ITM T3
WHERE   T1.ORD_SEQ = T2.ORD_SEQ
AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
AND     T2.ITM_ID = T3.ITM_ID
AND     T3.ITM_TP = 'ELEC'
GROUP BY T3.ITM_ID;

SELECT  * FROM TABLE(DBMS_XPLAN.DISPLAY());




-- ************************************************
-- PART II - 5.1.5 SQL1
-- ************************************************

-- 실제 실행계획 만들기
SELECT  /*+ GATHER_PLAN_STATISTICS */
		*
FROM    T_ORD T1
        ,M_CUS T2
WHERE   T1.CUS_ID = T2.CUS_ID
AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
AND     T2.CUS_GD = 'A';



-- ************************************************
-- PART II - 5.1.5 SQL2
-- ************************************************

-- 실제 실행계획을 만든 SQL의 SQL_ID찾아내기
SELECT  T1.SQL_ID ,T1.CHILD_NUMBER ,T1.SQL_TEXT 
FROM    V$SQL T1
WHERE   T1.SQL_TEXT LIKE '%GATHER_PLAN_STATISTICS%'
ORDER BY T1.LAST_ACTIVE_TIME DESC;



-- ************************************************
-- PART II - 5.1.5 SQL3
-- ************************************************

-- 실제 실행계획 조회하기(각자의 SQL_ID를 사용할 것)
SELECT  *
FROM    TABLE(DBMS_XPLAN.DISPLAY_CURSOR('bmjjk7adpg82g',0,'ALLSTATS LAST'));






-- ************************************************
-- PART II - 5.2.2 SQL1
-- ************************************************

-- 각각 하드 파싱이 수행되는 SQL.
SELECT * FROM T_ORD T1 WHERE T1.CUS_ID = 'CUS_0001';

SELECT * FROM T_ORD T1 WHERE T1.CUS_ID = 'CUS_0002';



-- ************************************************
-- PART II - 5.2.2 SQL2
-- ************************************************

-- 바인드 변수로 처리된 SQL
SELECT * FROM T_ORD T1 WHERE T1.CUS_ID = :v_CUS_ID;



-- ************************************************
-- PART II - 5.2.4 SQL1
-- ************************************************

-- IO 블록 확인하기
SELECT  /*+ GATHER_PLAN_STATISTICS */
        COUNT(*)
FROM    T_ORD T1
WHERE   T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD');

SELECT  T1.SQL_ID ,T1.CHILD_NUMBER ,T1.SQL_TEXT 
FROM    V$SQL T1
WHERE   T1.SQL_TEXT LIKE '%GATHER_PLAN_STATISTICS%'
ORDER BY T1.LAST_ACTIVE_TIME DESC;

SELECT  *
FROM    TABLE(DBMS_XPLAN.DISPLAY_CURSOR('4hzn86zsr8t2k',0,'ALLSTATS LAST'));



-- ************************************************
-- PART II - 5.2.6 SQL1
-- ************************************************

-- 부분 범위 처리 확인 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */ 
        T1.*
FROM    T_ORD T1
WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD');




-- ************************************************
-- PART II - 5.2.6 SQL2
-- ************************************************

-- GROUP BY가 포함된 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */ 
        TO_CHAR(T1.ORD_DT,'YYYYMMDD') ORD_YMD
        ,T1.CUS_ID
        ,SUM(T1.ORD_AMT) ORD_AMT
FROM    T_ORD T1
WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMMDD')
        ,T1.CUS_ID;

		

		
		
		
		
		
		
		
		
		
		
		
		
		
		