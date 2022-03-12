
-- ************************************************
-- PART III - 9.1.1 SQL1
-- ************************************************

	-- ��ȸ�� �ֹ� �Ǽ��� ������ �÷��� �߰��ϴ� SQL
	SELECT  T1.ORD_SEQ ,T1.CUS_ID ,T1.ORD_DT
			,COUNT(*) ALL_CNT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170302','YYYYMMDD');



-- ************************************************
-- PART III - 9.1.1 SQL2
-- ************************************************

	-- ��ȸ�� �ֹ� �Ǽ��� ������ �÷��� �߰��ϴ� SQL ? �м��Լ� ���
	SELECT  T1.ORD_SEQ ,T1.CUS_ID ,T1.ORD_DT
			,COUNT(*) OVER() ALL_CNT
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170302','YYYYMMDD');


-- ************************************************
-- PART III - 9.1.2 SQL1
-- ************************************************

	-- GROUP BY�� ���� SQL�� GROUP BY�� �����ϴ� SQL�� ���
	SELECT  T1.ORD_SEQ ,T1.CUS_ID
			,COUNT(*) OVER() ALL_CNT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	ORDER BY T1.ORD_SEQ;

	SELECT  T1.CUS_ID
			,COUNT(*) OVER() ALL_CNT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART III - 9.1.2 SQL2
-- ************************************************

	-- ���� SQL�� ������ �߻�, ������ SQL�� ����
	SELECT  T1.CUS_ID
			,T1.ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	GROUP BY T1.CUS_ID;
	-- ORA-00979: not a GROUP BY expression


	SELECT  T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	GROUP BY T1.CUS_ID;

-- ************************************************
-- PART III - 9.1.2 SQL3
-- ************************************************

	-- SUM() OVER()�� ����
	SELECT  T1.CUS_ID
			,SUM(T1.ORD_AMT) OVER() TTL_ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	GROUP BY T1.CUS_ID;
	-- ORA-00979: not a GROUP BY expression

	SELECT  T1.CUS_ID
			,SUM(SUM(T1.ORD_AMT)) OVER() OVER_ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART III - 9.1.2 SQL4
-- ************************************************

	-- �м��Լ��� �����Լ��� ����

	SELECT  T1.CUS_ID
			,COUNT(*) BY_CUS_ORD_CNT --�����Լ�: ���� �ֹ��Ǽ�
			,COUNT(*) OVER() ALL_CUST_CNT  --�м��Լ�: ��ȸ�� �� ��(�� ���� ���´�.)
			,SUM(COUNT(*)) OVER() ALL_ORD_CNT  -- �м��Լ�: 2�� ������ ���� �ֹ��Ǽ��� ���� ��.
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170101','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170201','YYYYMMDD')
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART III - 9.1.3 SQL1
-- ************************************************

	-- CUS_ID���� PARTITION BY�� ���
	SELECT  T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID) BY_CUST_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART III - 9.1.3 SQL2
-- ************************************************

	-- �پ��ϰ� PARTITION BY�� ���
	SELECT  T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.ORD_ST
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID) BY_CUST_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.ORD_ST) BY_ORD_ST_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID, TO_CHAR(T1.ORD_DT,'YYYYMM')) BY_CUST_YM_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.ORD_ST
	ORDER BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ,T1.ORD_ST;



-- ************************************************
-- PART III - 9.1.3 SQL3
-- ************************************************

	-- ROLLUP�� PARTITION BY�� ��
	SELECT  T1.CUS_ID
			,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY
	 ROLLUP(T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM'))
	ORDER BY T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM');

	SELECT  T1.CUS_ID
			,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) 
				OVER(PARTITION BY T1.CUS_ID) BY_CUST_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER() ALL_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM');




-- ************************************************
-- PART III - 9.1.3 SQL4
-- ************************************************

	-- ������ �ֹ��ݾ� ���� ���ϱ� ? PARTITION BY�� ���

	SELECT  T1.CUS_ID
			,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,ROUND(SUM(T1.ORD_AMT) / (SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID))
				  * 100.00,2) ORD_AMT_RT_BY_CUST
			,ROUND(SUM(T1.ORD_AMT) / (SUM(SUM(T1.ORD_AMT)) OVER()) * 100.00,2) ORD_AMT_RT_BY_ALL_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART III - 9.1.4 SQL1
-- ************************************************

	-- Ư�� ���� 3������ 8�������� 6���� ���� �ֹ� ��ȸ, ���� �����ֹ��ݾ��� ���� ǥ��
	-- ���� �ݾ�: �Ʒ� ���� ����
			-- 3���� �����ݾ��� 3�� �ֹ� �ݾװ� ����
			-- 4���� �����ݾ��� 3���� 4�� �ֹ��ݾ� �հ�
			-- ...
			-- 8���� �����ݾ��� 3~8���� �ֹ��ݾ� �հ�


	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM')) ORD_YM_SUM
	FROM    T_ORD T1
	WHERE   T1.CUS_ID = 'CUS_0002'
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170901','YYYYMMDD')
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART III - 9.1.4 SQL2
-- ************************************************

	-- Ư�� ���� �� ���� 3������ 5�������� ���� �ֹ��ݾ� ��ȸ, ���� �����ֹ��ݾ��� ���� ǥ��
	SELECT  T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID) BY_CUST_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM')) 
	BY_CUS_ORD_YM_SUM
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM');




-- ************************************************
-- PART III - 9.2.1 SQL1
-- ************************************************

	-- RANK �м��Լ�
	SELECT  T1.CUS_ID
			,SUM(T1.ORD_AMT) ORD_AMT
			,RANK() OVER(ORDER BY SUM(T1.ORD_AMT) DESC) RNK
	FROM    T_ORD T1
	GROUP BY T1.CUS_ID;



-- ************************************************
-- PART III - 9.2.1 SQL2
-- ************************************************

	-- RANK�� DENSE_RANK�� ��
	SELECT  T1.ID ,T1.AMT
			,RANK() OVER(ORDER BY T1.AMT DESC) RANK_RES
			,DENSE_RANK() OVER(ORDER BY T1.AMT DESC) DENSE_RANK_RES
	FROM    (
			SELECT  'A' ID ,300 AMT FROM DUAL UNION ALL
			SELECT  'B' ID ,150 AMT FROM DUAL UNION ALL
			SELECT  'C' ID ,150 AMT FROM DUAL UNION ALL
			SELECT  'D' ID ,100 AMT FROM DUAL 
			) T1;



-- ************************************************
-- PART III - 9.2.2 SQL1
-- ************************************************

	-- ROW_NUMBER()�� �̿��� ���� ���ϱ�
	SELECT  T1.ID ,T1.AMT
			,RANK() OVER(ORDER BY T1.AMT DESC) RANK_RES
			,ROW_NUMBER() OVER(ORDER BY T1.AMT DESC) ROW_NUM_RES
	FROM    (
			SELECT  'A' ID ,300 AMT FROM DUAL UNION ALL
			SELECT  'B' ID ,150 AMT FROM DUAL UNION ALL
			SELECT  'C' ID ,150 AMT FROM DUAL UNION ALL
			SELECT  'D' ID ,100 AMT FROM DUAL 
			) T1;


-- ************************************************
-- PART III - 9.2.2 SQL2
-- ************************************************

	-- 3��, 4�� �ֹ��� ����, ������ �ֹ��ݾ� Top-3 �� ���ϱ�
	SELECT  T0.ORD_YM ,T0.CUS_ID ,T0.ORD_AMT ,T0.BY_YM_RANK
	FROM    (
			SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,T1.CUS_ID ,SUM(T1.ORD_AMT) ORD_AMT
					,ROW_NUMBER()
						OVER(PARTITION BY TO_CHAR(T1.ORD_DT,'YYYYMM') ORDER BY SUM(T1.ORD_AMT) DESC) BY_YM_RANK
			FROM    T_ORD T1
			WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
			AND     T1.ORD_DT < TO_DATE('20170501','YYYYMMDD')
			GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
					,T1.CUS_ID
			) T0
	WHERE   T0.BY_YM_RANK <= 3
	ORDER BY T0.ORD_YM ,T0.BY_YM_RANK;




-- ************************************************
-- PART III - 9.2.2 SQL3
-- ************************************************

	-- ROW_NUMBER()�� �̿��� ������ ����
	SELECT  T2.*
	FROM    (
			SELECT  T1.*
					,ROW_NUMBER()
						OVER(PARTITION BY T1.CUS_ID ORDER BY T1.ORD_DT DESC ,T1.ORD_SEQ DESC) ORD_RNK
			FROM    T_ORD T1
			) T2
	WHERE   T2.ORD_RNK = 1;


-- ************************************************
-- PART III - 9.2.3 SQL1
-- ************************************************

	-- LEAD�� LAG�� ��� ����
	SELECT  T1.CUS_ID 
	,SUM(T1.ORD_AMT) ORD_AMT
			,ROW_NUMBER() OVER(ORDER BY SUM(T1.ORD_AMT) DESC) RNK
			,LAG(T1.CUS_ID,1) OVER(ORDER BY SUM(T1.ORD_AMT) DESC) LAG_1
			,LEAD(T1.CUS_ID,1) OVER(ORDER BY SUM(T1.ORD_AMT) DESC) LEAD_1
	FROM    T_ORD T1
	WHERE   T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170401','YYYYMMDD')
	AND     T1.CUS_ID IN ('CUS_0020','CUS_0021','CUS_0022','CUS_0023')
	GROUP BY T1.CUS_ID;


-- ************************************************
-- PART III - 9.2.3 SQL2
-- ************************************************

	-- �ֹ���� �� �ֹ��ݾ׿�, ���� �ֹ��ݾ��� ���� ǥ�� ? LAG�� Ȱ��
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,LAG(SUM(T1.ORD_AMT), 1) OVER(ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM') ASC) BF_YM_ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.ORD_ST = 'COMP'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART III - 9.3.1 SQL1
-- ************************************************

	-- Ư�� ���� �ֹ������ �ֹ��ݾ�, Ư�� ���� �� �ֹ��ݾ��� ���� ǥ��
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) YM_ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER() TTL_ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID = 'CUS_0002'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART III - 9.3.1 SQL2
-- ************************************************

	-- Ư�� ���� �� �ֹ��ݾ� ? ���������� �ذ�
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) YM_ORD_AMT
			,(SELECT  SUM(A.ORD_AMT)
			  FROM    T_ORD A
			  WHERE   A.CUS_ID = 'CUS_0002') TTL_ORD_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID = 'CUS_0002'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART III - 9.3.1 SQL3
-- ************************************************

	-- Ư�� ���� �� �ֹ��ݾ� ? �ζ���-��� �ذ�
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) YM_ORD_AMT
			,MAX(T2.TTL_ORD_AMT) TTL_ORD_AMT
	FROM    T_ORD T1
			,(
			SELECT  SUM(A.ORD_AMT) TTL_ORD_AMT
			FROM    T_ORD A
			WHERE   A.CUS_ID = 'CUS_0002'
			) T2
	WHERE   T1.CUS_ID = 'CUS_0002'
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART III - 9.3.2 SQL1
-- ************************************************

	-- ���� �� �ֹ��ݾ� ? PARTITION BY ���
	SELECT  T1.CUS_ID
			,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,SUM(SUM(T1.ORD_AMT)) OVER(PARTITION BY T1.CUS_ID) BY_USR_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART III - 9.3.2 SQL2
-- ************************************************

	-- ���� �� �ֹ��ݾ� ? ���������� �ذ�
	SELECT  T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,(  SELECT  SUM(A.ORD_AMT)
				FROM    T_ORD A
				WHERE   A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
				AND     A.ORD_DT < TO_DATE('20170601','YYYYMMDD')
				AND     A.CUS_ID = T1.CUS_ID ) BY_USR_AMT
	FROM    T_ORD T1
	WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
	AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
	AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
	GROUP BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM');



-- ************************************************
-- PART III - 9.3.2 SQL3
-- ************************************************

	-- ���� �� �ֹ��ݾ� ? �ζ���-��� �ذ�
	SELECT  T0.CUS_ID ,T0.ORD_YM ,T0.ORD_AMT ,T2.BY_USR_AMT
	FROM    (   SELECT  T1.CUS_ID ,TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM ,SUM(T1.ORD_AMT) ORD_AMT
				FROM    T_ORD T1
				WHERE   T1.CUS_ID IN ('CUS_0002','CUS_0003')
				AND     T1.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
				AND     T1.ORD_DT < TO_DATE('20170601','YYYYMMDD')
				GROUP BY T1.CUS_ID,TO_CHAR(T1.ORD_DT,'YYYYMM')
			) T0
			,(  SELECT  A.CUS_ID ,SUM(A.ORD_AMT) BY_USR_AMT
				FROM    T_ORD A
				WHERE   A.CUS_ID IN ('CUS_0002','CUS_0003')
				AND     A.ORD_DT >= TO_DATE('20170301','YYYYMMDD')
				AND     A.ORD_DT < TO_DATE('20170601','YYYYMMDD')
				GROUP BY A.CUS_ID
			) T2
	WHERE   T0.CUS_ID = T2.CUS_ID
	ORDER BY T0.CUS_ID ,T0.ORD_YM;



-- ************************************************
-- PART III - 9.3.3 SQL1
-- ************************************************

	-- �ֹ������ �ֹ��ݾ� ���� ���ϱ� ? ROW_NUMBER ���
	SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
			,SUM(T1.ORD_AMT) ORD_AMT
			,ROW_NUMBER() OVER(ORDER BY SUM(T1.ORD_AMT) DESC) ORD_AMT_RANK
	FROM    T_ORD T1
	GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
	ORDER BY TO_CHAR(T1.ORD_DT,'YYYYMM');


-- ************************************************
-- PART III - 9.3.3 SQL2
-- ************************************************

	-- �ֹ������ �ֹ��ݾ� ���� ���ϱ� ? ROWNUM���� �ذ�
	SELECT  T0.ORD_YM
			,T0.ORD_AMT
			,ROWNUM ORD_AMT_RANK
	FROM    (
			SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
					,SUM(T1.ORD_AMT) ORD_AMT
			FROM    T_ORD T1
			GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
			ORDER BY SUM(T1.ORD_AMT) DESC
			) T0
	ORDER BY T0.ORD_YM;


-- ************************************************
-- PART III - 9.3.3 SQL3
-- ************************************************

	-- �ֹ������ �ֹ��ݾ� ���� ���ϱ� ? ���������� �ذ�
	SELECT  T2.ORD_YM
			,T2.ORD_AMT
			,(  SELECT  COUNT(*)
				FROM    (SELECT  TO_CHAR(A.ORD_DT,'YYYYMM') ORD_YM
								,SUM(A.ORD_AMT) ORD_AMT
						FROM    T_ORD A
						GROUP BY TO_CHAR(A.ORD_DT,'YYYYMM')) B
				WHERE   B.ORD_AMT >= T2.ORD_AMT
			) ORD_AMT_RANK
	FROM    ( 
			SELECT  TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
					,SUM(T1.ORD_AMT) ORD_AMT
			FROM    T_ORD T1
			GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
			ORDER BY SUM(T1.ORD_AMT) DESC
			) T2
	ORDER BY T2.ORD_YM;


-- ************************************************
-- PART III - 9.3.3 SQL4
-- ************************************************

	-- �ֹ������ �ֹ��ݾ� ���� ���ϱ� ? �ζ���-��� ����-�������� �ذ�
	SELECT  T0.ORD_YM ,MAX(T0.ORD_AMT) ORD_AMT ,COUNT(*) ORD_AMT_RANK
	FROM    (SELECT TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
					,SUM(T1.ORD_AMT) ORD_AMT
			FROM    T_ORD T1
			GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
			) T0
			,(SELECT TO_CHAR(T1.ORD_DT,'YYYYMM') ORD_YM
					,SUM(T1.ORD_AMT) ORD_AMT
			FROM    T_ORD T1
			GROUP BY TO_CHAR(T1.ORD_DT,'YYYYMM')
			) T3
	WHERE   T3.ORD_AMT >= T0.ORD_AMT
	GROUP BY T0.ORD_YM
	ORDER BY T0.ORD_YM;
























