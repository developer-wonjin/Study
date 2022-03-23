

-- ************************************************
-- PART I - 2.1.1 SQL1
-- ************************************************

	-- �ֹ��Ͻ�, ���������� �ֹ��ݾ�
	SELECT  T1.ORD_DT ,T1.PAY_TP 
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY T1.ORD_DT ,T1.PAY_TP
	ORDER BY T1.ORD_DT ,T1.PAY_TP;


-- ************************************************
-- PART I - 2.1.1 SQL2
-- ************************************************

	-- �����Լ� - �������� SQL, ������ �߻��ϴ� SQL
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

	-- CASE�� �̿��� ��������(ORD_AMT_TP)���� �ֹ� �Ǽ��� ī��Ʈ
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

	-- TO_CHAR ������ �̿��� �ֹ����, ���������� �ֹ��Ǽ�
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.PAY_TP
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.PAY_TP
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.PAY_TP;




-- ************************************************
-- PART I - 2.1.3 SQL1
-- ************************************************

	-- �ֹ������ ������ü(PAY_TP=BANK) �Ǽ��� ī�����(PAY_TP=CARD) �Ǽ�
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

	-- ��������(PAY_TP)�� �ֹ��Ǽ�(�ֹ� �Ǽ��� �ֹ�������� �÷����� ǥ��)
	SELECT  T1.PAY_TP
			,COUNT(CASE WHEN TO_CHAR(T1.ORD_DT,'YYYYMM') = '201701' THEN 'X' END) ORD_CNT_1701
			,COUNT(CASE WHEN TO_CHAR(T1.ORD_DT,'YYYYMM') = '201702' THEN 'X' END) ORD_CNT_1702
			--...201703~201711�ݺ�.
			,COUNT(CASE WHEN TO_CHAR(T1.ORD_DT,'YYYYMM') = '201712' THEN 'X' END) ORD_CNT_1712
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY T1.PAY_TP
	ORDER BY T1.PAY_TP;


-- ************************************************
-- PART I - 2.1.3 SQL3
-- ************************************************

	-- ��������(PAY_TP)�� �ֹ��Ǽ�(�ֹ� �Ǽ��� �ֹ�������� �÷����� ǥ��) ? �ζ���-�� Ȱ��
	SELECT  T1.PAY_TP
			,MAX(CASE WHEN T1.ORD_YM = '201701' THEN T1.ORD_CNT END) ORD_CNT_1701
			,MAX(CASE WHEN T1.ORD_YM = '201702' THEN T1.ORD_CNT END) ORD_CNT_1702
			--...201703~201711�ݺ�.
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

	-- NULL�� ���� COUNT #1
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

	-- NULL�� ���� COUNT #2
	SELECT  COUNT(COL1) CNT_COL1 ,COUNT(*) CNT_ALL
	FROM    (
			SELECT  NULL COL1 FROM  DUAL UNION ALL
			SELECT  NULL COL1 FROM  DUAL
			) T1;


-- ************************************************
-- PART I - 2.1.5 SQL1
-- ************************************************

	-- �ֹ������ �ֹ��� ��(�ߺ��� �����ؼ� ī��Ʈ), �ֹ��Ǽ�
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

	-- �ֹ�����(ORD_ST)�� ��������(PAY_TP)�� ���տ� ���� ���� ��
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

	-- �ֹ�����(ORD_ST)�� ��������(PAY_TP)�� ���տ� ���� ���� �� ? �ζ���-��� �ذ�
	SELECT  COUNT(*)
	FROM    (
			SELECT  DISTINCT T1.ORD_ST ,T1.PAY_TP
			FROM    T_ORD T1
			) T2;



-- ************************************************
-- PART I - 2.1.6 SQL1
-- ************************************************

	-- ��ID, ��������(PAY_TP)�� �ֹ��ݾ��� 10,000 �̻��� �����͸� ��ȸ
	SELECT  T1.CUS_ID ,T1.PAY_TP ,SUM(T1.ORD_AMT) ORD_TTL_MT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY T1.CUS_ID ,T1.PAY_TP
	HAVING SUM(T1.ORD_AMT) >= 10000
	ORDER BY SUM(T1.ORD_AMT) ASC;



-- ************************************************
-- PART I - 2.1.6 SQL2
-- ************************************************

	-- HAVING ������ GROUP BY�� ����� �÷� �Ǵ� �����Լ��� ����� �÷��� ��� �����ϴ�.
	SELECT  T1.CUS_ID ,T1.PAY_TP ,SUM(T1.ORD_AMT) ORD_TTL_MT
	FROM    T_ORD T1
	GROUP BY T1.CUS_ID ,T1.PAY_TP
	HAVING T1.ORD_ST = 'COMP' --ERROR
	ORDER BY SUM(T1.ORD_AMT) ASC;

	-- ���� �߻�: ORA-00979: not a GROUP BY expression


-- ************************************************
-- PART I - 2.1.6 SQL3
-- ************************************************

	-- HAVING�� ��� �ζ���-�並 ���
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

	-- GROUP BY�� GROUP BY~ROLLUP�� ��
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

	-- �ֹ�����, �ֹ����, ��ID ������ ROLLUP
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

	-- �ֹ����, �ֹ�����, ��ID ������ ROLLUP(�� SQL���� ROLLUP�κи� �����ؼ� �����Ѵ�.)
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

	-- NULL�� �����ϴ� �÷��� PAY_TP�� ���� ROLLUP�� ����
	SELECT  T1.ORD_ST ,T1.PAY_TP ,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY ROLLUP(T1.ORD_ST ,T1.PAY_TP);


-- ************************************************
-- PART I - 2.2.3 SQL2
-- ************************************************

	-- NULL�� �����ϴ� �÷��� PAY_TP�� ���� ROLLUP�� ����. GROUPING�Լ� ���
	SELECT  T1.ORD_ST ,GROUPING(T1.ORD_ST) GR_ORD_ST 
			,T1.PAY_TP ,GROUPING(T1.PAY_TP) GR_PAY_TP
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY ROLLUP(T1.ORD_ST, T1.PAY_TP);



-- ************************************************
-- PART I - 2.2.3 SQL3
-- ************************************************

	-- ROLLUP�Ǵ� �÷��� Total�� ǥ��
	SELECT  CASE WHEN GROUPING(T1.ORD_ST) = 1 THEN 'Total' ELSE T1.ORD_ST END ORD_ST
			,CASE WHEN GROUPING(T1.PAY_TP) = 1 THEN 'Total' ELSE T1.PAY_TP END PAY_TP 
			,COUNT(*) ORD_CNT
	FROM    T_ORD T1
	GROUP BY ROLLUP(T1.ORD_ST ,T1.PAY_TP)
	ORDER BY T1.ORD_ST ,T1.PAY_TP;




-- ************************************************
-- PART I - 2.2.4 SQL1
-- ************************************************

	-- �ֹ����, ����ID, ����޺� �ֹ��ݾ� - ROLLUP
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

	-- �ֹ����, ����ID, ����޺� �ֹ��ݾ� ? ��ü �հ踸 ���ϱ�
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

	-- �ֹ����, ��ID�� �ֹ��ݾ� ? ROLLUP ���
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

	-- ROLLUP�� UNION ALL�� ����ϱ�
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

	-- ROLLUP�� ī�׽þ� �������� ����ϱ�
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

	-- ROLLUP�� WITH ���� UNION ALL�� ��ü
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

	-- �ֹ�����(ORD_ST), �ֹ����, ��ID�� �ֹ��ݾ� ? CUBE�� ������ ��� �Ұ踦 �߰�
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

	-- �ֹ����, ��ID�� �ֹ��Ǽ��� �ֹ� �ݾ� ? GROUPING SETS Ȱ��
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,T1.CUS_ID
			,COUNT(*) ORD_CNT
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
	AND     T1.CUS_ID IN ('CUS_0061','CUS_0062')
	GROUP BY GROUPING SETS(
					  (TO_CHAR(T1.ORD_DT,'YYYYMM'),T1.CUS_ID)  --GROUP BY�⺻ ������
					  ,(TO_CHAR(T1.ORD_DT,'YYYYMM'))  --�ֹ������ �Ұ�
					  ,(T1.CUS_ID)  --��ID�� �Ұ�
					  ,()   --��ü�հ�
				  );

