


-- ************************************************
-- PART I - 4.1.2 SQL1
-- ************************************************

	-- 17��8�� �� �ֹ��ݾ� ���ϱ� ? SELECT�� �ܵ� ��������
	SELECT  TO_CHAR(T1.ORD_DT, 'YYYYMMDD') ORD_YMD
			,SUM(T1.ORD_AMT) ORD_AMT
			,(
	SELECT  SUM(A.ORD_AMT)
			  FROM    T_ORD A 
			  WHERE   A.ORD_DT >= TO_DATE('20170801','YYYYMMDD') 
			  AND     A.ORD_DT < TO_DATE('20170901','YYYYMMDD')
			) TOTAL_ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT, 'YYYYMMDD');




-- ************************************************
-- PART I - 4.1.2 SQL2
-- ************************************************

	-- 17��8�� �� �ֹ��ݾ�, �ֹ������� �ֹ��ݾ׺��� ���ϱ� ? SELECT�� �ܵ� ��������
	-- �ֹ��ݾ� ���� = �ֹ����ں� �ֹ��ݾ�(ORD_AMT) / 17��8�� �ֹ� �� �ݾ�(TOTAL_ORD_AMT) * 100.00
	SELECT  TO_CHAR(T1.ORD_DT, 'YYYYMMDD') ORD_YMD
			,SUM(T1.ORD_AMT) ORD_AMT
			,(
			  SELECT  SUM(A.ORD_AMT)
			  FROM    T_ORD A 
			  WHERE   A.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
			  AND     A.ORD_DT < TO_DATE('20170901','YYYYMMDD')
			) TOTAL_ORD_AMT
			,ROUND(
			  SUM(T1.ORD_AMT) / (
				  SELECT  SUM(A.ORD_AMT)
				  FROM    T_ORD A 
				  WHERE   A.ORD_DT >= TO_DATE('20170801','YYYYMMDD') 
				  AND     A.ORD_DT < TO_DATE('20170901','YYYYMMDD')
				)  * 100,2) ORD_AMT_RT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT, 'YYYYMMDD');



-- ************************************************
-- PART I - 4.1.2 SQL3
-- ************************************************

	-- �ζ���-�並 ����� �ݺ� ���������� �����ϴ� ���
	SELECT  T1.ORD_YMD
			,T1.ORD_AMT
			,T1.TOTAL_ORD_AMT
			,ROUND(T1.ORD_AMT / T1.TOTAL_ORD_AMT * 100,2) ORD_AMT_RT
	FROM    (
			SELECT  TO_CHAR(T1.ORD_DT, 'YYYYMMDD') ORD_YMD
					,SUM(T1.ORD_AMT) ORD_AMT
					,(SELECT  SUM(A.ORD_AMT)
					  FROM    T_ORD A 
					  WHERE   A.ORD_DT >= TO_DATE('20170801','YYYYMMDD') 
					  AND     A.ORD_DT < TO_DATE('20170901','YYYYMMDD')
					) TOTAL_ORD_AMT
			FROM    T_ORD T1
			WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
			AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
			GROUP BY TO_CHAR(T1.ORD_DT, 'YYYYMMDD') 
			) T1;
			
			
-- ************************************************
-- PART I - 4.1.2 SQL4
-- ************************************************

	-- ī�׽þ�-������ ����� �ݺ� ���������� �����ϴ� ���
	SELECT  TO_CHAR(T1.ORD_DT, 'YYYYMMDD') ORD_YMD
			,SUM(T1.ORD_AMT) ORD_AMT
			,MAX(T2.TOTAL_ORD_AMT) TOTAL_ORD_AMT
			,ROUND(SUM(T1.ORD_AMT) / MAX(T2.TOTAL_ORD_AMT) * 100, 2) ORD_AMT_RT
	FROM    T_ORD T1
			,(    SELECT  SUM(A.ORD_AMT) TOTAL_ORD_AMT
				  FROM    T_ORD A 
				  WHERE   A.ORD_DT >= TO_DATE('20170801','YYYYMMDD') 
				  AND     A.ORD_DT < TO_DATE('20170901','YYYYMMDD')
	) T2
	WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT, 'YYYYMMDD');


-- ************************************************
-- PART I - 4.1.3 SQL1
-- ************************************************

	-- �ڵ尪�� �������� SELECT �� ��� ��������
	SELECT  T1.ITM_TP
			,(SELECT  A.BAS_CD_NM 
			  FROM    C_BAS_CD A 
			  WHERE   A.BAS_CD_DV = 'ITM_TP' AND A.BAS_CD = T1.ITM_TP AND A.LNG_CD = 'KO') ITM_TP_NM
			,T1.ITM_ID ,T1.ITM_NM
	FROM    M_ITM T1;




-- ************************************************
-- PART I - 4.1.3 SQL2
-- ************************************************

	-- �������� �������� SELECT �� ��� ��������
	SELECT  T1.CUS_ID
			,TO_CHAR(T1.ORD_DT,'YYYYMMDD') ORD_YMD
			,(SELECT A.CUS_NM FROM M_CUS A WHERE A.CUS_ID = T1.CUS_ID) CUS_NM
			,(SELECT A.CUS_GD FROM M_CUS A WHERE A.CUS_ID = T1.CUS_ID) CUS_GD
			,T1.ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD');



-- ************************************************
-- PART I - 4.1.3 SQL3
-- ************************************************

	-- �ζ���-�� �ȿ��� SELECT �� ���������� ����� ��
	SELECT  T1.CUS_ID ,SUBSTR(T1.ORD_YMD,1,6) ORD_YM
			,MAX(T1.CUS_NM) ,MAX(T1.CUS_GD)
			,T1.ORD_ST_NM ,T1.PAY_TP_NM
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    (
			SELECT  T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMMDD') ORD_YMD ,T2.CUS_NM ,T2.CUS_GD
					,(SELECT  A.BAS_CD_NM 
					  FROM    C_BAS_CD A 
					  WHERE A.BAS_CD_DV = 'ORD_ST' AND A.BAS_CD = T1.ORD_ST AND A.LNG_CD = 'KO') ORD_ST_NM
					,(SELECT  A.BAS_CD_NM 
					  FROM    C_BAS_CD A 
					  WHERE A.BAS_CD_DV = 'PAY_TP' AND A.BAS_CD = T1.PAY_TP AND A.LNG_CD = 'KO') PAY_TP_NM
					,T1.ORD_AMT
			FROM    T_ORD T1
					,M_CUS T2
			WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
			AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
			AND     T1.CUS_ID = T2.CUS_ID
			) T1
	GROUP BY T1.CUS_ID ,SUBSTR(T1.ORD_YMD,1,6) ,T1.ORD_ST_NM ,T1.PAY_TP_NM;




-- ************************************************
-- PART I - 4.1.3 SQL4
-- ************************************************

	-- �������� �ȿ��� ������ ����� ��
	SELECT  T1.ORD_DT ,T2.ORD_QTY ,T2.ITM_ID ,T3.ITM_NM
	,(    SELECT  SUM(B.EVL_PT) / COUNT(*)
				  FROM    M_ITM A
						  ,T_ITM_EVL B
				  WHERE   A.ITM_TP = T3.ITM_TP
				  AND     B.ITM_ID = A.ITM_ID
				  AND     B.EVL_DT < T1.ORD_DT
			) ITM_TP_EVL_PT_AVG
	FROM    T_ORD T1
			,T_ORD_DET T2
			,M_ITM T3
	WHERE   T1.ORD_DT >= TO_DATE('20170801','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
	AND     T3.ITM_ID = T2.ITM_ID
	AND     T1.ORD_SEQ = T2.ORD_SEQ
	ORDER BY T1.ORD_DT ,T2.ITM_ID;



-- ************************************************
-- PART I - 4.1.4 SQL1
-- ************************************************

	-- ������ �Ұ����� SELECT ���� ��������
	--SELECT ���� ������������ �� �÷��� ����.
	SELECT  T1.ORD_DT ,T1.CUS_ID
			,(SELECT A.CUS_NM ,A.CUS_GD FROM M_CUS A WHERE A.CUS_ID = T1.CUS_ID) CUS_NM_GD
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170401','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD');

	--SELECT ���� ������������ �� �� �̻��� �����Ͱ� ������ ���.
	SELECT  T1.ORD_DT ,T1.CUS_ID
			,(SELECT A.ITM_ID FROM T_ORD_DET A WHERE A.ORD_SEQ = T1.ORD_SEQ) ITM_LIST
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170401','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD');


-- ************************************************
-- PART I - 4.1.4 SQL2
-- ************************************************

	-- �� �̸��� ����� ���ļ� �ϳ��� �÷����� ó��
	-- �ܰ�(UNT_PRC)�� �ֹ�����(ORD_QTY)�� ���ؼ� �ֹ��ݾ����� ó��.
	SELECT  T1.ORD_DT ,T1.CUS_ID
			,(SELECT A.CUS_NM||'('||CUS_GD||')' FROM M_CUS A WHERE A.CUS_ID = T1.CUS_ID) CUS_NM_GD
			,(SELECT SUM(A.UNT_PRC * A.ORD_QTY) FROM T_ORD_DET A WHERE A.ORD_SEQ = T1.ORD_SEQ) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170401','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD');


-- ************************************************
-- PART I - 4.1.4 SQL3
-- ************************************************


	-- ���� ������ ORD_SEQ�� �ֹ��ݾ�
	SELECT  T1.CUS_ID
			,T1.CUS_NM
			,(SELECT  TO_NUMBER(
						SUBSTR(
							MAX(
							  LPAD(TO_CHAR(A.ORD_SEQ),8,'0')
							  ||TO_CHAR(A.ORD_AMT)
							  ),9))
						FROM T_ORD A WHERE A.CUS_ID = T1.CUS_ID) LAST_ORD_AMT
	FROM    M_CUS T1
	ORDER BY T1.CUS_ID;


-- ************************************************
-- PART I - 4.1.4 SQL4
-- ************************************************

	-- ���� ������ ORD_SEQ�� �ֹ��ݾ� ? ��ø�� ��������
	SELECT  T1.CUS_ID
			,T1.CUS_NM
			,(
				SELECT  B.ORD_AMT
				FROM    T_ORD B 
				WHERE   B.ORD_SEQ = 
						  (SELECT MAX(A.ORD_SEQ) FROM T_ORD A WHERE A.CUS_ID = T1.CUS_ID)
				) LAST_ORD_AMT
	FROM    M_CUS T1
	ORDER BY T1.CUS_ID;



-- ************************************************
-- PART I - 4.1.4 SQL5
-- ************************************************

	-- �������� ������ �����ϴ� �������� ? ���� ����
	SELECT  T1.ORD_DT
			,T1.CUS_ID
			,(SELECT A.ORD_QTY FROM T_ORD_DET A WHERE A.ORD_SEQ = T1.ORD_SEQ) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_SEQ = 2297;


-- ************************************************
-- PART I - 4.1.4 SQL6
-- ************************************************

	-- �������� ������ �����ϴ� �������� ? ���� �߻�
	--1. ������ �߻��ϴ� ��������(ORD_SEQ = 2291)
	SELECT  T1.ORD_DT
			,T1.CUS_ID
			,(SELECT A.ORD_QTY FROM T_ORD_DET A WHERE A.ORD_SEQ = T1.ORD_SEQ) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_SEQ = 2291;

	--2. T_ORD_DET�� ORD_SEQ�� 2291�� �����ʹ� �� ���� �����Ѵ�.
	SELECT  T1.*
	FROM    T_ORD_DET T1
	WHERE   T1.ORD_SEQ = 2291;


-- ************************************************
-- PART I - 4.1.5 SQL1
-- ************************************************

	-- ������ �ֹ� �� ���� ��ȸ�ϴ� SQL, ORD_SEQ�� ���� ū �����Ͱ� ������ �ֹ��̴�.
	SELECT  *
	FROM    T_ORD T1
	WHERE   T1.ORD_SEQ = (SELECT MAX(A.ORD_SEQ) FROM T_ORD A);




-- ************************************************
-- PART I - 4.1.5 SQL2
-- ************************************************

	-- ������ �ֹ� �� ���� ��ȸ�ϴ� SQL, ORDER BY�� ROWNUM�� ���
	SELECT  *
	FROM    (
			SELECT  *
			FROM    T_ORD T1
			ORDER BY T1.ORD_SEQ DESC
			) A
	WHERE  ROWNUM <= 1;


-- ************************************************
-- PART I - 4.1.5 SQL3
-- ************************************************

	-- ������ �ֹ� ������ �����͸� �������� SQL
	SELECT  *
	FROM    T_ORD T1
	WHERE   T1.ORD_DT = (SELECT MAX(A.ORD_DT) FROM T_ORD A);




-- ************************************************
-- PART I - 4.1.5 SQL4
-- ************************************************

	-- 3�� �ֹ� �Ǽ��� 4�� �̻��� ���� 3���� �ֹ� ����Ʈ
	SELECT  *
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170401','YYYYMMDD')
	AND     T1.CUS_ID IN (
				SELECT  A.CUS_ID
				FROM    T_ORD A
				WHERE   A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
				AND     A.ORD_DT < TO_DATE('20170401','YYYYMMDD')
				GROUP BY A.CUS_ID
				HAVING COUNT(*)>=4
				);

				
				

-- ************************************************
-- PART I - 4.1.5 SQL5
-- ************************************************

	-- 3�� �ֹ� �Ǽ��� 4�� �̻��� ���� 3���� �ֹ� ����Ʈ ? �������� ó��
	SELECT  T1.*
	FROM    T_ORD T1
			,(
				SELECT  A.CUS_ID
				FROM    T_ORD A
				WHERE   A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
				AND     A.ORD_DT < TO_DATE('20170401','YYYYMMDD')
				GROUP BY A.CUS_ID
				HAVING COUNT(*)>=4
			) T2
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170401','YYYYMMDD')
	AND     T1.CUS_ID = T2.CUS_ID;




-- ************************************************
-- PART I - 4.1.6 SQL1
-- ************************************************

	-- 3���� �ֹ��� �����ϴ� ������ ��ȸ
	SELECT  *
	FROM    M_CUS T1
	WHERE   EXISTS(
			  SELECT  *
			  FROM    T_ORD A
			  WHERE   A.CUS_ID = T1.CUS_ID
			  AND     A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
			  AND     A.ORD_DT < TO_DATE('20170401','YYYYMMDD')
			  );


		  
		  
-- ************************************************
-- PART I - 4.1.6 SQL2
-- ************************************************

	-- 3���� ELEC ������������ �ֹ��� �����ϴ� ������ ��ȸ
	SELECT  *
	FROM    M_CUS T1
	WHERE   EXISTS(
			  SELECT  *
			  FROM    T_ORD A
					  ,T_ORD_DET B
					  ,M_ITM C
			  WHERE   A.CUS_ID = T1.CUS_ID
			  AND     A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
			  AND     A.ORD_DT < TO_DATE('20170401','YYYYMMDD')
			  AND     A.ORD_SEQ = B.ORD_SEQ
			  AND     B.ITM_ID = C.ITM_ID
			  AND     C.ITM_TP = 'ELEC'
			  );


			  
		  
-- ************************************************
-- PART I - 4.1.6 SQL3
-- ************************************************

	-- ��ü ���� ��ȸ, 3���� �ֹ��� �����ϴ��� ���θ� ���� ������
	SELECT  T1.CUS_ID ,T1.CUS_NM
			,(CASE  WHEN
					  EXISTS(
						  SELECT  *
						  FROM    T_ORD A 
						  WHERE   A.CUS_ID = T1.CUS_ID 
						  AND     A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
						  AND     A.ORD_DT < TO_DATE('20170401','YYYYMMDD')
						  ) 
			  THEN 'Y' 
			  ELSE 'N' END) ORD_YN_03
	FROM    M_CUS T1;




-- ************************************************
-- PART I - 4.2.1 SQL1
-- ************************************************

	-- MERGE ���� ���� �׽�Ʈ ���̺� ����
	CREATE TABLE M_CUS_CUD_TEST AS
	SELECT  *
	FROM    M_CUS T1;

	ALTER TABLE M_CUS_CUD_TEST
		ADD CONSTRAINT PK_M_CUS_CUD_TEST PRIMARY KEY(CUS_ID) USING INDEX;
		


-- ************************************************
-- PART I - 4.2.1 SQL2
-- ************************************************

	-- CUS_0090 ���� �Է��ϰų� �����ϴ� PL/SQL
	DECLARE v_EXISTS_YN varchar2(1);
	BEGIN
		SELECT  NVL(MAX('Y'),'N')
		INTO    v_EXISTS_YN
		FROM    DUAL A
		WHERE   EXISTS(
				  SELECT  *
				  FROM    M_CUS_CUD_TEST T1
				  WHERE   T1.CUS_ID = 'CUS_0090'
				  );
		
		IF v_EXISTS_YN = 'N' THEN
			INSERT INTO M_CUS_CUD_TEST (CUS_ID ,CUS_NM ,CUS_GD)
			VALUES  ('CUS_0090' ,'NAME_0090' ,'A');
			
			DBMS_OUTPUT.PUT_LINE('INSERT NEW CUST');
		ELSE
			UPDATE  M_CUS_CUD_TEST T1
			SET     T1.CUS_NM = 'NAME_0090'
					,T1.CUS_GD = 'A'
			WHERE   CUS_ID = 'CUS_0090'
			;
			
			DBMS_OUTPUT.PUT_LINE('UPDATE OLD CUST');
		END IF;
		
		COMMIT;
	END;



-- ************************************************
-- PART I - 4.2.1 SQL3
-- ************************************************

	-- ���� �Է��ϰų� �����ϴ� SQL ? MERGE ������ ó��
	MERGE INTO M_CUS_CUD_TEST T1
	USING (
		  SELECT  'CUS_0090' CUS_ID
				  ,'NAME_0090' CUS_NM
				  ,'A' CUS_GD
		  FROM    DUAL
		  ) T2
		  ON (T1.CUS_ID = T2.CUS_ID)
	WHEN MATCHED THEN UPDATE SET T1.CUS_NM = T2.CUS_NM
								,T1.CUS_GD = T2.CUS_GD
	WHEN NOT MATCHED THEN INSERT (T1.CUS_ID ,T1.CUS_NM ,T1.CUS_GD)
						  VALUES(T2.CUS_ID ,T2.CUS_NM ,T2.CUS_GD)
						  ;
	COMMIT;



-- ************************************************
-- PART I - 4.2.2 SQL1
-- ************************************************

	-- �������ֹ� ���̺� ���� �� ���� ������ �Է�
	CREATE TABLE S_CUS_YM
	(
		BAS_YM	VARCHAR2(6) NOT NULL,
		CUS_ID 	VARCHAR2(40) NOT NULL,
		ITM_TP 	VARCHAR2(40) NOT NULL,
		ORD_QTY NUMBER(18,3) NULL,
		ORD_AMT NUMBER(18,3) NULL
	);

	CREATE UNIQUE INDEX PK_S_CUS_YM ON S_CUS_YM(BAS_YM, CUS_ID, ITM_TP);

	ALTER TABLE S_CUS_YM
		ADD CONSTRAINT PK_S_CUM_YM PRIMARY KEY (BAS_YM, CUS_ID, ITM_TP);

	INSERT INTO S_CUS_YM (BAS_YM ,CUS_ID ,ITM_TP ,ORD_QTY ,ORD_AMT)
	SELECT  '201702' BAS_YM ,T1.CUS_ID ,T2.BAS_CD ITM_TP ,NULL ORD_QTY ,NULL ORD_AMT
	FROM    M_CUS T1
			,C_BAS_CD T2
	WHERE   T2.BAS_CD_DV = 'ITM_TP'
	AND     T2.LNG_CD = 'KO';

	COMMIT;



-- ************************************************
-- PART I - 4.2.2 SQL2
-- ************************************************

	-- �������ֹ��� �ֹ�����, �ֹ��ݾ� ������Ʈ
	UPDATE  S_CUS_YM T1
	SET     T1.ORD_QTY = (
					SELECT  SUM(B.ORD_QTY)
					FROM    T_ORD A
							,T_ORD_DET B
							,M_ITM C
					WHERE   A.ORD_SEQ = B.ORD_SEQ
					AND     C.ITM_ID = B.ITM_ID
					AND     C.ITM_TP = T1.ITM_TP
					AND     A.CUS_ID = T1.CUS_ID
					AND     A.ORD_DT >= TO_DATE(T1.BAS_YM||'01','YYYYMMDD')
					AND     A.ORD_DT < ADD_MONTHS(TO_DATE(T1.BAS_YM||'01','YYYYMMDD'), 1)
					)
			,T1.ORD_AMT = (
					SELECT  SUM(B.UNT_PRC * B.ORD_QTY)
					FROM    T_ORD A
							,T_ORD_DET B
							,M_ITM C
					WHERE   A.ORD_SEQ = B.ORD_SEQ
					AND     C.ITM_ID = B.ITM_ID
					AND     C.ITM_TP = T1.ITM_TP
					AND     A.CUS_ID = T1.CUS_ID
					AND     A.ORD_DT >= TO_DATE(T1.BAS_YM||'01','YYYYMMDD')
					AND     A.ORD_DT < ADD_MONTHS(TO_DATE(T1.BAS_YM||'01','YYYYMMDD'), 1)
					)
	WHERE   T1.BAS_YM = '201702';

	COMMIT;


-- ************************************************
-- PART I - 4.2.2 SQL3
-- ************************************************

	-- �������ֹ��� �ֹ��ݾ�, �ֹ����� ������Ʈ ? ���� ���
	MERGE INTO S_CUS_YM T1
	USING (
			  SELECT  A.CUS_ID
					  ,C.ITM_TP
					  ,SUM(B.ORD_QTY) ORD_QTY
					  ,SUM(B.UNT_PRC * B.ORD_QTY) ORD_AMT
			  FROM    T_ORD A
					  ,T_ORD_DET B
					  ,M_ITM C
			  WHERE   A.ORD_SEQ = B.ORD_SEQ
			  AND     C.ITM_ID = B.ITM_ID
			  AND     A.ORD_DT >= TO_DATE('201702'||'01','YYYYMMDD')
			  AND     A.ORD_DT < ADD_MONTHS(TO_DATE('201702'||'01','YYYYMMDD'), 1)
			  GROUP BY A.CUS_ID
					  ,C.ITM_TP
			  ) T2
			  ON (T1.BAS_YM = '201702'
				  AND T1.CUS_ID = T2.CUS_ID
				  AND T1.ITM_TP = T2.ITM_TP
				  )
	WHEN MATCHED THEN UPDATE SET T1.ORD_QTY = T2.ORD_QTY
								,T1.ORD_AMT = T2.ORD_AMT
								;                            
	COMMIT;


-- ************************************************
-- PART I - 4.2.2 SQL4
-- ************************************************

	-- �������ֹ��� �ֹ��ݾ�, �ֹ����� ������Ʈ ? �ݺ� �������� ����
	UPDATE  S_CUS_YM T1
	SET     (T1.ORD_QTY ,T1.ORD_AMT) =
			(
			  SELECT  SUM(B.ORD_QTY) ORD_QTY
					  ,SUM(B.UNT_PRC * B.ORD_QTY) ORD_AMT
			  FROM    T_ORD A
					  ,T_ORD_DET B
					  ,M_ITM C
			  WHERE   A.ORD_SEQ = B.ORD_SEQ
			  AND     C.ITM_ID = B.ITM_ID
			  AND     A.ORD_DT >= TO_DATE('201702'||'01','YYYYMMDD')
			  AND     A.ORD_DT < ADD_MONTHS(TO_DATE('201702'||'01','YYYYMMDD'), 1)
			  AND     C.ITM_TP = T1.ITM_TP
			  AND     A.CUS_ID = T1.CUS_ID
			  GROUP BY A.CUS_ID
					  ,C.ITM_TP
			)
	WHERE   T1.BAS_YM = '201702';

	COMMIT;



-- ************************************************
-- PART I - 4.3.1 SQL1
-- ************************************************

	-- ��, ������������ �ֹ��ݾ� ���ϱ� ? �ζ���-�� �̿�
	SELECT  T0.CUS_ID ,T1.CUS_NM ,T0.ITM_TP
			,(SELECT A.BAS_CD_NM FROM C_BAS_CD A
	WHERE A.LNG_CD = 'KO' AND A.BAS_CD_DV = 'ITM_TP' AND A.BAS_CD = T0.ITM_TP) ITM_TP_NM
			,T0.ORD_AMT
	FROM    (
			SELECT  A.CUS_ID ,C.ITM_TP ,SUM(B.ORD_QTY * B.UNT_PRC) ORD_AMT
			FROM    T_ORD A
					,T_ORD_DET B
					,M_ITM C
			WHERE   A.ORD_SEQ = B.ORD_SEQ
			AND     B.ITM_ID = C.ITM_ID
			AND     A.ORD_DT >= TO_DATE('20170201','YYYYMMDD')
			AND     A.ORD_DT < TO_DATE('20170301','YYYYMMDD')
			GROUP BY A.CUS_ID ,C.ITM_TP
			) T0
			,M_CUS T1
	WHERE   T1.CUS_ID = T0.CUS_ID
	ORDER BY T0.CUS_ID ,T0.ITM_TP;




-- ************************************************
-- PART I - 4.3.1 SQL2
-- ************************************************

	-- ��, ������������ �ֹ��ݾ� ���ϱ� ? WITH~AS �̿�
	WITH T_CUS_ITM_AMT AS (
			SELECT  A.CUS_ID ,C.ITM_TP ,SUM(B.ORD_QTY * B.UNT_PRC) ORD_AMT
			FROM    T_ORD A
					,T_ORD_DET B
					,M_ITM C
			WHERE   A.ORD_SEQ = B.ORD_SEQ
			AND     B.ITM_ID = C.ITM_ID
			AND     A.ORD_DT >= TO_DATE('20170201','YYYYMMDD')
			AND     A.ORD_DT < TO_DATE('20170301','YYYYMMDD')
			GROUP BY A.CUS_ID ,C.ITM_TP
			)
	SELECT  T0.CUS_ID ,T1.CUS_NM ,T0.ITM_TP
			,(SELECT A.BAS_CD_NM FROM C_BAS_CD A
	WHERE A.LNG_CD = 'KO' AND A.BAS_CD_DV = 'ITM_TP' AND A.BAS_CD = T0.ITM_TP) ITM_TP_NM
			,T0.ORD_AMT
	FROM    T_CUS_ITM_AMT T0
			,M_CUS T1
	WHERE   T1.CUS_ID = T0.CUS_ID
	ORDER BY T0.CUS_ID ,T0.ITM_TP;





-- ************************************************
-- PART I - 4.3.1 SQL3
-- ************************************************

	-- ��, ������������ �ֹ��ݾ� ���ϱ�, ��ü�ֹ� ��� �ֹ��ݾ׺��� �߰� ? WITH~AS �̿�
	WITH T_CUS_ITM_AMT AS (
			SELECT  A.CUS_ID ,C.ITM_TP ,SUM(B.ORD_QTY * B.UNT_PRC) ORD_AMT
			FROM    T_ORD A
					,T_ORD_DET B
					,M_ITM C
			WHERE   A.ORD_SEQ = B.ORD_SEQ
			AND     B.ITM_ID = C.ITM_ID
			AND     A.ORD_DT >= TO_DATE('20170201','YYYYMMDD')
			AND     A.ORD_DT < TO_DATE('20170301','YYYYMMDD')
			GROUP BY A.CUS_ID ,C.ITM_TP
			)
		,T_TTL_AMT AS(
			SELECT  SUM(A.ORD_AMT) ORD_AMT
			FROM    T_CUS_ITM_AMT A
			)
	SELECT  T0.CUS_ID ,T1.CUS_NM ,T0.ITM_TP
			,(SELECT A.BAS_CD_NM FROM C_BAS_CD A
				WHERE A.LNG_CD = 'KO' AND A.BAS_CD_DV = 'ITM_TP' AND A.BAS_CD = T0.ITM_TP) ITM_TP_NM
			,T0.ORD_AMT
			,TO_CHAR(ROUND(T0.ORD_AMT / T2.ORD_AMT * 100,2)) || '%' ORD_AMT_RT 
	FROM    T_CUS_ITM_AMT T0
			,M_CUS T1
			,T_TTL_AMT T2
	WHERE   T1.CUS_ID = T0.CUS_ID
	ORDER BY ROUND(T0.ORD_AMT / T2.ORD_AMT * 100,2) DESC;




-- ************************************************
-- PART I - 4.3.2 SQL1
-- ************************************************

	-- �ֹ��ݾ� ���� �÷� �߰�
	ALTER TABLE S_CUS_YM ADD ORD_AMT_RT NUMBER(18,3);



-- ************************************************
-- PART I - 4.3.2 SQL2
-- ************************************************

	-- WITH~AS ���� ����� INSERT��
	INSERT INTO S_CUS_YM (BAS_YM ,CUS_ID ,ITM_TP ,ORD_QTY ,ORD_AMT ,ORD_AMT_RT)
	WITH T_CUS_ITM_AMT AS (
			SELECT  TO_CHAR(A.ORD_DT,'YYYYMM') BAS_YM ,A.CUS_ID ,C.ITM_TP
					,SUM(B.ORD_QTY) ORD_QTY ,SUM(B.ORD_QTY * B.UNT_PRC) ORD_AMT
			FROM    T_ORD A
					,T_ORD_DET B
					,M_ITM C
			WHERE   A.ORD_SEQ = B.ORD_SEQ
			AND     B.ITM_ID = C.ITM_ID
			AND     A.ORD_DT >= TO_DATE('20170401','YYYYMMDD')
			AND     A.ORD_DT < TO_DATE('20170501','YYYYMMDD')
			GROUP BY TO_CHAR(A.ORD_DT,'YYYYMM') ,A.CUS_ID ,C.ITM_TP
			)
		,T_TTL_AMT AS(
			SELECT  SUM(A.ORD_AMT) ORD_AMT
			FROM    T_CUS_ITM_AMT A
			)
	SELECT  T0.BAS_YM ,T0.CUS_ID ,T0.ITM_TP ,T0.ORD_QTY ,T0.ORD_AMT
			,ROUND(T0.ORD_AMT / T2.ORD_AMT * 100,2) ORD_AMT_RT 
	FROM    T_CUS_ITM_AMT T0
			,M_CUS T1
			,T_TTL_AMT T2
	WHERE   T1.CUS_ID = T0.CUS_ID;


