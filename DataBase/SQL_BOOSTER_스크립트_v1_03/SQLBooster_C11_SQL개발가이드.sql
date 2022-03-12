

-- ************************************************
-- PART III - 11.1.1 SQL1
-- ************************************************

	-- 17년 3월달의 고객ID별 주문 건수 구하기
	-- WHERE 절의 컬럼을 변형
	SELECT  T1. CUS_ID ,COUNT(*) ORD_CNT
	FROM    T_ORD_BIG T1
	WHERE   SUBSTR(T1.ORD_YMD,1,6) = '201703'
	GROUP BY T1.CUS_ID;

	-- LIKE 조건을 사용.
	SELECT  T1. CUS_ID ,COUNT(*) ORD_CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD LIKE '201703%'
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART III - 11.1.1 SQL2
-- ************************************************

	-- WHERE 절의 원래 컬럼을 변형한 경우 – 사용 불가 패턴
	--컬럼을 결합해 조건 처리.
	SELECT  *
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_ST||T1.PAY_TP = 'COMP'||'BANK';

	--컬럼을 소문자로 변경해서 조건 처리.
	SELECT  *
	FROM    T_ORD_BIG T1
	WHERE   LOWER(T1.CUS_ID) = 'cus_0022';



-- ************************************************
-- PART III - 11.1.2 SQL1
-- ************************************************

	-- ORD_YMD가 20170313인 데이터 조회하기
	SELECT  T1.PAY_TP ,COUNT(*) CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = '20170313' 
	GROUP BY T1.PAY_TP;


-- ************************************************
-- PART III - 11.1.2 SQL2
-- ************************************************

	-- ORD_YMD가 20170313인 데이터 조회하기 – 날짜형 변수를 사용
	SELECT  T1.PAY_TP ,COUNT(*) CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = TO_DATE('20170313','YYYYMMDD')
	GROUP BY T1.PAY_TP;


-- ************************************************
-- PART III - 11.1.2 SQL3
-- ************************************************

	-- ORD_DT에 대한 인덱스 생성
	CREATE INDEX X_T_ORD_BIG_ORD_DT ON T_ORD_BIG(ORD_DT);



-- ************************************************
-- PART III - 11.1.2 SQL4
-- ************************************************

	-- ORD_DT가 20170313인 데이터 조회하기
	SELECT  T1.PAY_TP ,COUNT(*) CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_DT = '20170313'
	GROUP BY T1.PAY_TP;



-- ************************************************
-- PART III - 11.1.2 SQL5
-- ************************************************

	-- ORD_DT가 20170313인 데이터 조회하기 – ORD_DT 컬럼을 변형
	SELECT  T1.PAY_TP ,COUNT(*) CNT
	FROM    T_ORD_BIG T1
	WHERE   TO_CHAR(T1.ORD_DT,'YYYYMMDD') = '20170313'
	GROUP BY T1.PAY_TP;


-- ************************************************
-- PART III - 11.1.2 SQL6
-- ************************************************

	-- ORD_DT가 20170313인 데이터 조회하기
	SELECT  T1.PAY_TP ,COUNT(*) CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_DT = TO_DATE('20170313','YYYYMMDD')
	GROUP BY T1.PAY_TP;


-- ************************************************
-- PART III - 11.1.2 SQL7
-- ************************************************

	-- DATE자료형에 같다(=) 조건이 사용된 경우
	SELECT  *
	FROM    (
			SELECT 1 ORD_NO ,TO_DATE('20170313 00:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 2 ORD_NO ,TO_DATE('20170313 02:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 3 ORD_NO ,TO_DATE('20170313 23:59:59','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 4 ORD_NO ,TO_DATE('20170314 00:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL 
			) T1
	WHERE   T1.ORD_DT = TO_DATE('20170313','YYYYMMDD');



-- ************************************************
-- PART III - 11.1.2 SQL8
-- ************************************************

	-- DATE자료형에 범위 조건이 사용된 경우
	SELECT  *
	FROM    (
			SELECT 1 ORD_NO ,TO_DATE('20170313 00:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 2 ORD_NO ,TO_DATE('20170313 02:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 3 ORD_NO ,TO_DATE('20170313 23:59:59','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 4 ORD_NO ,TO_DATE('20170314 00:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL 
			) T1
	WHERE   T1.ORD_DT >= TO_DATE('20170313','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170313','YYYYMMDD') + 1;


-- ************************************************
-- PART III - 11.1.2 SQL9
-- ************************************************

	-- DATE자료형에 범위 조건이 사용된 경우 – BETWEEN 사용
	SELECT  *
	FROM    (
			SELECT 1 ORD_NO ,TO_DATE('20170313 00:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 2 ORD_NO ,TO_DATE('20170313 02:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 3 ORD_NO ,TO_DATE('20170313 23:59:59','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL UNION ALL
			SELECT 4 ORD_NO ,TO_DATE('20170314 00:00:00','YYYYMMDD HH24:MI:SS') ORD_DT FROM DUAL 
			) T1
	WHERE   T1.ORD_DT 
				BETWEEN TO_DATE('20170313','YYYYMMDD') AND TO_DATE('20170313 23:59:59','YYYYMMDD HH24:MI:SS');





-- ************************************************
-- PART III - 11.1.3 SQL1
-- ************************************************

	-- ORD_YMD 컬럼에 숫자형 변수를 사용
	SELECT  T1.PAY_TP ,COUNT(*) CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = 20170313
	GROUP BY T1.PAY_TP;




-- ************************************************
-- PART III - 11.1.3 SQL2
-- ************************************************

	-- M_TEST_CUST 테이블 생성
	CREATE TABLE M_TEST_CUS
	(
		CUS_ID VARCHAR2(40) NOT NULL,
		CUS_GD VARCHAR2(40) NULL,
		CUS_NM VARCHAR2(40) NULL
	);

	CREATE UNIQUE INDEX PK_M_TEST_CUS ON M_TEST_CUS(CUS_ID);

	INSERT INTO M_TEST_CUS
		(CUS_ID,CUS_GD,CUS_NM)
	SELECT  T1.CUS_ID
			,MOD(T1.CUS_ID,3) + 1 CUS_GD
			,'CUST_'||T1.CUS_ID CUS_NM
	FROM    (
			SELECT  ROWNUM CUS_ID
			FROM    DUAL A
			CONNECT BY ROWNUM <= 100000
			) T1;

	COMMIT;

-- ************************************************
-- PART III - 11.1.3 SQL3
-- ************************************************

	-- M_TEST_CUST 데이터 조회
	SELECT * FROM M_TEST_CUS T1 WHERE T1.CUS_ID = 2000;

	SELECT COUNT(*) FROM M_TEST_CUS T1 WHERE T1.CUS_GD = 1;




-- ************************************************
-- PART III - 11.1.4 SQL1
-- ************************************************

	-- 계좌이체(T_ACC_TRN) 테스트 데이터 생성
	TRUNCATE TABLE T_ACC_TRN;

	INSERT INTO T_ACC_TRN
			(ACC_TRN_SEQ ,FR_ACC_NO ,TO_ACC_NO ,TRN_AMT ,TRN_HND_ST ,TRN_REQ_DT ,TRN_CMP_DT)
	SELECT  ROW_NUMBER() OVER(ORDER BY T2.TRN_REQ_DT ASC, T1.RNO ASC, T1.TRN_HND_ST) ACC_TRN_SEQ
			,'ACC1' FR_ACC_NO ,'ACC3' TO_ACC_NO ,100 TRN_AMT ,T1.TRN_HND_ST
			,T2.TRN_REQ_DT ,T2.TRN_REQ_DT + 1 TRN_CMP_DT
	FROM    (
				SELECT ROWNUM RNO ,'REQ' TRN_HND_ST FROM DUAL CONNECT BY ROWNUM <= 5 UNION ALL
				SELECT ROWNUM RNO ,'WAIT' TRN_HND_ST FROM DUAL CONNECT BY ROWNUM <= 5 UNION ALL
				SELECT ROWNUM RNO ,'CNCL' TRN_HND_ST FROM DUAL CONNECT BY ROWNUM <= 10 UNION ALL
				SELECT ROWNUM RNO ,'COMP' TRN_HND_ST FROM DUAL CONNECT BY ROWNUM <= 1000
			) T1
			,(
				SELECT TO_DATE('20170101','YYYYMMDD') + (ROWNUM-1) TRN_REQ_DT 
				FROM DUAL CONNECT BY ROWNUM <= 100
			) T2
			;
		
	COMMIT;
		

-- ************************************************
-- PART III - 11.1.4 SQL2
-- ************************************************

	-- NOT IN 을 사용한 조회
	SELECT  *
	FROM    T_ACC_TRN T1
	WHERE   T1.TRN_HND_ST NOT IN ('CNCL','COMP')
	AND     T1.TRN_REQ_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.TRN_REQ_DT < TO_DATE('20170301','YYYYMMDD')+1;


-- ************************************************
-- PART III - 11.1.4 SQL3
-- ************************************************

	-- TRN_HND_ST, TRN_REQ_DT 순서의 복합 인덱스 생성
	CREATE INDEX X_T_ACC_TRN_1 ON T_ACC_TRN(TRN_HND_ST, TRN_REQ_DT);


-- ************************************************
-- PART III - 11.1.4 SQL4
-- ************************************************

	-- NOT IN 을 사용한 조회 – 힌트 사용
	SELECT  /*+ INDEX(T1 X_T_ACC_TRN_1) */
			*
	FROM    T_ACC_TRN T1
	WHERE   T1.TRN_HND_ST NOT IN ('CNCL','COMP')
	AND     T1.TRN_REQ_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.TRN_REQ_DT < TO_DATE('20170301','YYYYMMDD')+1;




-- ************************************************
-- PART III - 11.1.4 SQL5
-- ************************************************

	-- IN 을 사용한 조회
	SELECT  /*+ INDEX(T1 X_T_ACC_TRN_1) */
			*
	FROM    T_ACC_TRN T1
	WHERE   T1.TRN_HND_ST IN ('REQ','WAIT')
	AND     T1.TRN_REQ_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.TRN_REQ_DT < TO_DATE('20170301','YYYYMMDD')+1;





-- ************************************************
-- PART III - 11.1.4 SQL6
-- ************************************************

	-- COMP 외의 데이터 조회(같지 않다 조건 사용)
	SELECT  /*+ INDEX(T1 X_T_ACC_TRN_1) */
			*
	FROM    T_ACC_TRN T1
	WHERE   T1.TRN_HND_ST != 'COMP'
	AND     T1.TRN_REQ_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.TRN_REQ_DT < TO_DATE('20170301','YYYYMMDD')+1;



-- ************************************************
-- PART III - 11.1.4 SQL7
-- ************************************************

	-- COMP이외의 데이터 조회(같다 조건 사용)
	SELECT  /*+ INDEX(T1 X_T_ACC_TRN_1) */
			*
	FROM    T_ACC_TRN T1
	WHERE   T1.TRN_HND_ST IN ('REQ','WAIT','CNCL')
	AND     T1.TRN_REQ_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.TRN_REQ_DT < TO_DATE('20170301','YYYYMMDD')+1;





-- ************************************************
-- PART III - 11.1.4 SQL8
-- ************************************************

	-- NOT IN 조건을 이용해 REQ 데이터를 조회
	SELECT  /*+ GATHER_PLAN_STATISTICS INDEX(T1 X_T_ACC_TRN_1) */
			*
	FROM    T_ACC_TRN T1
	WHERE   T1.TRN_HND_ST NOT IN ('COMP','WAIT','CNCL')
	AND     T1.TRN_REQ_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.TRN_REQ_DT < TO_DATE('20170301','YYYYMMDD')+1;


-- ************************************************
-- PART III - 11.1.5 SQL1
-- ************************************************

	-- 주문 정보를 조회 – 고객ID에 LIKE 조건을 사용
	SELECT  *
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = v_ORD_YMD
	AND     T1.CUS_ID LIKE v_CUS_ID||'%'
	AND     T1.ORD_ST LIKE v_ORD_ST||'%';



-- ************************************************
-- PART III - 11.2.1 SQL1
-- ************************************************

	-- 오늘 주문 존재 확인 - COUNT사용
	SELECT  COUNT(*)
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = '20170225'
	AND     T1.CUS_ID = 'CUS_0006';


-- ************************************************
-- PART III - 11.2.1 SQL2
-- ************************************************

	-- 오늘 주문 존재 확인 – DUAL, EXISTS사용
	SELECT  NVL(MAX(1),0)
	FROM    DUAL A
	WHERE   EXISTS(
				SELECT  *
				FROM    T_ORD_BIG T1
				WHERE   T1.ORD_YMD = '20170225'
				AND     T1.CUS_ID = 'CUS_0006');
				
			
			
-- ************************************************
-- PART III - 11.2.1 SQL3
-- ************************************************

	-- 최초 주문 확인 - COUNT사용 – 기존 주문 없는 고객
	SELECT  COUNT(*)
	FROM    T_ORD_BIG T1
	WHERE   T1.CUS_ID = 'CUS_9999';



-- ************************************************
-- PART III - 11.2.1 SQL4
-- ************************************************

	-- 최초 주문 확인 - COUNT사용 – 기존 주문 있는 고객
	SELECT  COUNT(*)
	FROM    T_ORD_BIG T1
	WHERE   T1.CUS_ID = 'CUS_0006';




-- ************************************************
-- PART III - 11.2.1 SQL5
-- ************************************************

	-- 최초 주문 확인 – DUAL~EXISTS사용 – 기존 주문 있는 고객
	SELECT  NVL(MAX(1),0)
	FROM    DUAL A
	WHERE   EXISTS(
			  SELECT  *
			  FROM    T_ORD_BIG T1
			  WHERE   T1.CUS_ID = 'CUS_0006');


		  
		  
-- ************************************************
-- PART III - 11.2.1 SQL6
-- ************************************************

	-- 최초 주문 확인 –ROWNUM사용		  
	SELECT  NVL(MAX(1),0) EX_DATA
	FROM    T_ORD_BIG T1
	WHERE   T1.CUS_ID = 'CUS_0006'
	AND     ROWNUM <= 1;



		  
-- ************************************************
-- PART III - 11.2.2 SQL1
-- ************************************************

	-- 주문리스트 조회 SQL
	SELECT  T1.ORD_SEQ ,T1.RNO ,T1.ORD_YMD ,T1.CUS_ID ,T2.CUS_NM
			,T3.BAS_CD_NM ORD_ST_NM
	FROM    T_ORD_BIG T1
			,M_CUS T2
			,C_BAS_CD T3
	WHERE   T1.ORD_YMD = '20170107'
	AND     T2.CUS_ID = T1.CUS_ID
	AND     T3.LNG_CD = 'KO'
	AND     T3.BAS_CD_DV = 'ORD_ST'
	AND     T3.BAS_CD = T1.ORD_ST
	ORDER BY T1.ORD_SEQ ,T1.RNO;





-- ************************************************
-- PART III - 11.2.2 SQL2
-- ************************************************

	-- 주문리스트 조회 SQL – 카운트 처리
	SELECT  COUNT(*) 
	FROM    (
			SELECT  T1.ORD_SEQ ,T1.RNO ,T1.ORD_YMD ,T1.CUS_ID ,T2.CUS_NM
					,T3.BAS_CD_NM ORD_ST_NM
			FROM    T_ORD_BIG T1
					,M_CUS T2
					,C_BAS_CD T3
			WHERE   T1.ORD_YMD = '20170107'
			AND     T2.CUS_ID = T1.CUS_ID
			AND     T3.LNG_CD = 'KO'
			AND     T3.BAS_CD_DV = 'ORD_ST'
			AND     T3.BAS_CD = T1.ORD_ST
			ORDER BY T1.ORD_SEQ ,T1.RNO
	) T;



-- ************************************************
-- PART III - 11.2.2 SQL3
-- ************************************************

	-- 주문리스트 조회 SQL – 카운트 처리, 불필요한 조인 제거
	SELECT  COUNT(*)
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = '20170107';




-- ************************************************
-- PART III - 11.2.3 SQL1
-- ************************************************

	-- 특정 고객의 2017년3월 주문 조회
	SELECT  T2.CUS_NM ,T1.CUS_ID ,T1.ORD_ST ,T1.ORD_YMD
	FROM    T_ORD_BIG T1
			,M_CUS T2
	WHERE   T1.CUS_ID = 'CUS_0077'
	AND     T1.ORD_YMD LIKE '201703%'
	AND     T1.CUS_ID = T2.CUS_ID;


-- ************************************************
-- PART III - 11.2.3 SQL2
-- ************************************************

	-- 특정 고객의 2017년3월 주문 조회 – SELECT T1.*
	SELECT T2.CUS_NM, T1.*
	FROM    T_ORD_BIG T1
			,M_CUS T2
	WHERE   T1.CUS_ID = 'CUS_0077'
	AND     T1.ORD_YMD LIKE '201703%'
	AND     T1.CUS_ID = T2.CUS_ID;




-- ************************************************
-- PART III - 11.2.4 SQL1
-- ************************************************

	-- 주문 정보를 조회 – SELECT 절 서브쿼리를 사용
	SELECT  T1.ORD_SEQ ,T1.CUS_ID
			,T1.ORD_ST
			,(SELECT A.CUS_NM FROM M_CUS A WHERE A.CUS_ID = T1.CUS_ID) CUS_NM
			,(SELECT A.EML_AD FROM M_CUS A WHERE A.CUS_ID = T1.CUS_ID) EML_AD
	FROM    T_ORD T1;



-- ************************************************
-- PART III - 11.2.4 SQL2
-- ************************************************

	-- 고객 정보를 조회 – 2017년3월의 주문건수와 주문금액을 서브쿼리로 처리
	SELECT  T1.CUS_ID
			,T1.CUS_NM
			,(SELECT  COUNT(*)
			  FROM    T_ORD_BIG A 
			  WHERE   A.CUS_ID = T1.CUS_ID AND A.ORD_YMD LIKE '201703%') ORD_CNT
			,(SELECT  SUM(A.ORD_AMT)
			  FROM    T_ORD_BIG A 
			  WHERE   A.CUS_ID = T1.CUS_ID AND A.ORD_YMD LIKE '201703%') ORD_AMT
	FROM    M_CUS T1;




-- ************************************************
-- PART III - 11.2.4 SQL3
-- ************************************************

	-- 고객 정보를 조회 – 2017년3월의 주문건수와 주문금액을 조인으로 처리
	SELECT  T1.CUS_ID ,T1.CUS_NM ,T2.ORD_CNT ,T2.ORD_AMT
	FROM    M_CUS T1
			,(    SELECT  A.CUS_ID ,COUNT(*) ORD_CNT ,SUM(A.ORD_AMT) ORD_AMT
				  FROM    T_ORD_BIG A
				  WHERE   A.ORD_YMD LIKE '201703%'
				  GROUP BY A.CUS_ID) T2
	WHERE   T1.CUS_ID = T2.CUS_ID(+);



-- ************************************************
-- PART III - 11.3.1 SQL1
-- ************************************************

	-- 기준코드에서 코드명을 가져오는 사용자 함수
	CREATE OR REPLACE FUNCTION UFN_GET_CODE_NM
	(   v_BAS_CD_DV VARCHAR2 ,v_BAS_CD VARCHAR2 ,v_LNG_CD VARCHAR2
	) RETURN VARCHAR2 IS
		v_BAS_CD_NM VARCHAR2(100) := '';
	BEGIN

		SELECT  NVL(MAX(T1.BAS_CD_NM),'')
		INTO    v_BAS_CD_NM
		FROM    C_BAS_CD T1
		WHERE   T1.BAS_CD_DV = v_BAS_CD_DV
		AND     T1.BAS_CD = v_BAS_CD
		AND     T1.LNG_CD = v_LNG_CD;

		RETURN v_BAS_CD_NM;
	END UFN_GET_CODE_NM;




-- ************************************************
-- PART III - 11.3.1 SQL2
-- ************************************************

	-- 특정월의 주문을 고객ID, 주문상태명, 지불유형명 순서로 정렬해서 조회
	SELECT  T1.CUS_ID
			,T1.ORD_ST ,UFN_GET_CODE_NM('ORD_ST', T1.ORD_ST, 'KO') ORD_ST_NM
			,T1.PAY_TP ,UFN_GET_CODE_NM('PAY_TP', T1.PAY_TP, 'KO') PAY_TP_NM
			,T1.ORD_YMD ,T1.ORD_AMT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD = '20170305'
	ORDER BY T1.CUS_ID ,ORD_ST_NM ,PAY_TP_NM;



-- ************************************************
-- PART III - 11.3.1 SQL3
-- ************************************************

	-- 특정월의 주문을 고객ID, 주문상태명, 지불유형명 순서로 정렬해서 조회 – 조인으로 처리
	SELECT  T1.CUS_ID
			,T1.ORD_ST ,T_ORD_ST.BAS_CD_NM ORD_ST_NM
			,T1.PAY_TP ,T_PAY_TP.BAS_CD_NM PAY_TP_NM
			,T1.ORD_YMD ,T1.ORD_AMT
	FROM    T_ORD_BIG T1
			,C_BAS_CD T_ORD_ST
			,C_BAS_CD T_PAY_TP
	WHERE   T1.ORD_YMD = '20170305'
	AND     T_ORD_ST.BAS_CD(+) = T1.ORD_ST
	AND     T_ORD_ST.BAS_CD_DV(+) = 'ORD_ST'
	AND     T_ORD_ST.LNG_CD(+) = 'KO'
	AND     T_PAY_TP.BAS_CD(+) = T1.PAY_TP
	AND     T_PAY_TP.BAS_CD_DV(+) = 'PAY_TP'
	AND     T_PAY_TP.LNG_CD(+) = 'KO'
	ORDER BY T1.CUS_ID ,T_ORD_ST.BAS_CD_NM ,T_PAY_TP.BAS_CD_NM;



-- ************************************************
-- PART III - 11.3.1 SQL4
-- ************************************************

	-- 고객의 특정월의 주문금액을 가져오는 사용자 함수
	CREATE OR REPLACE FUNCTION UFN_GET_ORD_AMT
	(   v_CUS_ID VARCHAR2 ,v_ORD_YM VARCHAR2
	) RETURN VARCHAR2
	IS
		v_ORD_AMT NUMERIC(18,2) := NULL;
	BEGIN
		SELECT  SUM(T1.ORD_AMT)
		INTO    v_ORD_AMT
		FROM    T_ORD_BIG T1
		WHERE   T1.ORD_YMD LIKE v_ORD_YM||'%'
		AND     T1.CUS_ID = v_CUS_ID;

		RETURN v_ORD_AMT;
	END UFN_GET_ORD_AMT;



-- ************************************************
-- PART III - 11.3.1 SQL5
-- ************************************************

	-- 고객별 2017년3월 주문금액 조회 - 사용자 함수
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			T1.CUS_ID ,T1.CUS_NM
			,UFN_GET_ORD_AMT(T1.CUS_ID,'201703') ORD_AMT
	FROM    M_CUS T1
	ORDER BY NVL(ORD_AMT,0) DESC;



-- ************************************************
-- PART III - 11.3.1 SQL6
-- ************************************************

	-- 고객별 2017년3월 주문금액 조회 – 조인
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			T1.CUS_ID ,T1.CUS_NM ,T2.ORD_AMT
	FROM    M_CUS T1
			,(    SELECT  A.CUS_ID ,SUM(A.ORD_AMT) ORD_AMT
				  FROM    T_ORD_BIG A
				  WHERE   A.ORD_YMD LIKE '201703%'
				  GROUP BY A.CUS_ID
			) T2
	WHERE   T2.CUS_ID(+) = T1.CUS_ID
	ORDER BY NVL(T2.ORD_AMT,0) DESC;





-- ************************************************
-- PART III - 11.3.2 SQL1
-- ************************************************

	-- 고객별 월별 주문 금액
	SELECT  T1.CUS_ID
			,SUM(T1.UNT_PRC * T1.ORD_QTY) ORD_AMT
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201701%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_01
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201702%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_02
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201703%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_03
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201704%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_04
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201705%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_05
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201706%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_06
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201707%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_07
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201708%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_08
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201709%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_09
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201710%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_10
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201711%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_11
			,SUM(CASE WHEN T1.ORD_YMD LIKE '201712%' THEN T1.UNT_PRC * T1.ORD_QTY END) AMT_12
	FROM    T_ORD_JOIN T1
	GROUP BY T1.CUS_ID
	ORDER BY SUM(T1.UNT_PRC * T1.ORD_QTY) DESC;



-- ************************************************
-- PART III - 11.3.2 SQL2
-- ************************************************

	-- 고객별 월별 주문 금액 – 인라인-뷰를 활용해 CASE 횟수 개선
	SELECT  T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(CASE WHEN T1.ORD_YM = '201701' THEN T1.ORD_AMT END) AMT_01
			,SUM(CASE WHEN T1.ORD_YM = '201702' THEN T1.ORD_AMT END) AMT_02
			,SUM(CASE WHEN T1.ORD_YM = '201703' THEN T1.ORD_AMT END) AMT_03
			,SUM(CASE WHEN T1.ORD_YM = '201704' THEN T1.ORD_AMT END) AMT_04
			,SUM(CASE WHEN T1.ORD_YM = '201705' THEN T1.ORD_AMT END) AMT_05
			,SUM(CASE WHEN T1.ORD_YM = '201706' THEN T1.ORD_AMT END) AMT_06
			,SUM(CASE WHEN T1.ORD_YM = '201707' THEN T1.ORD_AMT END) AMT_07
			,SUM(CASE WHEN T1.ORD_YM = '201708' THEN T1.ORD_AMT END) AMT_08
			,SUM(CASE WHEN T1.ORD_YM = '201709' THEN T1.ORD_AMT END) AMT_09
			,SUM(CASE WHEN T1.ORD_YM = '201710' THEN T1.ORD_AMT END) AMT_10
			,SUM(CASE WHEN T1.ORD_YM = '201711' THEN T1.ORD_AMT END) AMT_11
			,SUM(CASE WHEN T1.ORD_YM = '201712' THEN T1.ORD_AMT END) AMT_12
	FROM    (
			SELECT  A.CUS_ID ,SUBSTR(A.ORD_YMD,1,6) ORD_YM ,SUM(A.UNT_PRC * A.ORD_QTY) ORD_AMT 
			FROM    T_ORD_JOIN A
			GROUP BY A.CUS_ID, SUBSTR(A.ORD_YMD,1,6)
			) T1
	GROUP BY T1.CUS_ID
	ORDER BY SUM(T1.ORD_AMT) DESC;




-- ************************************************
-- PART III - 11.3.2 SQL3
-- ************************************************

	-- 고객등급, 아이템유형별 주문금액
	SELECT  T1.CUS_GD ,T2.ITM_TP ,SUM(T3.ORD_QTY * T3.UNT_PRC) ORD_AMT
	FROM    M_CUS T1
			,M_ITM T2
			,T_ORD_JOIN T3
	WHERE   T3.CUS_ID = T1.CUS_ID
	AND     T3.ITM_ID = T2.ITM_ID
	GROUP BY T1.CUS_GD, T2.ITM_TP
	ORDER BY T1.CUS_GD, T2.ITM_TP;



-- ************************************************
-- PART III - 11.3.2 SQL4
-- ************************************************

	-- 고객등급, 아이템유형별 주문금액
	SELECT  T1.CUS_GD ,T2.ITM_TP ,SUM(T3.ORD_AMT) ORD_AMT
	FROM    M_CUS T1
			,M_ITM T2
			,(  SELECT  A.CUS_ID ,A.ITM_ID ,SUM(A.ORD_QTY * A.UNT_PRC) ORD_AMT
				FROM    T_ORD_JOIN A
				GROUP BY A.CUS_ID, A.ITM_ID
			) T3
	WHERE   T3.CUS_ID = T1.CUS_ID
	AND     T3.ITM_ID = T2.ITM_ID
	GROUP BY T1.CUS_GD, T2.ITM_TP
	ORDER BY T1.CUS_GD, T2.ITM_TP;




-- ************************************************
-- PART III - 11.3.3 SQL1
-- ************************************************

	-- 집계 테이블의 생성 및 데이터 집계 수행
	CREATE TABLE S_ORD_BIG_YMD
	(
		ORD_YMD VARCHAR2(8) NOT NULL,
		CUS_ID VARCHAR2(40) NOT NULL,
		ORD_ST VARCHAR2(40) NOT NULL,
		PAY_TP VARCHAR2(40) NOT NULL,
		ORD_AMT NUMBER(18,2) NULL,
		PAY_AMT NUMBER(18,2) NULL,
		ORD_CNT NUMBER(18,2) NULL
	);

	CREATE UNIQUE INDEX PK_S_ORD_BIG_YMD ON S_ORD_BIG_YMD(ORD_YMD, CUS_ID, ORD_ST, PAY_TP);

	ALTER TABLE S_ORD_BIG_YMD
		ADD CONSTRAINT PK_S_ORD_BIG_YMD PRIMARY KEY (ORD_YMD, CUS_ID, ORD_ST, PAY_TP);

	INSERT INTO S_ORD_BIG_YMD
			(ORD_YMD ,CUS_ID ,ORD_ST ,PAY_TP ,ORD_AMT ,PAY_AMT ,ORD_CNT)
	SELECT  T1.ORD_YMD ,T1.CUS_ID ,NVL(T1.ORD_ST,'NA') ,NVL(T1.PAY_TP,'NA') 
			,SUM(T1.ORD_AMT) ORD_AMT ,SUM(T1.PAY_AMT) PAY_AMT ,COUNT(*) ORD_CNT
	FROM    T_ORD_BIG T1
	WHERE   T1.ORD_YMD LIKE '201701%'
	GROUP BY T1.ORD_YMD ,T1.CUS_ID ,NVL(T1.ORD_ST,'NA') ,NVL(T1.PAY_TP,'NA');

	COMMIT;




-- ************************************************
-- PART III - 11.3.3 SQL2
-- ************************************************

	-- 고객ID별 전체 주문금액과 주문금액별 순위 – 집계 테이블 사용
	SELECT  T1.CUS_ID ,MAX(T2.CUS_NM) CUS_NM ,SUM(T1.ORD_AMT) ORD_AMT
			,RANK() OVER(ORDER BY SUM(T1.ORD_AMT) DESC) RNK
	FROM    S_ORD_BIG_YMD T1
			,M_CUS T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	GROUP BY T1.CUS_ID
	ORDER BY SUM(T1.ORD_AMT) DESC;
