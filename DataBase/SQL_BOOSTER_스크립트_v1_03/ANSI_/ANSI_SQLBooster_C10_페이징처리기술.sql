-- ************************************************
-- PART III - 10.1.2 SQL1
-- ************************************************

	-- 주문 리스트를 조회
	SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
			,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
	FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
	WHERE   T1.ORD_YMD LIKE '201703%'
	AND     T1.CUS_ID = T2.CUS_ID
	AND     T3.RGN_ID = T2.RGN_ID
	ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC;



-- ************************************************
-- PART III - 10.1.2 SQL2
-- ************************************************

	-- 주문 리스트를 조회 ? 첫 번째 페이지
	SELECT  *
	FROM    (
			SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
					,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
			FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
			WHERE   T1.ORD_YMD LIKE '201703%'
			AND     T1.CUS_ID = T2.CUS_ID
			AND     T3.RGN_ID = T2.RGN_ID
			ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
			) T_PG1
	WHERE   ROWNUM <= 30;




-- ************************************************
-- PART III - 10.1.2 SQL3
-- ************************************************

	-- 주문 리스트를 조회 ? 첫 번째 페이지, ROWNUM을 잘못 사용
	SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
			,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
	FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
	WHERE   T1.ORD_YMD LIKE '201703%'
	AND     T1.CUS_ID = T2.CUS_ID
	AND     T3.RGN_ID = T2.RGN_ID
	AND     ROWNUM <= 30
	ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC



-- ************************************************
-- PART III - 10.1.2 SQL4
-- ************************************************

	-- 주문 리스트를 조회 ? 두 번째 페이지 조회, 잘못된 처리
	SELECT  *
	FROM    (
			SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
					,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
			FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
			WHERE   T1.ORD_YMD LIKE '201703%'
			AND     T1.CUS_ID = T2.CUS_ID
			AND     T3.RGN_ID = T2.RGN_ID
			ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
			) T_PG1
	WHERE   ROWNUM >= 31
	AND     ROWNUM <= 60;



-- ************************************************
-- PART III - 10.1.2 SQL5
-- ************************************************

	-- 조회가 가능한 ROWNUM
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM = 1; --조회 가능
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM = 2; --조회 불가능
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM <= 2; --조회 가능
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM >= 2; --조회 불가능




-- ************************************************
-- PART III - 10.1.2 SQL6
-- ************************************************

	-- 주문 리스트를 조회 ? 두 번째 페이지 조회
	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO
					,T1.*
			FROM    (
					SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
							,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
					FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
					WHERE   T1.ORD_YMD LIKE '201703%'
					AND     T1.CUS_ID = T2.CUS_ID
					AND     T3.RGN_ID = T2.RGN_ID
					ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= 60
			) T2
	WHERE   T2.RNO >= 31;



-- ************************************************
-- PART III - 10.1.3 SQL1
-- ************************************************

	-- 주문 리스트를 조회 ? DB-INDEX 페이징
	--페이징 처리를 위한 인덱스를 추가
	CREATE INDEX X_T_ORD_JOIN_PG1 ON T_ORD_JOIN(ORD_YMD, ORD_SEQ);

	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO
					,T1.*
			FROM    (
					SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
							,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
					FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
					WHERE   T1.ORD_YMD LIKE '201703%'
					AND     T1.CUS_ID = T2.CUS_ID
					AND     T3.RGN_ID = T2.RGN_ID
					ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= 60
			) T2
	WHERE   T2.RNO >= 31;


-- ************************************************
-- PART III - 10.1.3 SQL2
-- ************************************************

	-- DB-INDEX 페이징 - 100번째 페이지 조회
	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO
					,T1.*
			FROM    (
					SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
							,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
					FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
					WHERE   T1.ORD_YMD LIKE '201703%'
					AND     T1.CUS_ID = T2.CUS_ID
					AND     T3.RGN_ID = T2.RGN_ID
					ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= 100 * 30 --페이지번호 * 페이지당 로우수
			) T2
	WHERE   T2.RNO >= (100 * 30) - (30-1) --(페이지번호 * 페이지당 로우수) - (페이지당로우수-1)



-- ************************************************
-- PART III - 10.1.3 SQL3
-- ************************************************

	-- DB-INDEX 페이징 - 100번째 페이지 조회 힌트 사용
	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO
					,T1.*
			FROM    (
					SELECT  /*+ LEADING(T1) USE_NL(T2 T3) */
							T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
							,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
					FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
					WHERE   T1.ORD_YMD LIKE '201703%'
					AND     T1.CUS_ID = T2.CUS_ID
					AND     T3.RGN_ID = T2.RGN_ID
					ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= 100 * 30 --페이지번호 * 페이지당 로우수
			) T2
	WHERE   T2.RNO >= (100 * 30) - (30-1) --(페이지번호 * 페이지당 로우수) - (페이지당로우수-1)


-- ************************************************
-- PART III - 10.2.1 SQL1
-- ************************************************

	-- 페이징을 위한 카운트
	SELECT  COUNT(*)
	FROM    (
			SELECT  T1.ORD_SEQ  ,T1.ORD_YMD  ,T1.CUS_ID  ,T2.CUS_NM
					,T3.RGN_NM  ,T1.ORD_ST  ,T1.ITM_ID
			FROM    T_ORD_JOIN T1 ,M_CUS T2 ,M_RGN T3
			WHERE   T1.ORD_YMD LIKE '201703%'
			AND     T1.CUS_ID = T2.CUS_ID
			AND     T3.RGN_ID = T2.RGN_ID
			ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
			) T1;



-- ************************************************
-- PART III - 10.2.1 SQL2
-- ************************************************

	-- 페이징을 위한 카운트 최적화
	SELECT  COUNT(*)
	FROM    (
			SELECT  *
			FROM    (
					SELECT  T1.ORD_SEQ  ,T1.ORD_YMD
					FROM    T_ORD_JOIN T1
					WHERE   T1.ORD_YMD LIKE '201703%'
					ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= (30 * 10) + 1
			) T1;
			
			

-- ************************************************
-- PART III - 10.2.2 SQL1
-- ************************************************

	-- DB-INDEX 페이징 - 100번째 페이지 조회 성능 개선
	SELECT  T_PG.RNO
			,T_PG.ORD_SEQ ,T_PG.ORD_YMD ,T_PG.CUS_ID ,T2.CUS_NM
			,T3.RGN_NM ,T_PG.ORD_ST ,T_PG.ITM_ID
	FROM    (
			SELECT  ROWNUM RNO
					,T1.*
			FROM    (
					SELECT  T1.ORD_SEQ ,T1.ORD_YMD  ,T1.CUS_ID  
							,T1.ORD_ST ,T1.ITM_ID
					FROM    T_ORD_JOIN T1
					WHERE   T1.ORD_YMD LIKE '201703%'
					ORDER BY T1.ORD_YMD DESC ,T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= 100 * 30 --페이지번호 * 페이지당 로우수
			) T_PG
			,M_CUS T2
			,M_RGN T3
	WHERE   T_PG.RNO >= (100 * 30) - (30-1) --(페이지번호 * 페이지당 로우수) - (페이지당로우수-1)
	AND     T2.CUS_ID = T_PG.CUS_ID
	AND     T3.RGN_ID = T2.RGN_ID
	ORDER BY T_PG.RNO;



-- ************************************************
-- PART III - 10.2.3 SQL1
-- ************************************************

	-- DB-INDEX 페이징이 되지 않는 SQL
	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO ,A.*
			FROM    (
					SELECT  T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM
							,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
					FROM    M_CUS T1
							,T_ORD_JOIN T2
					WHERE   T2.CUS_ID(+) = T1.CUS_ID
					AND     T2.ORD_YMD(+) LIKE '201703%'
					GROUP BY T1.CUS_ID
					ORDER BY T1.CUS_ID
					) A
			WHERE   ROWNUM <= 30
			) B
	WHERE   B.RNO >= 1;



-- ************************************************
-- PART III - 10.2.3 SQL2
-- ************************************************

	-- DB-INDEX 페이징이 되지 않는 SQL, M_CUS만 사용해서 DB-INDEX 페이징을 구현
	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO ,A.*
			FROM    (
					SELECT  T1.CUS_ID ,T1.CUS_NM
					FROM    M_CUS T1
					ORDER BY T1.CUS_ID
					) A
			WHERE   ROWNUM <= 30
			) B
	WHERE   B.RNO >= 1;




-- ************************************************
-- PART III - 10.2.3 SQL3
-- ************************************************

	-- 페이징 후 T_ORD_JOIN을 서브쿼리로 처리
	SELECT  B.*
			,(    SELECT  SUM(C.ORD_QTY * C.UNT_PRC) ORD_AMT
				  FROM    T_ORD_JOIN C
				  WHERE   C.CUS_ID = B.CUS_ID
				  AND     C.ORD_YMD LIKE '201703%') ORD_AMT
	FROM    (
			SELECT  ROWNUM RNO ,A.*
			FROM    (
					SELECT  T1.CUS_ID ,T1.CUS_NM
					FROM    M_CUS T1
					ORDER BY T1.CUS_ID
					) A
			WHERE   ROWNUM <= 30
			) B
	WHERE   B.RNO >= 1



-- ************************************************
-- PART III - 10.2.3 SQL4
-- ************************************************

	-- 페이징 후 T_ORD_JOIN을 아우터-조인으로 처리
	SELECT  T1.RNO ,T1.CUS_ID ,MAX(T1.CUS_NM)
			,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
	FROM    (
			SELECT  B.*
			FROM    (
					SELECT  ROWNUM RNO ,A.*
					FROM    (
							SELECT  T1.CUS_ID ,T1.CUS_NM
							FROM    M_CUS T1
							ORDER BY T1.CUS_ID
							) A
					WHERE   ROWNUM <= 30
					) B
			WHERE   B.RNO >= 1
			) T1
			,T_ORD_JOIN T2
	WHERE   T2.CUS_ID(+) = T1.CUS_ID
	AND     T2.ORD_YMD(+) LIKE '201703%'
	GROUP BY T1.RNO ,T1.CUS_ID
	ORDER BY T1.RNO ,T1.CUS_ID;





-- ************************************************
-- PART III - 10.2.4 SQL1
-- ************************************************

	-- 주문 리스트를 조회 ? DB-INDEX 페이징, 요건 변경
	SELECT  T_PG.RNO
			,T_PG.ORD_SEQ ,T_PG.ORD_YMD ,T_PG.CUS_ID ,T2.CUS_NM
			,T3.RGN_NM ,T_PG.ORD_ST ,T_PG.ITM_ID
	FROM    (
			SELECT  ROWNUM RNO
					,T1.*
			FROM    (
					SELECT  T1.ORD_SEQ ,T1.ORD_YMD  ,T1.CUS_ID  
							,T1.ORD_ST ,T1.ITM_ID
					FROM    T_ORD_JOIN T1
					WHERE   T1.ORD_YMD LIKE '201703%'
					ORDER BY T1.ORD_YMD DESC , T1.CUS_ID DESC, T1.ORD_SEQ DESC
					) T1
			WHERE   ROWNUM <= 100 * 30 --페이지번호 * 페이지당 로우수
			) T_PG
			,M_CUS T2
			,M_RGN T3
	WHERE   T_PG.RNO >= (100 * 30) - (30-1) --(페이지번호 * 페이지당 로우수) - (페이지당로우수-1)
	AND     T2.CUS_ID = T_PG.CUS_ID
	AND     T3.RGN_ID = T2.RGN_ID
	ORDER BY T_PG.RNO;


-- ************************************************
-- PART III - 10.2.4 SQL2
-- ************************************************

	-- DB-INDEX 페이징이 불가능한 경우
	SELECT  *
	FROM    (
			SELECT  ROWNUM RNO ,T1.*
			FROM    (
					SELECT  T1.CUS_ID ,MAX(T1.CUS_NM) CUS_NM
							,SUM(T2.ORD_QTY * T2.UNT_PRC) ORD_AMT
					FROM    M_CUS T1
							,T_ORD_JOIN T2
					WHERE   T1.CUS_ID = T2.CUS_ID(+)
					AND     T2.ORD_YMD(+) LIKE '201703%'
					GROUP BY T1.CUS_ID
					ORDER BY SUM(T2.ORD_QTY * T2.UNT_PRC) DESC ,T1.CUS_ID
					) T1
			WHERE   ROWNUM <= 60
			) T2
	WHERE   T2.RNO >= 31;




