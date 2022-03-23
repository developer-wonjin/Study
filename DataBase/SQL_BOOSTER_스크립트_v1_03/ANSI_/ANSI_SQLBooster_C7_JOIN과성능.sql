
-- ************************************************
-- PART II - 7.1.2 SQL1
-- ************************************************

	-- NL 조인 SQL
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) */
			T1.RGN_ID ,T1.CUS_ID ,T1.CUS_NM
			,T2.ORD_DT ,T2.ORD_ST ,T2.ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID;



-- ************************************************
-- PART II - 7.1.3 SQL1
-- ************************************************

	-- M_CUS과 T_ORD의 머지 조인
	SELECT /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) */
			T1.RGN_ID ,T1.CUS_ID ,T1.CUS_NM
			,T2.ORD_DT ,T2.ORD_ST ,T2.ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID;




-- ************************************************
-- PART II - 7.1.4 SQL1
-- ************************************************

	-- M_CUS과 T_ORD의 해시 조인
	SELECT /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_HASH(T2) */
			T1.RGN_ID ,T1.CUS_ID ,T1.CUS_NM
			,T2.ORD_DT ,T2.ORD_ST ,T2.ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID;


-- ************************************************
-- PART II - 7.2.1 SQL1
-- ************************************************

	-- T_ORD_JOIN 테이블을 만드는 SQL
	CREATE TABLE T_ORD_JOIN AS
	SELECT  ROW_NUMBER() OVER(ORDER BY T1.ORD_SEQ, T2.ORD_DET_NO, T3.RNO) ORD_SEQ
			,T1.CUS_ID ,T1.ORD_DT ,T1.ORD_ST ,T1.PAY_TP
			,T2.ITM_ID ,T2.ORD_QTY ,T2.UNT_PRC ,TO_CHAR(T1.ORD_DT,'YYYYMMDD') ORD_YMD
	FROM    T_ORD T1
			,T_ORD_DET T2
			,(SELECT ROWNUM RNO
			  FROM DUAL CONNECT BY ROWNUM <= 1000
			  ) T3
	WHERE   T1.ORD_SEQ = T2.ORD_SEQ;
			  
	ALTER TABLE T_ORD_JOIN ADD CONSTRAINT PK_T_ORD_JOIN PRIMARY KEY(ORD_SEQ) USING INDEX;

	EXEC DBMS_STATS.GATHER_TABLE_STATS('ORA_SQL_TEST','T_ORD_JOIN');


-- ************************************************
-- PART II - 7.2.2 SQL1
-- ************************************************

	-- 특정 고객의 특정 일자 주문
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			T1.CUS_ID  ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T1.CUS_ID = 'CUS_0009'
	AND     T2.ORD_YMD = '20170218'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.2.2 SQL2
-- ************************************************

	-- 특정 고객의 특정일자 주문 ? T_ORD_JOIN(CUS_ID)인덱스 사용
	CREATE INDEX X_T_ORD_JOIN_1 ON T_ORD_JOIN(CUS_ID);

	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) INDEX(T2 X_T_ORD_JOIN_1) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T1.CUS_ID = 'CUS_0009'
	AND     T2.ORD_YMD = '20170218'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.2.2 SQL3
-- ************************************************

	-- 특정 고객의 특정일자 주문 ? T_ORD_JOIN(CUS_ID,ORD_YMD)인덱스 사용
	CREATE INDEX X_T_ORD_JOIN_2 ON T_ORD_JOIN(CUS_ID, ORD_YMD);
			
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
		   ,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T1.CUS_ID = 'CUS_0009'
	AND     T2.ORD_YMD = '20170218'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.2.3 SQL1
-- ************************************************

	-- 특정 고객의 특정일자 주문 ? T_ORD_JOIN을 선행 집합으로 사용
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
		   ,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T1.CUS_ID = 'CUS_0009'
	AND     T2.ORD_YMD = '20170218'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.2.3 SQL2
-- ************************************************

	-- 특정 고객의 특정일자 주문 ? T_ORD_JOIN을 선행 집합으로 사용 ? SQL 자동 변형
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
		   ,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T1.CUS_ID = 'CUS_0009'
	AND     T2.CUS_ID = 'CUS_0009' -- 자동 추가된 조건
	AND     T2.ORD_YMD = '20170218'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.2.4 SQL1
-- ************************************************

	-- CUS_GD가 A, ORD_YMD가 20170218인 주문 조회 ? T_ORD_JOIN이 선행 집합
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD = '20170218'
	AND     T1.CUS_GD = 'A'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.2.4 SQL2
-- ************************************************

	-- 조회 조건 각가의 데이터 건수
	SELECT COUNT(*) FROM M_CUS T1 WHERE T1.CUS_GD = 'A'; -- 60건

	SELECT COUNT(*) FROM T_ORD_JOIN T2 WHERE T2.ORD_YMD = '20170218'; -- 12,000건


-- ************************************************
-- PART II - 7.2.4 SQL3
-- ************************************************

	-- CUS_GD가 A, ORD_YMD가 20170218인 주문 조회 ? M_CUS을 선행 집합으로 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD = '20170218'
	AND     T1.CUS_GD = 'A'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.2.5 SQL1
-- ************************************************

	-- T_ORD_JOIN에 범위조건(LIKE) 사용
	CREATE INDEX X_T_ORD_JOIN_3 ON T_ORD_JOIN(ORD_YMD);

	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) INDEX(T2 X_T_ORD_JOIN_3) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.2.5 SQL2
-- ************************************************

	-- 각각의 테이블을 카운트
	SELECT COUNT(*) FROM M_CUS; --90

	SELECT COUNT(*) FROM T_ORD_JOIN WHERE ORD_YMD LIKE '201702%'; --209000


-- ************************************************
-- PART II - 7.2.5 SQL3
-- ************************************************

	-- T_ORD_JOIN에 범위조건(LIKE) 사용 ? M_CUS을 선행 집합으로 사용
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.2.6 SQL1
-- ************************************************

	-- 3개 테이블의 조인
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST ,COUNT(*) ORD_QTY
	FROM    M_ITM T1
			,T_ORD_JOIN T2
			,M_CUS T3
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T3.CUS_ID = T2.CUS_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST;



-- ************************************************
-- PART II - 7.2.6 SQL2
-- ************************************************

	-- 3개 테이블의 조인 ? M_CUS부분만 카운트
	SELECT COUNT(*) FROM M_CUS T3 WHERE T3.CUS_GD = 'B';

-- ************************************************
-- PART II - 7.2.6 SQL3
-- ************************************************

	-- 3개 테이블의 조인 ? M_ITM부분만 카운트
	SELECT COUNT(*) FROM M_ITM T1 WHERE T1.ITM_TP = 'ELEC';


-- ************************************************
-- PART II - 7.2.6 SQL4
-- ************************************************

	-- 3개 테이블의 조인 ? 각 조인 상황별로 카운트
	-- 70,000건이 조회된다.
	SELECT  COUNT(*) CNT
	FROM    M_CUS T3
	,T_ORD_JOIN T2
	WHERE   T3.CUS_ID = T2.CUS_ID
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%';
			
	-- 26,000건이 조회된다.
	SELECT  COUNT(*) CNT
	FROM    M_ITM T1
			,T_ORD_JOIN T2
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T2.ORD_YMD LIKE '201702%';


-- ************************************************
-- PART II - 7.2.6 SQL5
-- ************************************************

	-- 3개 테이블의 조인 ? M_ITM과 T_ORD_JOIN을 먼저 처리
	CREATE INDEX X_T_ORD_JOIN_4 ON T_ORD_JOIN(ITM_ID,ORD_YMD);

	SELECT  /*+ GATHER_PLAN_STATISTICS USE_NL(T2) INDEX(T2 X_T_ORD_JOIN_4) */
			T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST ,COUNT(*) ORD_QTY
	FROM    M_ITM T1
			,T_ORD_JOIN T2
			,M_CUS T3
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T3.CUS_ID = T2.CUS_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST;


-- ************************************************
-- PART II - 7.2.7 SQL1
-- ************************************************

	-- 3개 테이블의 조인 ? 필요한 인덱스를 모두 생성
	CREATE INDEX X_M_ITM_1 ON M_ITM(ITM_TP,ITM_ID,ITM_NM);
	CREATE INDEX X_M_CUS_1 ON M_CUS(CUS_GD, CUS_ID);

	SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_M_ITM_1) INDEX(T3 X_M_CUS_1) INDEX(T2 X_T_ORD_JOIN_4) */
			T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST ,COUNT(*) ORD_QTY
	FROM    M_ITM T1
			,T_ORD_JOIN T2
			,M_CUS T3
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T3.CUS_ID = T2.CUS_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST;

	CREATE INDEX X_T_ORD_JOIN_5 ON T_ORD_JOIN(ITM_ID, ORD_YMD, CUS_ID, ORD_ST);


-- ************************************************
-- PART II - 7.2.7 SQL2
-- ************************************************

	-- 3개 테이블의 조인 ? TABLE ACCESS BY INDEX ROWID를 제거
	SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_M_ITM_1) INDEX(T3 X_M_CUS_1) INDEX(T2 X_T_ORD_JOIN_5) */
			T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST ,COUNT(*) ORD_QTY
	FROM    M_ITM T1
			,T_ORD_JOIN T2
			,M_CUS T3
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T3.CUS_ID = T2.CUS_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST;



-- ************************************************
-- PART II - 7.2.7 SQL3
-- ************************************************

	-- 불필요 인덱스 제거
	DROP INDEX X_M_ITM_1;
	DROP INDEX X_M_CUS_1;
	DROP INDEX X_T_ORD_JOIN_5;


-- ************************************************
-- PART II - 7.2.8 SQL1
-- ************************************************

	-- NL 조인 성능 테스트 ? M_CUS를 선행으로 NL 조인
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) INDEX(T2 X_T_ORD_BIG_4) */
			T1.CUS_ID, T1.CUS_NM, SUM(T2.ORD_AMT)
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD LIKE '201701%'
	GROUP BY T1.CUS_ID, T1.CUS_NM
	ORDER BY SUM(T2.ORD_AMT) DESC;


-- ************************************************
-- PART II - 7.2.8 SQL2
-- ************************************************

	-- NL 조인 성능 테스트 ? T_ORD_BIG을 선행으로 NL 조인
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) FULL(T2) */
			T1.CUS_ID, T1.CUS_NM, SUM(T2.ORD_AMT)
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD LIKE '201701%'
	GROUP BY T1.CUS_ID, T1.CUS_NM
	ORDER BY SUM(T2.ORD_AMT) DESC;


-- ************************************************
-- PART II - 7.3.1 SQL1
-- ************************************************

	-- 고객별 2월 전체 주문금액 조회 ? T_ORD_BIG,NL 조인 사용
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) FULL(T2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_AMT) ORD_AMT
			,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.3.1 SQL2
-- ************************************************

	-- 고객별 2월 전체 주문금액 조회 ? T_ORD_BIG, 머지 조인 사용
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) FULL(T2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_AMT) ORD_AMT
			,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.3.2 SQL1
-- ************************************************

	-- 머지 조인 ? T_ORD_BIG을 FULL SCAN으로 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) FULL(T2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_AMT) ORD_AMT ,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD BETWEEN '20170201' AND '20170210'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.3.2 SQL2
-- ************************************************
-- 머지 조인 ? T_ORD_BIG의 인덱스 별 테스트

	-- 1. X_T_ORD_BIG_1(ORD_YMD) 인덱스 사용.
	-- SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) INDEX(T2 X_T_ORD_BIG_1) */
	-- 2. X_T_ORD_BIG_3(ORD_YMD, CUS_ID) 인덱스 사용.
	-- SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) INDEX(T2 X_T_ORD_BIG_3) */
	-- 3. X_T_ORD_BIG_4(CUS_ID, ORD_YMD, ORD_ST) 인덱스 사용.
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) INDEX(T2 X_T_ORD_BIG_4) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_AMT) ORD_AMT ,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_YMD BETWEEN '20170201' AND '20170210'
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.4.1 SQL1
-- ************************************************

	-- T_ORD_BIG 전체를 조인 ? 머지 조인으로 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD
			,COUNT(*) ORD_CNT ,SUM(T2.ORD_AMT) ORD_AMT ,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART II - 7.4.1 SQL2
-- ************************************************

	-- T_ORD_BIG 전체를 조인 ? 해시 조인으로 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_HASH(T2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD
			,COUNT(*) ORD_CNT ,SUM(T2.ORD_AMT) ORD_AMT ,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.4.2 SQL1
-- ************************************************

	-- T_ORD_BIG 전체를 조인 ? T_ORD_BIG을 선행 집합으로 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_HASH(T1) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD
			,COUNT(*) ORD_CNT ,SUM(T2.ORD_AMT) ORD_AMT ,SUM(SUM(T2.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    M_CUS T1
			,T_ORD_BIG T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	GROUP BY T1.CUS_ID;

-- ************************************************
-- PART II - 7.4.3 SQL1
-- ************************************************

	-- 3개 테이블의 조인. ? M_ITM과 T_ORD_JOIN을 먼저 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST ,COUNT(*) ORD_QTY
	FROM    M_ITM T1
			,T_ORD_JOIN T2
			,M_CUS T3
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T3.CUS_ID = T2.CUS_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST;


-- ************************************************
-- PART II - 7.4.3 SQL2
-- ************************************************

	-- 3개 테이블의 조인 ? NL 조인으로만 처리
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1 T2 T3) USE_NL(T2 T3) */
			T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST ,COUNT(*) ORD_QTY
	FROM    M_ITM T1
			,T_ORD_JOIN T2
			,M_CUS T3
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T3.CUS_ID = T2.CUS_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%'
	GROUP BY T1.ITM_ID ,T1.ITM_NM ,T2.ORD_ST;
