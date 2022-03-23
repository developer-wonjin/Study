

-- ************************************************
-- PART I - 2.1.1 SQL1
-- ************************************************

	-- 주문일시, 지불유형별 주문금액
	SELECT  T1.ORD_DT ,T1.PAY_TP 
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY T1.ORD_DT ,T1.PAY_TP
	ORDER BY T1.ORD_DT ,T1.PAY_TP;


-- ************************************************
-- PART I - 2.1.1 SQL2
-- ************************************************

	-- 집계함수 - 정상적인 SQL, 에러가 발생하는 SQL
	SELECT  COUNT(*) CNT
			,SUM(T1.ORD_AMT) TTL_ORD_AMT
			,MIN(T1.ORD_SEQ) MIN_ORD_SEQ
			,MAX(T1.ORD_SEQ) MAX_ORD_SEQ
	FROM    T_ORD T1
	WHERE T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND T1.ORD_DT < TO_DATE('20170201','YYYYMMDD');


	SELECT  T1.ORD_ST
			,COUNT(*) CNT
			,SUM(T1.ORD_AMT) TTL_ORD_AMT
			,MIN(T1.ORD_SEQ) MIN_ORD_SEQ
			,MAX(T1.ORD_SEQ) MAX_ORD_SEQ
	FROM    T_ORD T1
	WHERE T1.ORD_DT>= TO_DATE('20170101','YYYYMMDD')
	AND T1.ORD_DT < TO_DATE('20170201','YYYYMMDD');



-- ************************************************
-- PART I - 2.1.2 SQL1
-- ************************************************

	-- CASE를 이용해 가격유형(ORD_AMT_TP)별로 주문 건수를 카운트
	SELECT  T1.ORD_ST
			,CASE WHEN T1.ORD_AMT >= 5000 THEN 'High Order'
				  WHEN T1.ORD_AMT >= 3000 THEN 'Middle Order'
				  ELSE 'Low Order'
			 END ORD_AMT_TP
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY T1.ORD_ST
			,CASE WHEN T1.ORD_AMT >= 5000 THEN 'High Order'
				  WHEN T1.ORD_AMT >= 3000 THEN 'Middle Order'
				  ELSE 'Low Order'
			 END
	ORDER BY 1 ,2;


-- ************************************************
-- PART I - 2.1.2 SQL2
-- ************************************************

	-- TO_CHAR 변형을 이용한 주문년월, 지불유형별 주문건수
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.PAY_TP
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.PAY_TP
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.PAY_TP;




-- ************************************************
-- PART I - 2.1.3 SQL1
-- ************************************************

	-- 주문년월별 계좌이체(PAY_TP=BANK) 건수와 카드결제(PAY_TP=CARD) 건수
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(CASE WHEN T1.PAY_TP = 'BANK' THEN 1 END) BANK_PAY_CNT
			,SUM(CASE WHEN T1.PAY_TP = 'CARD' THEN 1 END) CARD_PAY_CNT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART I - 2.1.3 SQL2
-- ************************************************

	-- 지불유형(PAY_TP)별 주문건수(주문 건수를 주문년월별로 컬럼으로 표시)
	SELECT  T1.PAY_TP
			,COUNT(CASE WHEN TO_CHAR(T1.ORD_DT,'YYYYMM') = '201701' THEN 'X' END) ORD_CNT_1701
			,COUNT(CASE WHEN TO_CHAR(T1.ORD_DT,'YYYYMM') = '201702' THEN 'X' END) ORD_CNT_1702
			--...201703~201711반복.
			,COUNT(CASE WHEN TO_CHAR(T1.ORD_DT,'YYYYMM') = '201712' THEN 'X' END) ORD_CNT_1712
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY T1.PAY_TP
	ORDER BY T1.PAY_TP;


-- ************************************************
-- PART I - 2.1.3 SQL3
-- ************************************************

	-- 지불유형(PAY_TP)별 주문건수(주문 건수를 주문년월별로 컬럼으로 표시) ? 인라인-뷰 활용
	SELECT  T1.PAY_TP
			,MAX(CASE WHEN T1.ORD_YM = '201701' THEN T1.ORD_CNT END) ORD_CNT_1701
			,MAX(CASE WHEN T1.ORD_YM = '201702' THEN T1.ORD_CNT END) ORD_CNT_1702
			--...201703~201711반복.
			,MAX(CASE WHEN T1.ORD_YM = '201712' THEN T1.ORD_CNT END) ORD_CNT_1712
	FROM    (
			SELECT  T1.PAY_TP ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
					,COUNT(*) ORD_CNT
			FROM    T_ORD T1
			WHERE   T1.ORD_ST = 'COMP'
			GROUP BY T1.PAY_TP ,TO_CHAR(T1.ORD_DT,'YYYYMM')        
			) T1
	GROUP BY T1.PAY_TP;


-- ************************************************
-- PART I - 2.1.4 SQL1
-- ************************************************

	-- NULL에 대한 COUNT #1
	SELECT  COUNT(COL1) CNT_COL1
			,COUNT(COL2) CNT_COL2
			,COUNT(COL3) CNT_COL3
	FROM    (
			SELECT  'A' COL1 ,NULL COL2 ,'C' COL3 FROM DUAL UNION ALL
			SELECT  'B' COL1 ,NULL COL2 ,NULL COL3 FROM DUAL 
			) T1;

		
-- ************************************************
-- PART I - 2.1.4 SQL2
-- ************************************************

	-- NULL에 대한 COUNT #2
	SELECT  COUNT(COL1) CNT_COL1 ,COUNT(*) CNT_ALL
	FROM    (
			SELECT  NULL COL1 FROM  DUAL UNION ALL
			SELECT  NULL COL1 FROM  DUAL
			) T1;


-- ************************************************
-- PART I - 2.1.5 SQL1
-- ************************************************

	-- 주문년월별 주문고객 수(중복을 제거해서 카운트), 주문건수
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,COUNT(DISTINCT T1.CUS_ID) CUS_CNT
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170401','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART I - 2.1.5 SQL2
-- ************************************************

	-- 주문상태(ORD_ST)와 지불유형(PAY_TP)의 조합에 대한 종류 수
	--ERROR
	SELECT  COUNT(DISTINCT T1.ORD_ST ,T1.PAY_TP)
	FROM    T_ORD T1;

	--ORA-00909: invalid number of arguments

	--USE CONCAT
	SELECT  COUNT(DISTINCT T1.ORD_ST||'-'||T1.PAY_TP)
	FROM    T_ORD T1;


-- ************************************************
-- PART I - 2.1.5 SQL3
-- ************************************************

	-- 주문상태(ORD_ST)와 지불유형(PAY_TP)의 조합에 대한 종류 수 ? 인라인-뷰로 해결
	SELECT  COUNT(*)
	FROM    (
			SELECT  DISTINCT T1.ORD_ST ,T1.PAY_TP
			FROM    T_ORD T1
			) T2;



-- ************************************************
-- PART I - 2.1.6 SQL1
-- ************************************************

	-- 고객ID, 지불유형(PAY_TP)별 주문금액이 10,000 이상인 데이터만 조회
	SELECT  T1.CUS_ID ,T1.PAY_TP ,SUM(T1.ORD_AMT) ORD_TTL_MT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY T1.CUS_ID ,T1.PAY_TP
	HAVING SUM(T1.ORD_AMT) >= 10000
	ORDER BY SUM(T1.ORD_AMT) ASC;



-- ************************************************
-- PART I - 2.1.6 SQL2
-- ************************************************

	-- HAVING 절에는 GROUP BY에 사용한 컬럼 또는 집계함수를 사용한 컬럼만 사용 가능하다.
	SELECT  T1.CUS_ID ,T1.PAY_TP ,SUM(T1.ORD_AMT) ORD_TTL_MT
	FROM    T_ORD T1
	GROUP BY T1.CUS_ID ,T1.PAY_TP
	HAVING T1.ORD_ST = 'COMP' --ERROR
	ORDER BY SUM(T1.ORD_AMT) ASC;

	-- 에러 발생: ORA-00979: not a GROUP BY expression


-- ************************************************
-- PART I - 2.1.6 SQL3
-- ************************************************

	-- HAVING절 대신 인라인-뷰를 사용
	SELECT  T0.*
	FROM    (
			SELECT  T1.CUS_ID ,T1.PAY_TP ,SUM(T1.ORD_AMT) ORD_TTL_AMT
			FROM    T_ORD T1
			WHERE   T1.ORD_ST = 'COMP'
			GROUP BY T1.CUS_ID ,T1.PAY_TP
			) T0
	WHERE   T0.ORD_TTL_AMT >= 10000
	ORDER BY T0.ORD_TTL_AMT ASC;



-- ************************************************
-- PART I - 2.2.1 SQL1
-- ************************************************

	-- GROUP BY와 GROUP BY~ROLLUP의 비교
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM 
			,T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID;

	SELECT TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM 
			,T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY 
	ROLLUP(TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID);



-- ************************************************
-- PART I - 2.2.2 SQL1
-- ************************************************

	-- 주문상태, 주문년월, 고객ID 순서로 ROLLUP
	SELECT  T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY ROLLUP(T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID)
	ORDER BY T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID;




-- ************************************************
-- PART I - 2.2.2 SQL2
-- ************************************************

	-- 주문년월, 주문상태, 고객ID 순서로 ROLLUP(위 SQL에서 ROLLUP부분만 변경해서 수행한다.)
	SELECT  T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY ROLLUP(TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.ORD_ST ,T1.CUS_ID)
	ORDER BY T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID;


-- ************************************************
-- PART I - 2.2.3 SQL1
-- ************************************************

	-- NULL이 존재하는 컬럼인 PAY_TP에 대해 ROLLUP을 수행
	SELECT  T1.ORD_ST ,T1.PAY_TP ,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY ROLLUP(T1.ORD_ST ,T1.PAY_TP);


-- ************************************************
-- PART I - 2.2.3 SQL2
-- ************************************************

	-- NULL이 존재하는 컬럼인 PAY_TP에 대해 ROLLUP을 수행. GROUPING함수 사용
	SELECT  T1.ORD_ST ,GROUPING(T1.ORD_ST) GR_ORD_ST 
			,T1.PAY_TP ,GROUPING(T1.PAY_TP) GR_PAY_TP
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY ROLLUP(T1.ORD_ST, T1.PAY_TP);



-- ************************************************
-- PART I - 2.2.3 SQL3
-- ************************************************

	-- ROLLUP되는 컬럼을 Total로 표시
	SELECT  CASE WHEN GROUPING(T1.ORD_ST) = 1 THEN 'Total' ELSE T1.ORD_ST END ORD_ST
			,CASE WHEN GROUPING(T1.PAY_TP) = 1 THEN 'Total' ELSE T1.PAY_TP END PAY_TP 
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY ROLLUP(T1.ORD_ST ,T1.PAY_TP)
	ORDER BY T1.ORD_ST ,T1.PAY_TP;




-- ************************************************
-- PART I - 2.2.4 SQL1
-- ************************************************

	-- 주문년월, 지역ID, 고객등급별 주문금액 - ROLLUP
	SELECT  CASE  WHEN GROUPING(TO_CHAR(T2.ORD_DT,'YYYYMM'))=1 THEN 'Total' 
				  ELSE TO_CHAR(T2.ORD_DT,'YYYYMM') END ORD_YM 
			,CASE WHEN GROUPING(T1.RGN_ID) = 1 THEN 'Total' ELSE T1.RGN_ID END RGN_ID
			,CASE WHEN GROUPING(T1.CUS_GD) = 1 THEN 'Total' ELSE T1.CUS_GD END CUS_GD
			,SUM(T2.ORD_AMT) ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_DT >= TO_DATE('20170201','YYYYMMDD')
	AND     T2.ORD_DT < TO_DATE('20170401','YYYYMMDD')
	AND     T1.RGN_ID IN ('A','B')
	GROUP BY ROLLUP(TO_CHAR(T2.ORD_DT,'YYYYMM') ,T1.RGN_ID ,T1.CUS_GD)
	ORDER BY TO_CHAR(T2.ORD_DT,'YYYYMM') ,T1.RGN_ID ,T1.CUS_GD;



-- ************************************************
-- PART I - 2.2.4 SQL2
-- ************************************************

	-- 주문년월, 지역ID, 고객등급별 주문금액 ? 전체 합계만 구하기
	SELECT  CASE  WHEN GROUPING(TO_CHAR(T2.ORD_DT,'YYYYMM'))=1 THEN 'Total' 
				  ELSE TO_CHAR(T2.ORD_DT,'YYYYMM') END ORD_YM 
			,CASE WHEN GROUPING(T1.RGN_ID) = 1 THEN 'Total' ELSE T1.RGN_ID END RGN_ID
			,CASE WHEN GROUPING(T1.CUS_GD) = 1 THEN 'Total' ELSE T1.CUS_GD END CUS_GD
			,SUM(T2.ORD_AMT) ORD_AMT
	FROM    M_CUS T1
			,T_ORD T2
	WHERE   T1.CUS_ID = T2.CUS_ID
	AND     T2.ORD_DT >= TO_DATE('20170201','YYYYMMDD')
	AND     T2.ORD_DT < TO_DATE('20170401','YYYYMMDD')
	AND     T1.RGN_ID IN ('A','B')
	GROUP BY ROLLUP((TO_CHAR(T2.ORD_DT,'YYYYMM') ,T1.RGN_ID ,T1.CUS_GD))
	ORDER BY TO_CHAR(T2.ORD_DT,'YYYYMM') ,T1.RGN_ID ,T1.CUS_GD;


-- ************************************************
-- PART I - 2.3.1 SQL1
-- ************************************************

	-- 주문년월, 고객ID별 주문금액 ? ROLLUP 사용
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY ROLLUP(TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID);



-- ************************************************
-- PART I - 2.3.1 SQL2
-- ************************************************

	-- ROLLUP을 UNION ALL로 대신하기
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID
	UNION ALL
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,'Total' CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	UNION ALL
	SELECT  'Total' ORD_YM ,'Total' CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD');



-- ************************************************
-- PART I - 2.3.1 SQL3
-- ************************************************

	-- ROLLUP을 카테시안 조인으로 대신하기
	SELECT  CASE WHEN T2.RNO = 1 THEN TO_CHAR(T1.ORD_DT,'YYYYMM')
				  WHEN T2.RNO = 2 THEN TO_CHAR(T1.ORD_DT,'YYYYMM')
				  WHEN T2.RNO = 3 THEN 'Total' END ORD_YM
			,CASE WHEN T2.RNO = 1 THEN T1.CUS_ID
				  WHEN T2.RNO = 2 THEN 'Total'
				  WHEN T2.RNO = 3 THEN 'Total' END CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
			,(
				SELECT ROWNUM RNO FROM DUAL CONNECT BY ROWNUM <= 3
			) T2
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY CASE WHEN T2.RNO = 1 THEN TO_CHAR(T1.ORD_DT,'YYYYMM')
				  WHEN T2.RNO = 2 THEN TO_CHAR(T1.ORD_DT,'YYYYMM')
				  WHEN T2.RNO = 3 THEN 'Total' END
			,CASE WHEN T2.RNO = 1 THEN T1.CUS_ID
				  WHEN T2.RNO = 2 THEN 'Total'
				  WHEN T2.RNO = 3 THEN 'Total' END;

				  
			  
-- ************************************************
-- PART I - 2.3.1 SQL4
-- ************************************************

	-- ROLLUP을 WITH 절과 UNION ALL로 대체
	WITH T_RES AS(
		  SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.CUS_ID
				  ,SUM(T1.ORD_AMT) ORD_AMT
		  FROM    T_ORD T1
		  WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
		  AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
		  AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
		  GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID
		  )
	SELECT  T1.ORD_YM ,T1.CUS_ID ,T1.ORD_AMT
	FROM    T_RES T1
	UNION ALL
	SELECT  T1.ORD_YM ,'Total' ,SUM(T1.ORD_AMT)
	FROM    T_RES T1
	GROUP BY T1.ORD_YM
	UNION ALL
	SELECT  'Total' ,'Total' ,SUM(T1.ORD_AMT)
	FROM    T_RES T1;


			  
-- ************************************************
-- PART I - 2.3.2 SQL1
-- ************************************************

	-- 주문상태(ORD_ST), 주문년월, 고객ID별 주문금액 ? CUBE로 가능한 모든 소계를 추가
	SELECT  CASE  WHEN GROUPING(T1.ORD_ST)=1 THEN 'Total' ELSE T1.ORD_ST END ORD_ST
			,CASE WHEN GROUPING(TO_CHAR(T1.ORD_DT,'YYYYMM'))=1 THEN 'Total' 
				  ELSE TO_CHAR(T1.ORD_DT,'YYYYMM') END ORD_YM
			,CASE WHEN GROUPING(T1.CUS_ID)=1 THEN 'Total' ELSE T1.CUS_ID END CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0001','CUS_0002')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD') 
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	GROUP BY CUBE(T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID)
	ORDER BY T1.ORD_ST ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.CUS_ID;


-- ************************************************
-- PART I - 2.3.3 SQL1
-- ************************************************

	-- 주문년월, 고객ID별 주문건수와 주문 금액 ? GROUPING SETS 활용
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,T1.CUS_ID
			,COUNT(*) ORD_CNT
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	AND     T1.CUS_ID IN ('CUS_0061','CUS_0062')
	GROUP BY GROUPING SETS(
					  (TO_CHAR(T1.ORD_DT,'YYYYMM'),T1.CUS_ID)  --GROUP BY기본 데이터
					  ,(TO_CHAR(T1.ORD_DT,'YYYYMM'))  --주문년월별 소계
					  ,(T1.CUS_ID)  --고객ID별 소계
					  ,()   --전체합계
				  );

