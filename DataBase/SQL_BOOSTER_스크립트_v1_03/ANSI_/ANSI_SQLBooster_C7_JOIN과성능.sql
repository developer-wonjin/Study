
-- ************************************************
-- PART II - 7.1.2 SQL1
-- ************************************************

	-- NL ���� SQL
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_NL(T2) */
			T1.RGN_ID ,T1.CUS_ID ,T1.CUS_NM
			,T2.ORD_DT ,T2.ORD_ST ,T2.ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID;



-- ************************************************
-- PART II - 7.1.3 SQL1
-- ************************************************

	-- M_CUS�� T_ORD�� ���� ����
	SELECT /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) */
			T1.RGN_ID ,T1.CUS_ID ,T1.CUS_NM
			,T2.ORD_DT ,T2.ORD_ST ,T2.ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID;




-- ************************************************
-- PART II - 7.1.4 SQL1
-- ************************************************

	-- M_CUS�� T_ORD�� �ؽ� ����
	SELECT /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_HASH(T2) */
			T1.RGN_ID ,T1.CUS_ID ,T1.CUS_NM
			,T2.ORD_DT ,T2.ORD_ST ,T2.ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID;


-- ************************************************
-- PART II - 7.2.1 SQL1
-- ************************************************

	-- T_ORD_JOIN ���̺��� ����� SQL
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

	-- Ư�� ���� Ư�� ���� �ֹ�
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

	-- Ư�� ���� Ư������ �ֹ� ? T_ORD_JOIN(CUS_ID)�ε��� ���
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

	-- Ư�� ���� Ư������ �ֹ� ? T_ORD_JOIN(CUS_ID,ORD_YMD)�ε��� ���
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

	-- Ư�� ���� Ư������ �ֹ� ? T_ORD_JOIN�� ���� �������� ���
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

	-- Ư�� ���� Ư������ �ֹ� ? T_ORD_JOIN�� ���� �������� ��� ? SQL �ڵ� ����
	SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T2) USE_NL(T1) INDEX(T2 X_T_ORD_JOIN_2) */
			T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM ,MAX(T1.CUS_GD) CUS_GD ,COUNT(*) ORD_CNT
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
		   ,T_ORD_JOIN T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T1.CUS_ID = 'CUS_0009'
	AND     T2.CUS_ID = 'CUS_0009' -- �ڵ� �߰��� ����
	AND     T2.ORD_YMD = '20170218'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART II - 7.2.4 SQL1
-- ************************************************

	-- CUS_GD�� A, ORD_YMD�� 20170218�� �ֹ� ��ȸ ? T_ORD_JOIN�� ���� ����
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

	-- ��ȸ ���� ������ ������ �Ǽ�
	SELECT COUNT(*) FROM M_CUS T1 WHERE T1.CUS_GD = 'A'; -- 60��

	SELECT COUNT(*) FROM T_ORD_JOIN T2 WHERE T2.ORD_YMD = '20170218'; -- 12,000��


-- ************************************************
-- PART II - 7.2.4 SQL3
-- ************************************************

	-- CUS_GD�� A, ORD_YMD�� 20170218�� �ֹ� ��ȸ ? M_CUS�� ���� �������� ó��
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

	-- T_ORD_JOIN�� ��������(LIKE) ���
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

	-- ������ ���̺��� ī��Ʈ
	SELECT COUNT(*) FROM M_CUS; --90

	SELECT COUNT(*) FROM T_ORD_JOIN WHERE ORD_YMD LIKE '201702%'; --209000


-- ************************************************
-- PART II - 7.2.5 SQL3
-- ************************************************

	-- T_ORD_JOIN�� ��������(LIKE) ��� ? M_CUS�� ���� �������� ���
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

	-- 3�� ���̺��� ����
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

	-- 3�� ���̺��� ���� ? M_CUS�κи� ī��Ʈ
	SELECT COUNT(*) FROM M_CUS T3 WHERE T3.CUS_GD = 'B';

-- ************************************************
-- PART II - 7.2.6 SQL3
-- ************************************************

	-- 3�� ���̺��� ���� ? M_ITM�κи� ī��Ʈ
	SELECT COUNT(*) FROM M_ITM T1 WHERE T1.ITM_TP = 'ELEC';


-- ************************************************
-- PART II - 7.2.6 SQL4
-- ************************************************

	-- 3�� ���̺��� ���� ? �� ���� ��Ȳ���� ī��Ʈ
	-- 70,000���� ��ȸ�ȴ�.
	SELECT  COUNT(*) CNT
	FROM    M_CUS T3
	,T_ORD_JOIN T2
	WHERE   T3.CUS_ID = T2.CUS_ID
	AND     T3.CUS_GD = 'B'
	AND     T2.ORD_YMD LIKE '201702%';
			
	-- 26,000���� ��ȸ�ȴ�.
	SELECT  COUNT(*) CNT
	FROM    M_ITM T1
			,T_ORD_JOIN T2
	WHERE   T1.ITM_ID = T2.ITM_ID
	AND     T1.ITM_TP = 'ELEC'
	AND     T2.ORD_YMD LIKE '201702%';


-- ************************************************
-- PART II - 7.2.6 SQL5
-- ************************************************

	-- 3�� ���̺��� ���� ? M_ITM�� T_ORD_JOIN�� ���� ó��
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

	-- 3�� ���̺��� ���� ? �ʿ��� �ε����� ��� ����
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

	-- 3�� ���̺��� ���� ? TABLE ACCESS BY INDEX ROWID�� ����
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

	-- ���ʿ� �ε��� ����
	DROP INDEX X_M_ITM_1;
	DROP INDEX X_M_CUS_1;
	DROP INDEX X_T_ORD_JOIN_5;


-- ************************************************
-- PART II - 7.2.8 SQL1
-- ************************************************

	-- NL ���� ���� �׽�Ʈ ? M_CUS�� �������� NL ����
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

	-- NL ���� ���� �׽�Ʈ ? T_ORD_BIG�� �������� NL ����
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

	-- ���� 2�� ��ü �ֹ��ݾ� ��ȸ ? T_ORD_BIG,NL ���� ���
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

	-- ���� 2�� ��ü �ֹ��ݾ� ��ȸ ? T_ORD_BIG, ���� ���� ���
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

	-- ���� ���� ? T_ORD_BIG�� FULL SCAN���� ó��
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
-- ���� ���� ? T_ORD_BIG�� �ε��� �� �׽�Ʈ

	-- 1. X_T_ORD_BIG_1(ORD_YMD) �ε��� ���.
	-- SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) INDEX(T2 X_T_ORD_BIG_1) */
	-- 2. X_T_ORD_BIG_3(ORD_YMD, CUS_ID) �ε��� ���.
	-- SELECT  /*+ GATHER_PLAN_STATISTICS LEADING(T1) USE_MERGE(T2) INDEX(T2 X_T_ORD_BIG_3) */
	-- 3. X_T_ORD_BIG_4(CUS_ID, ORD_YMD, ORD_ST) �ε��� ���.
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

	-- T_ORD_BIG ��ü�� ���� ? ���� �������� ó��
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

	-- T_ORD_BIG ��ü�� ���� ? �ؽ� �������� ó��
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

	-- T_ORD_BIG ��ü�� ���� ? T_ORD_BIG�� ���� �������� ó��
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

	-- 3�� ���̺��� ����. ? M_ITM�� T_ORD_JOIN�� ���� ó��
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

	-- 3�� ���̺��� ���� ? NL �������θ� ó��
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
