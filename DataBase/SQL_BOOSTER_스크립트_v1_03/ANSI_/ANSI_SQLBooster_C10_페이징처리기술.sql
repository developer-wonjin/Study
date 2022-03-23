-- ************************************************
-- PART III - 10.1.2 SQL1
-- ************************************************

	-- �ֹ� ����Ʈ�� ��ȸ
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

	-- �ֹ� ����Ʈ�� ��ȸ ? ù ��° ������
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

	-- �ֹ� ����Ʈ�� ��ȸ ? ù ��° ������, ROWNUM�� �߸� ���
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

	-- �ֹ� ����Ʈ�� ��ȸ ? �� ��° ������ ��ȸ, �߸��� ó��
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

	-- ��ȸ�� ������ ROWNUM
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM = 1; --��ȸ ����
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM = 2; --��ȸ �Ұ���
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM <= 2; --��ȸ ����
	SELECT * FROM T_ORD_JOIN T1 WHERE ROWNUM >= 2; --��ȸ �Ұ���




-- ************************************************
-- PART III - 10.1.2 SQL6
-- ************************************************

	-- �ֹ� ����Ʈ�� ��ȸ ? �� ��° ������ ��ȸ
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

	-- �ֹ� ����Ʈ�� ��ȸ ? DB-INDEX ����¡
	--����¡ ó���� ���� �ε����� �߰�
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

	-- DB-INDEX ����¡ - 100��° ������ ��ȸ
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
			WHERE   ROWNUM <= 100 * 30 --��������ȣ * �������� �ο��
			) T2
	WHERE   T2.RNO >= (100 * 30) - (30-1) --(��������ȣ * �������� �ο��) - (��������ο��-1)



-- ************************************************
-- PART III - 10.1.3 SQL3
-- ************************************************

	-- DB-INDEX ����¡ - 100��° ������ ��ȸ ��Ʈ ���
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
			WHERE   ROWNUM <= 100 * 30 --��������ȣ * �������� �ο��
			) T2
	WHERE   T2.RNO >= (100 * 30) - (30-1) --(��������ȣ * �������� �ο��) - (��������ο��-1)


-- ************************************************
-- PART III - 10.2.1 SQL1
-- ************************************************

	-- ����¡�� ���� ī��Ʈ
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

	-- ����¡�� ���� ī��Ʈ ����ȭ
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

	-- DB-INDEX ����¡ - 100��° ������ ��ȸ ���� ����
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
			WHERE   ROWNUM <= 100 * 30 --��������ȣ * �������� �ο��
			) T_PG
			,M_CUS T2
			,M_RGN T3
	WHERE   T_PG.RNO >= (100 * 30) - (30-1) --(��������ȣ * �������� �ο��) - (��������ο��-1)
	AND     T2.CUS_ID = T_PG.CUS_ID
	AND     T3.RGN_ID = T2.RGN_ID
	ORDER BY T_PG.RNO;



-- ************************************************
-- PART III - 10.2.3 SQL1
-- ************************************************

	-- DB-INDEX ����¡�� ���� �ʴ� SQL
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

	-- DB-INDEX ����¡�� ���� �ʴ� SQL, M_CUS�� ����ؼ� DB-INDEX ����¡�� ����
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

	-- ����¡ �� T_ORD_JOIN�� ���������� ó��
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

	-- ����¡ �� T_ORD_JOIN�� �ƿ���-�������� ó��
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

	-- �ֹ� ����Ʈ�� ��ȸ ? DB-INDEX ����¡, ��� ����
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
			WHERE   ROWNUM <= 100 * 30 --��������ȣ * �������� �ο��
			) T_PG
			,M_CUS T2
			,M_RGN T3
	WHERE   T_PG.RNO >= (100 * 30) - (30-1) --(��������ȣ * �������� �ο��) - (��������ο��-1)
	AND     T2.CUS_ID = T_PG.CUS_ID
	AND     T3.RGN_ID = T2.RGN_ID
	ORDER BY T_PG.RNO;


-- ************************************************
-- PART III - 10.2.4 SQL2
-- ************************************************

	-- DB-INDEX ����¡�� �Ұ����� ���
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




