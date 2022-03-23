

-- ************************************************
-- PART II - 6.1.1 SQL1
-- ************************************************

-- 테스트를 위한 테이블 만들기
CREATE TABLE T_ORD_BIG AS
SELECT  T1.* ,T2.RNO ,TO_CHAR(T1.ORD_DT,'YYYYMMDD') ORD_YMD
FROM    T_ORD T1
        ,(SELECT ROWNUM RNO
          FROM DUAL CONNECT BY ROWNUM <= 10000) T2
          ;

-- 아래는 T_ORD_BIG 테이블의 통계를 생성하는 명령어다.
-- 첫 번째 파라미터에는 테이블 OWNER를, 두 번째 파라미터에는 테이블 명을 입력한다.
EXEC DBMS_STATS.GATHER_TABLE_STATS('ORA_SQL_TEST','T_ORD_BIG');


-- ************************************************
-- PART II - 6.1.1 SQL2
-- ************************************************

-- 인덱스가 없는 BIG테이블 조회
SELECT  /*+ GATHER_PLAN_STATISTICS */ 
        COUNT(*) 
FROM    T_ORD_BIG T1 
WHERE   T1.ORD_SEQ = 343;


-- ************************************************
-- PART II - 6.1.1 SQL3
-- ************************************************

-- ORD_SEQ 컬럼에 인덱스 구성
CREATE INDEX X_T_ORD_BIG_TEST ON T_ORD_BIG(ORD_SEQ);


-- ************************************************
-- PART II - 6.1.5 SQL1
-- ************************************************

-- TABLE ACCESS FULL을 사용하는 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */
        T1.CUS_ID ,COUNT(*) ORD_CNT
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD = '20170316'
GROUP BY T1.CUS_ID
ORDER BY T1.CUS_ID;


-- ************************************************
-- PART II - 6.1.6 SQL1
-- ************************************************

-- INDEX RANGE SCAN을 사용하는 SQL
CREATE INDEX X_T_ORD_BIG_1 ON T_ORD_BIG(ORD_YMD);

SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_1) */
        T1.CUS_ID ,COUNT(*) ORD_CNT
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD = '20170316'
GROUP BY T1.CUS_ID
ORDER BY T1.CUS_ID;



-- ************************************************
-- PART II - 6.1.7 SQL1
-- ************************************************

-- INDEX RANGE SCAN을 사용하는 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */
        T1.CUS_ID ,COUNT(*) ORD_CNT
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD = '20170316'
GROUP BY T1.CUS_ID
ORDER BY T1.CUS_ID;



-- ************************************************
-- PART II - 6.1.7 SQL2
-- ************************************************

-- 3개월간의 주문을 조회 – ORD_YMD컬럼 인덱스를 사용
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_1) */
        T1.ORD_ST ,SUM(T1.ORD_AMT)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD BETWEEN '20170401' AND '20170630'
GROUP BY T1.ORD_ST;


-- ************************************************
-- PART II - 6.1.7 SQL3
-- ************************************************

-- 3개월간의 주문을 조회 – FULL(T1) 힌트 사용
SELECT  /*+ GATHER_PLAN_STATISTICS FULL(T1) */
        T1.ORD_ST ,SUM(T1.ORD_AMT)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD BETWEEN '20170401' AND '20170630'
GROUP BY T1.ORD_ST;






-- ************************************************
-- PART II - 6.2.1 SQL1
-- ************************************************


-- 인덱스가 필요한 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */
        TO_CHAR(T1.ORD_DT,'YYYYMM') ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.CUS_ID = 'CUS_0064'
AND     T1.PAY_TP = 'BANK'
AND     T1.RNO = 2
GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART II - 6.2.1 SQL2
-- ************************************************

-- 효율적인 단일 인덱스 찾기
SELECT  'CUS_ID' COL ,COUNT(*) CNT FROM T_ORD_BIG T1 WHERE T1.CUS_ID = 'CUS_0064'
UNION ALL
SELECT  'PAY_TP' COL ,COUNT(*) CNT FROM T_ORD_BIG T1 WHERE T1.PAY_TP = 'BANK'
UNION ALL
SELECT  'RNO' COL ,COUNT(*) CNT FROM T_ORD_BIG T1 WHERE T1.RNO = 2;


-- ************************************************
-- PART II - 6.2.1 SQL3
-- ************************************************

-- RNO 에 대한 단일 인덱스 생성
CREATE INDEX X_T_ORD_BIG_2 ON T_ORD_BIG(RNO);


-- ************************************************
-- PART II - 6.2.1 SQL4
-- ************************************************

-- RNO에 대한 단일 인덱스 생성 후 SQL수행
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_2) */
        TO_CHAR(T1.ORD_DT,'YYYYMM') ,COUNT(*)
FROM    T_ORD_BIG T1 
WHERE   T1.CUS_ID = 'CUS_0064'
AND     T1.PAY_TP = 'BANK'
AND     T1.RNO = 2
GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART II - 6.2.1 SQL5
-- ************************************************

-- CUS_ID 에 대한 단일 인덱스 생성
CREATE INDEX X_T_ORD_BIG_3 ON T_ORD_BIG(CUS_ID);




-- ************************************************
-- PART II - 6.2.1 SQL6
-- ************************************************

-- CUS_ID에 대한 단일 인덱스 생성 후 SQL수행
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_3) */
        TO_CHAR(T1.ORD_DT,'YYYYMM') ,COUNT(*)
FROM    T_ORD_BIG T1 
WHERE   T1.CUS_ID = 'CUS_0064'
AND     T1.PAY_TP = 'BANK'
AND     T1.RNO = 2
GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM');





-- ************************************************
-- PART II - 6.2.2 SQL1
-- ************************************************

-- CUS_ID 에 대한 단일 인덱스 제거
DROP INDEX X_T_ORD_BIG_3;



-- ************************************************
-- PART II - 6.2.2 SQL2
-- ************************************************

-- 2개의 조건이 사용된 SQL – ORD_YMD인덱스를 사용
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_1) */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201703%'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;


-- ************************************************
-- PART II - 6.2.2 SQL3
-- ************************************************

-- ORD_YMD, CUS_ID순으로 복합 인덱스를 생성
CREATE INDEX X_T_ORD_BIG_3 ON T_ORD_BIG(ORD_YMD, CUS_ID);




-- ************************************************
-- PART II - 6.2.2 SQL4
-- ************************************************

-- ORD_YMD, CUS_ID 복합 인덱스를 사용하도록 SQL을 수행
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_3) */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201703%'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;


-- ************************************************
-- PART II - 6.3.1 SQL1
-- ************************************************

-- 2개의 조건이 사용된 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_3) */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201703%'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;



-- ************************************************
-- PART II - 6.3.1 SQL2
-- ************************************************

-- CUS_ID, ORD_YMD로 구성된 인덱스
CREATE INDEX X_T_ORD_BIG_4 ON T_ORD_BIG(CUS_ID, ORD_YMD);



-- ************************************************
-- PART II - 6.3.1 SQL3
-- ************************************************

-- CUS_ID, ORD_YMD인덱스를 사용하는 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_4) */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201703%'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;


-- ************************************************
-- PART II - 6.3.2 SQL1
-- ************************************************

-- ORD_YMD가 같다(=)조건으로 CUS_ID가 LIKE조건으로 사용하는 SQL
SELECT  T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD = '20170301'
AND     T1.CUS_ID LIKE 'CUS_001%'
GROUP BY T1.ORD_ST;


-- ************************************************
-- PART II - 6.3.3 SQL1
-- ************************************************

-- 세 개의 조건이 사용된 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */
		T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201704%'
AND     T1.CUS_ID = 'CUS_0042'
AND     T1.PAY_TP = 'BANK'
GROUP BY T1.ORD_ST;



-- ************************************************
-- PART II - 6.3.3 SQL2
-- ************************************************

-- 특정 고객ID에 주문이 존재하는지 확인하는 SQL
SELECT  'X'
FROM    DUAL A
WHERE   EXISTS(
          SELECT  *
          FROM    T_ORD_BIG T1
          WHERE   T1.CUS_ID = 'CUS_0042'
          );



-- ************************************************
-- PART II - 6.3.4 SQL1
-- ************************************************

-- 많은 조건이 걸리는 SQL
SELECT  COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_AMT = 2400
AND     T1.PAY_TP = 'CARD'
AND     T1.ORD_YMD = '20170406'
AND     T1.ORD_ST = 'COMP'
AND     T1.CUS_ID = 'CUS_0036';



-- ************************************************
-- PART II - 6.3.4 SQL2
-- ************************************************

-- 각 조건별로 카운트 해보기
SELECT  'ORD_AMT' COL ,COUNT(*) FROM T_ORD_BIG T1 WHERE T1.ORD_AMT = 2400
UNION ALL
SELECT  'PAY_TP' COL ,COUNT(*) FROM T_ORD_BIG T1 WHERE T1.PAY_TP = 'CARD'
UNION ALL
SELECT  'ORD_YMD' COL ,COUNT(*) FROM T_ORD_BIG T1 WHERE T1.ORD_YMD = '20170406'
UNION ALL
SELECT  'ORD_ST' COL ,COUNT(*) FROM T_ORD_BIG T1 WHERE T1.ORD_ST = 'COMP'
UNION ALL
SELECT  'CUS_ID' COL ,COUNT(*)  FROM T_ORD_BIG T1 WHERE T1.CUS_ID = 'CUS_0036';


-- ************************************************
-- PART II - 6.4.1 SQL1
-- ************************************************

-- CUS_ID, ORD_YMD인덱스를 사용하는 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ORD_BIG_4) */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201703%'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;


-- ************************************************
-- PART II - 6.4.1 SQL2
-- ************************************************

-- X_T_ORD_BIG_4인덱스의 재생성
DROP INDEX X_T_ORD_BIG_4;
CREATE INDEX X_T_ORD_BIG_4 ON T_ORD_BIG(CUS_ID, ORD_YMD, ORD_ST);


-- ************************************************
-- PART II - 6.4.2 SQL1
-- ************************************************

-- CUS_0075의 201703주문을 조회하는 SQL
SELECT  /*+ GATHER_PLAN_STATISTICS */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   SUBSTR(T1.ORD_YMD,1,6) = '201703'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;

-- ************************************************
-- PART II - 6.4.2 SQL2
-- ************************************************

-- CUS_0075의 201703주문을 조회하는 SQL – LIKE로 처리
SELECT  /*+ GATHER_PLAN_STATISTICS */
        T1.ORD_ST ,COUNT(*)
FROM    T_ORD_BIG T1
WHERE   T1.ORD_YMD LIKE '201703%'
AND     T1.CUS_ID = 'CUS_0075'
GROUP BY T1.ORD_ST;

-- ************************************************
-- PART II - 6.4.3 SQL1
-- ************************************************

-- 테이블 및 인덱스 크기 확인
SELECT  T1.SEGMENT_NAME ,T1.SEGMENT_TYPE
        ,T1.BYTES / 1024 / 1024 as SIZE_MB
        ,T1.BYTES / T2.CNT BYTE_PER_ROW
FROM    DBA_SEGMENTS T1
        ,(SELECT COUNT(*) CNT FROM ORA_SQL_TEST.T_ORD_BIG) T2
WHERE   T1.SEGMENT_NAME LIKE '%ORD_BIG%'
ORDER BY T1.SEGMENT_NAME;














