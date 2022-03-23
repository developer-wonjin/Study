-- ************************************************
-- PART III - 8.1.2 SQL1
-- ************************************************

	-- ���� ���̺� �� ���� ������ ����
	-- ���� ���̺��� ����
	CREATE TABLE M_ACC
	(
		ACC_NO VARCHAR2(40)  NOT NULL,
		ACC_NM VARCHAR2(100)  NULL,
		BAL_AMT NUMBER(18,3)  NULL 
	);

	ALTER TABLE M_ACC
		ADD CONSTRAINT  PK_M_ACC PRIMARY KEY (ACC_NO) USING INDEX;

	-- �׽�Ʈ �����͸� ����.
	INSERT INTO M_ACC(ACC_NO ,ACC_NM ,BAL_AMT)
	SELECT 'ACC1' ,'1������' ,3000 FROM DUAL UNION ALL
	SELECT 'ACC2' ,'2������' ,500 FROM DUAL UNION ALL
	SELECT 'ACC3' ,'3������' ,0 FROM DUAL;


-- ************************************************
-- PART III - 8.1.2 SQL2
-- ************************************************

	-- ������ü ? ACC1���� ACC2�� 500�� ��ü
	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT - 500
	WHERE   T1.ACC_NO = 'ACC1';

	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT + 500
	WHERE   T1.ACC_NO = 'ACC2';

	COMMIT;


-- ************************************************
-- PART III - 8.1.2 SQL3
-- ************************************************

	-- ������ü ? ACC1���� ACC4�� 500�� ��ü
	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT - 500
	WHERE   T1.ACC_NO = 'ACC1';

	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT + 500
	WHERE   T1.ACC_NO = 'ACC4';

	SELECT  * FROM M_ACC;



-- ************************************************
-- PART III - 8.1.2 SQL4
-- ************************************************

	-- ������ü ? ACC1���� ACC4�� 500�� ��ü, ROLLBACK ó��
	ROLLBACK;

	SELECT  * FROM M_ACC;


-- ************************************************
-- PART III - 8.1.2 SQL5
-- ************************************************

	-- ������ü ? �������翩�� ����
	SELECT  NVL(MAX('Y'),'N')
	FROM    DUAL T1
	WHERE   EXISTS(
			  SELECT * FROM M_ACC A WHERE A.ACC_NO = 'ACC4');
			  

		  
		  
-- ************************************************
-- PART III - 8.1.2 SQL6
-- ************************************************

	-- ������ü ? ACC1���� ACC3�� 5000�� ��ü
	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT - 5000
	WHERE   T1.ACC_NO = 'ACC1';

	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT + 5000
	WHERE   T1.ACC_NO = 'ACC3';

	SELECT  * FROM M_ACC;



-- ************************************************
-- PART III - 8.1.2 SQL7
-- ************************************************
	ROLLBACK;

	SELECT  * FROM M_ACC;



-- ************************************************
-- PART III - 8.1.2 SQL8
-- ************************************************

	-- ���ο� ���¸� INSERT
	INSERT INTO M_ACC(ACC_NO ,ACC_NM ,BAL_AMT)
	VALUES('ACC4' ,'4������' ,0);

	INSERT INTO M_ACC(ACC_NO ,ACC_NM ,BAL_AMT)
	VALUES('ACC1' ,'1������' ,0); --ACC1�� �̹� �����ϹǷ� ������ �߻��Ѵ�.

	-- ORA-00001: unique constraint (TEST.PK_M_ACC) violated

	SELECT  * FROM M_ACC;

	ROLLBACK;





-- ************************************************
-- PART III - 8.1.3 SQL1
-- ************************************************

	-- UPDATE-SELECT �׽�Ʈ ? ù ��° ���� SQL
	SELECT  * FROM M_ACC T1 WHERE T1.ACC_NO = 'ACC1'; --ACC1�� �ܾ��� 2500��

	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = 5000
	WHERE   T1.ACC_NO = 'ACC1';

	SELECT  * FROM M_ACC T1 WHERE T1.ACC_NO = 'ACC1'; --ACC1�� �ܾ� 5000��




-- ************************************************
-- PART III - 8.1.3 SQL2
-- ************************************************

	-- UPDATE-SELECT �׽�Ʈ ? �� ��° ���� SQL
	SELECT  * FROM M_ACC T1 WHERE T1.ACC_NO = 'ACC1'; --ACC1�� �ܾ��� 2500��


-- ************************************************
-- PART III - 8.1.3 SQL3
-- ************************************************

	-- UPDATE-SELECT �׽�Ʈ ? ù ��° ���� COMMIT ó��
	COMMIT;



-- ************************************************
-- PART III - 8.1.3 SQL4
-- ************************************************

	-- UPDATE ? UPDATE �׽�Ʈ ? ù ��° ���� SQL
	--���� ACC1�� �ܾ��� 5,000
	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT - 500
	WHERE   T1.ACC_NO = 'ACC1';

	SELECT  * FROM M_ACC T1 WHERE T1.ACC_NO = 'ACC1'; --ACC1�� �ܾ��� 4,500��



-- ************************************************
-- PART III - 8.1.3 SQL5
-- ************************************************

	--UPDATE ? UPDATE �׽�Ʈ ? �� ��° ���� SQL
	-- ���� ù ��° ������ UPDATE ���� COMMIT ���� �ʾ����Ƿ�
	-- �� ��° ���ǿ����� ù ��° ������ UPDATE ���� �����Ͱ� ��ȸ�ȴ�.
	SELECT  * FROM M_ACC T1 WHERE T1.ACC_NO = 'ACC1'; --ACC1�� �ܾ��� 5,000��

	-- �Ʒ� SQL�� ù ��° ���ǿ� ���� ������� ���Ѵ�.
	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT - 500
	WHERE   T1.ACC_NO = 'ACC1';

-- ************************************************
-- PART III - 8.1.3 SQL6
-- ************************************************

	-- UPDATE ? UPDATE �׽�Ʈ ? ù ��° ���� COMMIT
	COMMIT;



-- ************************************************
-- PART III - 8.1.3 SQL7
-- ************************************************

	-- UPDATE ? UPDATE �׽�Ʈ ? �� ��° ���� Ȯ��
	COMMIT;

	SELECT  * FROM M_ACC T1 WHERE T1.ACC_NO = 'ACC1'; --ACC1�� �ܾ��� 4,000��




-- ************************************************
-- PART III - 8.1.3 SQL8
-- ************************************************

	-- INSERT ? INSERT �׽�Ʈ ? ù ��° ���� ACC4 ����
	INSERT INTO M_ACC(ACC_NO, ACC_NM, BAL_AMT) VALUES('ACC4','4������',0);


-- ************************************************
-- PART III - 8.1.3 SQL9
-- ************************************************

	-- INSERT ? INSERT �׽�Ʈ ? �� ��° ���� ACC4 ����
	INSERT INTO M_ACC(ACC_NO, ACC_NM, BAL_AMT) VALUES('ACC4','4������',0);


-- ************************************************
-- PART III - 8.1.3 SQL10
-- ************************************************

	-- INSERT ? INSERT �׽�Ʈ ? ù ��° ���� COMMIT
	COMMIT;


-- ************************************************
-- PART III - 8.1.3 SQL11
-- ************************************************

	-- INSERT ? INSERT �׽�Ʈ ? ù ��° ���� ACC5 ����
	INSERT INTO M_ACC(ACC_NO, ACC_NM, BAL_AMT) VALUES('ACC5','5������',0);


-- ************************************************
-- PART III - 8.1.3 SQL12
-- ************************************************

	-- INSERT ? INSERT �׽�Ʈ ? �� ��° ���� ACC6 ����
	INSERT INTO M_ACC(ACC_NO, ACC_NM, BAL_AMT) VALUES('ACC6','6������',0);


-- ************************************************
-- PART III - 8.1.3 SQL13
-- ************************************************

	-- INSERT ? INSERT �׽�Ʈ ? �� ��° ���� ACC5 ����
	INSERT INTO M_ACC(ACC_NO ,ACC_NM ,BAL_AMT) VALUES('ACC5' ,'5������' ,0);



-- ************************************************
-- PART III - 8.1.3	 SQL14
-- ************************************************
	-- INSERT ? INSERT �׽�Ʈ ? ù ��° ���� COMMIT
	COMMIT;




-- ************************************************
-- PART III - 8.2.2 SQL1
-- ************************************************

	-- ���ÿ� �� ���� ������ ACC1�� �ܾ׿��� 4,000������ ����Ϸ��� �Ѵ�.
	--ù ��° ����
	--1.ACC1���� 4,000���� ����Ϸ��� �Ѵ�.
	SELECT T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO = 'ACC1'; --4,000���� ��ȸ�ȴ�.

			--�� ��° ����
			--2.ACC1���� 4,000���� ����Ϸ��� �Ѵ�.
			SELECT T1.BAL_AMT FROM M_ACC T1
			WHERE T1.ACC_NO = 'ACC1'; --4,000���� ��ȸ�ȴ�.

	--ù ��° ����
	--IF BAL_AMT >= 4,000 THEN UPDATE
	--3.�ܾ��� 4,000���� �����Ƿ� 4,000���� ���ó��.
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 4000 
	WHERE T1.ACC_NO = 'ACC1';


	--ù ��° ����
	--4.�ܾ��� 0���� �Ǿ� �ִ�.
	SELECT T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO = 'ACC1';
		
			--�� ��° ����
			--IF BAL_AMT >= 4,000 THEN UPDATE
			--5.�ܾ��� 4,000���� �����Ƿ� 4,000���� ���ó��.
			--ù ��° ���ǿ� ���� ��� ���¿� ������.
			UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 4000
			WHERE T1.ACC_NO = 'ACC1';

	--ù ��° ����
	--6.COMMITó��.
	COMMIT;

			--�� ��° ����
			--7. �ܾ��� ���̳ʽ� 4,000���� �Ǿ� �ִ�.
			SELECT T1.BAL_AMT FROM M_ACC T1
			WHERE T1.ACC_NO = 'ACC1';
			
			--�� ��° ����
			--8. COMMITó��
			COMMIT;







-- ************************************************
-- PART III - 8.2.2 SQL2
-- ************************************************

	-- ACC1�� �ܾ��� 4,000������ ����
	UPDATE M_ACC SET BAL_AMT = 4000 WHERE ACC_NO = 'ACC1';

	COMMIT;



-- ************************************************
-- PART III - 8.2.2 SQL3
-- ************************************************


	--���ÿ� �� ���� ������ ACC1�� ���¿��� 4,000������ ����Ϸ��� �Ѵ�. ? SELECT ~ FOR UPDATE���.

	-- ù ��° ����
	--1. ACC1���� 4,000���� ����Ϸ��� �Ѵ�.
	SELECT T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO = 'ACC1'
	FOR UPDATE; --4,000���� ��ȸ�ȴ�.

			--�� ��° ����
			--2. ACC1���� 4,000���� ����Ϸ��� �Ѵ�.
			SELECT T1.BAL_AMT FROM M_ACC T1
			WHERE T1.ACC_NO = 'ACC1'
			FOR UPDATE;
			-- ��� ���¿� �����ٰ� ù ��° ������ COMMIT�� ��
			-- 0���� ��ȸ�ȴ�.

	-- ù ��° ����
	--3. �ܾ��� 4,000���� �����Ƿ� 4,000���� ���ó��.
	-- IF BAL_AMT >= 4,000 THEN UPDATE
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 4000 
	WHERE T1.ACC_NO = 'ACC1';


	-- ù ��° ����
	--4. �ܾ��� 0���� �Ǿ� �ִ�.
	SELECT T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO = 'ACC1';


	-- ù ��° ����
	--5. COMMITó��.
	COMMIT;
			


			--�� ��° ����
			-- IF BAL_AMT >= 4,000 THEN UPDATE
			-- �ܾ��� 4,000���� �����Ƿ� ��� �Ұ�.

			--�� ��° ����
			ROLLBACK;

		
		
-- ************************************************
-- PART III - 8.2.3 SQL1
-- ************************************************

	-- ������ȸ ���μ���
	SELECT  T1.* FROM M_ACC T1 FOR UPDATE;



-- ************************************************
-- PART III - 8.2.4 SQL1
-- ************************************************

	-- ACC1, ACC2�� �ܾ� �ʱ�ȭ
	UPDATE M_ACC SET BAL_AMT = 5000 WHERE ACC_NO IN ('ACC1','ACC2');
	COMMIT;





-- ************************************************
-- PART III - 8.2.4 SQL2
-- ************************************************

	-- ����� �׽�Ʈ ? �� ���� ���ǿ��� ������ü ����
	--ù ��° ����, ACC1->ACC2 2,000�� ��ü
	--1.ACC1�� �ܾ� Ȯ��
	SELECT T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO = 'ACC1' FOR UPDATE;

	--ù ��° ����
	--2.ACC1���� �ܾ� ���̳ʽ�
	--(�ܾ��� ��ü�ݾ� �̻��̸� ��ü ����)
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 2000 
	WHERE T1.ACC_NO = 'ACC1';


			--�� ��° ����, ACC2->ACC1 3,000�� ��ü
			--�� ��° ����
			--3.ACC2�� �ܾ� Ȯ��
			SELECT T1.BAL_AMT FROM M_ACC T1
			WHERE T1.ACC_NO = 'ACC2' FOR UPDATE;


			--�� ��° ����
			--4. ACC2���� �ܾ� ���̳ʽ�
			--IF BAL_AMT >= 3,000 THEN UPDATE
			UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 3000 
			WHERE T1.ACC_NO = 'ACC2';
			
			
	--ù ��° ����
	--5. ACC2�� �ܾ� �÷���
	--�� ��° ���� 3��,4�� SQL�� ���� ��⿡ ������.
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT + 2000 
	WHERE T1.ACC_NO = 'ACC2';


			--�� ��° ����
			--6.ACC1�� �ܾ� �÷���
			--ù ��° ���� 1��,5�� SQL�� ���� ��⿡ ������.
			UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT + 3000 
			WHERE T1.ACC_NO = 'ACC1';
			
			
	--ù ��° ����
	--7. �ణ�� �ð� �Ŀ� �Ʒ��� ���� ������� �߻�
	-- SQL ����: ORA-00060: deadlock detected while waiting for resource


	--ù ��° ����
	-- 8. ������� �������Ƿ� ROLLBACKó���Ѵ�.
	ROLLBACK;


			--�� ��° ����
			-- 9. �� ��° ���ǵ� ROLLBACKó���Ѵ�.
			ROLLBACK;




-- ************************************************
-- PART III - 8.2.4 SQL3
-- ************************************************

	-- ����� ���ϱ� ? �� ���� ���ǿ��� ������ü ����
	-- ù ��° ����, ACC1->ACC2 2,000�� ��ü
	-- 1.ACC1, ACC2�� �ܾ� Ȯ��
	SELECT T1.ACC_NO ,T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO IN ('ACC1','ACC2') FOR UPDATE;

	-- ù ��° ����
	-- 2.ACC1���� �ܾ� ���̳ʽ�
	-- (�ܾ��� ��ü�ݾ� �̻��̸� ��ü ����)
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 2000 
	WHERE T1.ACC_NO = 'ACC1';


			-- �� ��° ����, ACC2->ACC1 3,000�� ��ü

			-- �� ��° ����
			-- 3.ACC1, ACC2�� �ܾ� Ȯ��
			-- ù ��° ���� 1�� SQL�� ���� ��� ���¿� ������.
			SELECT T1.ACC_NO ,T1.BAL_AMT FROM M_ACC T1
			WHERE T1.ACC_NO IN ('ACC2','ACC1') FOR UPDATE;
			
			
	-- ù ��° ����
	-- 4. ACC2�� �ܾ� �÷���
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT + 2000 
	WHERE T1.ACC_NO = 'ACC2';

	-- ù ��° ����
	COMMIT;


			-- �� ��° ����
			-- 5. ACC2���� �ܾ� ���̳ʽ�
			-- IF BAL_AMT >= 3,000 THEN UPDATE
			UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 3000 
			WHERE T1.ACC_NO = 'ACC2';

			-- �� ��° ����
			-- 6.ACC1�� �ܾ� �÷���
			UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT + 3000 
			WHERE T1.ACC_NO = 'ACC1';
			
			-- �� ��° ����
			COMMIT;




-- ************************************************
-- PART III - 8.2.5 SQL1
-- ************************************************

	-- ACC1->ACC2 2,000�� ������ü Ʈ����� SQL
	-- 1.ACC1, ACC2�� �ܾ� Ȯ��
	SELECT T1.ACC_NO ,T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO IN ('ACC1','ACC2') FOR UPDATE;

	-- 2.ACC1�� �ܾ��� ��ü�ݾ� �̻��̸� ��ü ����
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT - 2000 
	WHERE T1.ACC_NO = 'ACC1';

	-- 3. ACC2�� �ܾ� �÷���
	UPDATE M_ACC T1 SET T1.BAL_AMT = T1.BAL_AMT + 2000 
	WHERE T1.ACC_NO = 'ACC2';
	COMMIT;



-- ************************************************
-- PART III - 8.2.5 SQL2
-- ************************************************

	-- ACC1->ACC2 2,000�� ������ü Ʈ����� SQL
	-- 1.ACC1, ACC2�� �ܾ� Ȯ��
	SELECT T1.ACC_NO ,T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO IN ('ACC1','ACC2') FOR UPDATE;

	-- 2.ACC1�� BAL_AMT�� ��ü �ݾ׺��� ������ ROLLBACKó��(�ܾ��� �����մϴ�.)

	-- 3.ACC2�� �������� �ʴ´ٸ� ROLLBACKó��(���� ���°� �������� �ʽ��ϴ�.)

	-- 4.ACC1�� ACC2�� �ܾ��� ���ÿ� ó��
	UPDATE M_ACC T1 
	SET     T1.BAL_AMT = T1.BAL_AMT +
				   CASE  WHEN T1.ACC_NO = 'ACC1' THEN -1 * 2000
						 WHEN T1.ACC_NO = 'ACC2' THEN 1 * 2000 END
	WHERE T1.ACC_NO IN ('ACC1','ACC2');
	COMMIT;


-- ************************************************
-- PART III - 8.2.5 SQL3
-- ************************************************

	-- ACC1->ACC2 2,000�� ������ü Ʈ����� SQL ? �� �������� ó��
	UPDATE  M_ACC T1
	SET     T1.BAL_AMT = T1.BAL_AMT +
							CASE  WHEN T1.ACC_NO = 'ACC1' THEN -1 * 2000
								  WHEN T1.ACC_NO = 'ACC2' THEN 1 * 2000 END
	WHERE   T1.ACC_NO IN ('ACC1','ACC2')
	AND     T1.BAL_AMT >= CASE WHEN   T1.ACC_NO = 'ACC1' THEN 2000
								WHEN T1.ACC_NO = 'ACC2' THEN 0 END;

	-- UPDATE�� �Ǽ��� �� ���̸� COMMIT.
	-- UPDATE�� �Ǽ��� �� ���� �ƴϸ� ROLLBACK
	COMMIT;




-- ************************************************
-- PART III - 8.2.6 SQL1
-- ************************************************
	UPDATE  M_ACC T1 SET T1.BAL_AMT = 3000;
	COMMIT;

-- ************************************************
-- PART III - 8.2.6 SQL2
-- ************************************************
	-- 1.ACC1, ACC2�� �ܾ� Ȯ��(ACC1�� ACC2 ��� 3000���� ��ȸ�ȴ�.)
	-- ACC1�� �ܾ��� @FROM_BAL_AMT��, ACC2�� �ܾ��� @TO_BAL_AMT�� �����Ѵ�.
	SELECT T1.ACC_NO ,T1.BAL_AMT FROM M_ACC T1
	WHERE T1.ACC_NO IN ('ACC1','ACC2'); -- SELECT~FOR UPDATE�� ������� �ʴ´�.

	-- 2.ACC1�� BAL_AMT�� ��ü �ݾ׺��� ������ ROLLBACKó��(�ܾ��� �����մϴ�.)

	-- 3.ACC2�� �������� �ʴ´ٸ� ROLLBACKó��(���� ���°� �������� �ʽ��ϴ�.)

	-- 4.ACC1�� ACC2�� �ܾ��� ���ÿ� ó��
	UPDATE  M_ACC T1 
	SET     T1.BAL_AMT = T1.BAL_AMT +
				   CASE  WHEN T1.ACC_NO = 'ACC1' THEN -1 * 2000
						 WHEN T1.ACC_NO = 'ACC2' THEN 1 * 2000 END
	WHERE   T1.ACC_NO IN ('ACC1','ACC2')
	AND     T1.BAL_AMT = CASE WHEN T1.ACC_NO = 'ACC1' THEN 3000 --@FROM_BAL_AMT ���� ���
							  WHEN T1.ACC_NO = 'ACC2' THEN 3000 --@TO_BAL_AMT  ���� ���
							  END
	;

	-- 5. UPDATE�� �Ǽ��� 2�� �϶��� COMMITó��.
	COMMIT;



-- ************************************************
-- PART III - 8.3.1 SQL1
-- ************************************************

	-- ���ſ���(T_PO)���̺� ����
	CREATE TABLE T_PO
	(	
		PO_NO                 VARCHAR2(40)  NOT NULL,
		TIT                   VARCHAR2(100) NULL,
		SUP_ID                VARCHAR2(40)  NULL,
		PO_ST                 VARCHAR2(40)  NULL,
		REQ_DT                DATE  NULL,
		REQ_UID               VARCHAR2(40)  NULL,
		CNF_DT                DATE  NULL,
		CNF_UID               VARCHAR2(40)  NULL,
		CMP_DT                DATE  NULL,
		CMP_UID               VARCHAR2(40)  NULL 
	);

	CREATE UNIQUE INDEX PK_T_PO ON T_PO (PO_NO);

	ALTER TABLE T_PO
		ADD CONSTRAINT  PK_T_PO PRIMARY KEY (PO_NO) USING INDEX;

		

-- ************************************************
-- PART III - 8.3.1 SQL2
-- ************************************************

	-- PO + YYYYMMDD + NNNNNNNN ���� ä�� SQL
	DECLARE
		v_NEW_PO_NO VARCHAR2(40);
		v_REQ_DT DATE;
		v_REQ_YMD VARCHAR2(8);
	BEGIN
		v_REQ_DT := TO_DATE('20170301 23:59:59','YYYYMMDD HH24:MI:SS');
		v_REQ_YMD := TO_CHAR(v_REQ_DT,'YYYYMMDD'); -- �Է¹��� v_REQ_DT�� v_REQ_YMD�� ��ȯ
			
		SELECT 'PO' || v_REQ_YMD || 
				LPAD(
					TO_CHAR(
						TO_NUMBER(
							  NVL(SUBSTR(
								  MAX(T1.PO_NO)
							  ,-8),'0')
						) + 1
					)
				,8,'0')
		INTO    v_NEW_PO_NO
		FROM    T_PO T1
		WHERE   T1.REQ_DT >= TO_DATE(v_REQ_YMD,'YYYYMMDD')
		AND     T1.REQ_DT < TO_DATE(v_REQ_YMD,'YYYYMMDD') + 1
		;
		
		INSERT INTO T_PO (PO_NO ,TIT ,REQ_DT ,REQ_UID)
		VALUES (v_NEW_PO_NO ,'TEST_'||v_NEW_PO_NO ,v_REQ_DT ,'TEST');

		COMMIT;
	END;



-- ************************************************
-- PART III - 8.3.2 SQL1
-- ************************************************

	-- �鸸 ���� PO �����͸� ����
	TRUNCATE TABLE T_PO;

	INSERT INTO T_PO
			(PO_NO ,TIT ,REQ_DT ,REQ_UID)
	SELECT  'PO'||T2.REQ_YMD||LPAD(TO_CHAR(T1.RNO),8,'0') PO_NO
			,'TEST PO' TIT
			,TO_DATE(T2.REQ_YMD,'YYYYMMDD') REQ_DT
			,'TEST' REQ_UID
	FROM    (SELECT ROWNUM RNO FROM DUAL CONNECT BY ROWNUM <= 10000) T1 --�Ϸ翡 �� ���� PO ������ ����.
			,(
			  SELECT TO_CHAR(TO_DATE('20170101','YYYYMMDD') + (ROWNUM -1 ),'YYYYMMDD') REQ_YMD
			  FROM DUAL A
			  CONNECT BY ROWNUM <= 100 --100�ϰ��� �����͸� ����.
			) T2;
			
	COMMIT;



-- ************************************************
-- PART III - 8.3.2 SQL2
-- ************************************************

	-- SELECT~MAX�� ���� ����
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			MAX(T1.PO_NO)
	FROM    T_PO T1
	WHERE   T1.REQ_DT >= TO_DATE('20170302','YYYYMMDD')
	AND     T1.REQ_DT < TO_DATE('20170302','YYYYMMDD') + 1;






-- ************************************************
-- PART III - 8.3.2 SQL3
-- ************************************************

	-- SELECT~MAX�� ���� ���� ? �ε��� �߰�
	CREATE INDEX X_T_PO_1 ON T_PO(REQ_DT, PO_NO);

	SELECT  /*+ GATHER_PLAN_STATISTICS */
			MAX(T1.PO_NO)
	FROM    T_PO T1
	WHERE   T1.REQ_DT >= TO_DATE('20170302','YYYYMMDD')
	AND     T1.REQ_DT < TO_DATE('20170302','YYYYMMDD') + 1;



-- ************************************************
-- PART III - 8.3.2 SQL4
-- ************************************************

	-- REQ_YMD, PO_NO���� �ε��� �߰�
	ALTER TABLE T_PO ADD REQ_YMD VARCHAR(8);

	UPDATE  T_PO
	SET     REQ_YMD = TO_CHAR(REQ_DT,'YYYYMMDD')
	;
	COMMIT;

	CREATE INDEX X_T_PO_2 ON T_PO(REQ_YMD, PO_NO);



-- ************************************************
-- PART III - 8.3.2 SQL5
-- ************************************************

	-- SELECT~MAX�� ���� ���� ? REQ_YMD�÷� ���
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			MAX(T1.PO_NO)
	FROM    T_PO T1
	WHERE   T1.REQ_YMD = '20170302';





-- ************************************************
-- PART III - 8.3.2 SQL6
-- ************************************************

	-- SELECT~MAX�� ���� ���� ? PO_NO�÷��� Ȱ��
	SELECT  /*+ GATHER_PLAN_STATISTICS */
			MAX(T1.PO_NO)
	FROM    T_PO T1
	WHERE   T1.PO_NO >= 'PO'||'20170302'
	AND     T1.PO_NO < 'PO'||TO_CHAR(TO_DATE('20170302','YYYYMMDD')+1,'YYYYMMDD');




-- ************************************************
-- PART III - 8.3.3 SQL1
-- ************************************************

	-- ���ÿ� �� ���� ���ǿ��� ä���� INSERT �۾��� ����
	--ù ��° ����
	--1.ä���� ����(PO2017030200010001�� ��ȸ�ȴ�.)
	SELECT  'PO' || '20170302' || 
			LPAD(TO_CHAR(TO_NUMBER(
			  NVL(SUBSTR(MAX(T1.PO_NO),-8),'0')) + 1
			  ),8,'0')
	FROM    T_PO T1
	WHERE   T1.PO_NO >= 'PO'||'20170302'
	AND     T1.PO_NO < 
		  'PO'||TO_CHAR(TO_DATE('20170302','YYYYMMDD')+1
				  ,'YYYYMMDD');

	--ù ��° ����
	--2.ä���� ��ȣ�� �̿� INSERTó��.
	INSERT INTO T_PO (PO_NO ,TIT ,REQ_DT ,REQ_UID)
	VALUES('PO2017030200010001','TEST',
	TO_DATE('20170302','YYYYMMDD'),'TEST');

			--�� ��° ����
			--3.ä���� ����(PO2017030200010001�� ��ȸ�ȴ�.)
			--ù ��° ���ǰ� ���� ��ȣ�� ä���ȴ�.
			SELECT  'PO' || '20170302' || 
					LPAD(TO_CHAR(TO_NUMBER(
					  NVL(SUBSTR(MAX(T1.PO_NO),-8),'0')) + 1
					  ),8,'0')
			FROM    T_PO T1
			WHERE   T1.PO_NO >= 'PO'||'20170302'
			AND     T1.PO_NO < 
				'PO'||TO_CHAR(TO_DATE('20170302','YYYYMMDD')+1
						  ,'YYYYMMDD');

			--�� ��° ����
			--4.ä���� ��ȣ�� �̿� INSERTó��.
			--'PO2017030200010001'�� ù ��° ���ǿ��� �̹�
			--INSERT���̹Ƿ� ��� ���¿� ������.
			--ù ��° ������ COMMITó���ϸ� �ߺ� ������ �߻�.
			INSERT INTO T_PO (PO_NO ,TIT ,REQ_DT ,REQ_UID)
			VALUES('PO2017030200010001','TEST',
			TO_DATE('20170302','YYYYMMDD'),'TEST');



	--ù ��° ����
	--5.COMMITó��.
	COMMIT;
			
			--�� ��° ����
			--6.������ �߻������Ƿ� ROLLBACK�Ѵ�.
			ROLLBACK;



-- ************************************************
-- PART III - 8.3.4 SQL1
-- ************************************************

	-- ���ſ���(T_PO)���̺� ����
	TRUNCATE TABLE T_PO;


-- ************************************************
-- PART III - 8.3.4 SQL2
-- ************************************************

	-- ���ſ���ä��(T_PO_NUM)���̺� ����
	CREATE TABLE T_PO_NUM
	(   
		BAS_YMD VARCHAR(8) NOT NULL,
		LST_PO_NO VARCHAR2(40)  NOT NULL
	);

	CREATE UNIQUE INDEX PK_T_PO_NUM ON T_PO_NUM (BAS_YMD);

	ALTER TABLE T_PO_NUM
		ADD CONSTRAINT PK_T_PO_NUM PRIMARY KEY (BAS_YMD) USING INDEX;

	

-- ************************************************
-- PART III - 8.3.4 SQL3
-- ************************************************

	-- ���ſ���ä��(T_PO_NUM)���̺��� �̿��� ä��
	DECLARE
		v_NEW_PO_NO VARCHAR2(40);
		v_REQ_DT DATE;
		v_REQ_YMD VARCHAR2(8);
	BEGIN
		v_REQ_DT := TO_DATE('20170301 23:59:59','YYYYMMDD HH24:MI:SS');
		v_REQ_YMD := TO_CHAR(v_REQ_DT,'YYYYMMDD'); -- �Է¹��� v_REQ_DT�� v_REQ_YMD�� ��ȯ
			
		MERGE INTO T_PO_NUM T1
		USING (
			  SELECT  'PO' || v_REQ_YMD || 
							LPAD(TO_CHAR(
							  TO_NUMBER(
								NVL(SUBSTR(MAX(A.LST_PO_NO),-8),'0')) 
							  + 1
							),8,'0') NEW_PO_NO
			  FROM    T_PO_NUM A
			  WHERE   A.BAS_YMD = v_REQ_YMD
			  ) T2
			  ON (T1.BAS_YMD = v_REQ_YMD)
		WHEN MATCHED THEN UPDATE SET T1.LST_PO_NO = T2.NEW_PO_NO
		WHEN NOT MATCHED THEN INSERT (BAS_YMD ,LST_PO_NO)
							VALUES(v_REQ_YMD ,T2.NEW_PO_NO)
		;
		
		SELECT  T1.LST_PO_NO
		INTO    v_NEW_PO_NO
		FROM    T_PO_NUM T1
		WHERE   T1.BAS_YMD = v_REQ_YMD;
			
		INSERT INTO T_PO (PO_NO ,TIT ,REQ_DT ,REQ_UID)
		VALUES (v_NEW_PO_NO ,'TEST_'||v_NEW_PO_NO ,v_REQ_DT ,'TEST');
			
		COMMIT;
	END;





-- ************************************************
-- PART III - 8.3.5 SQL1
-- ************************************************

	-- ä���Լ�
	CREATE OR REPLACE FUNCTION UFN_GET_PO_NO
	(    v_BAS_YMD IN VARCHAR2
	)
	RETURN VARCHAR2 IS PRAGMA AUTONOMOUS_TRANSACTION;
		v_NEW_PO_NO VARCHAR2(40);
	BEGIN
		--ä�� ����.
		UPDATE  T_PO_NUM T1
		SET     T1.LST_PO_NO = 'PO' || v_BAS_YMD || 
					LPAD(TO_CHAR(TO_NUMBER(
							NVL(SUBSTR(T1.LST_PO_NO,-8),'0')
				) + 1),8,'0') 
		WHERE   T1.BAS_YMD = v_BAS_YMD;
		
		--������Ʈ �����Ͱ� ������, ���� ä���̹Ƿ� INSERT����.
		IF SQL%ROWCOUNT=0 THEN
			INSERT INTO T_PO_NUM (BAS_YMD, LST_PO_NO) VALUES  (v_BAS_YMD, 'PO'||v_BAS_YMD||'00000001');
		END IF;
		
		--ä���� GET
		SELECT  T1.LST_PO_NO
		INTO    v_NEW_PO_NO
		FROM    T_PO_NUM T1
		WHERE   T1.BAS_YMD = v_BAS_YMD;
		
			
		COMMIT; --Ʈ����� COMMITó��.
		
		RETURN v_NEW_PO_NO;
		
	END;

-- ************************************************
-- PART III - 8.3.5 SQL2
-- ************************************************

	-- ä���Լ��� ����� ä��
	DECLARE
		v_NEW_PO_NO VARCHAR2(40);
		v_REQ_DT DATE;
		v_REQ_YMD VARCHAR2(8);
	BEGIN
		v_REQ_DT := TO_DATE('20170305 23:59:59','YYYYMMDD HH24:MI:SS');
		v_REQ_YMD := TO_CHAR(v_REQ_DT,'YYYYMMDD'); -- �Է¹��� v_REQ_DT�� v_REQ_YMD�� ��ȯ
		
		v_NEW_PO_NO := UFN_GET_PO_NO(v_REQ_YMD);
		
		INSERT INTO T_PO (PO_NO ,TIT ,REQ_DT ,REQ_UID)
		VALUES (v_NEW_PO_NO ,'TEST_'||v_NEW_PO_NO ,v_REQ_DT ,'TEST');
			
		COMMIT;
	END;




-- ************************************************
-- PART III - 8.3.5 SQL3
-- ************************************************

	-- ����ä�� ���̺� ����
	CREATE TABLE M_NUM
	(   
		NUM_TP VARCHAR2(40) NOT NULL,
		BAS_YMD VARCHAR(8) NOT NULL,
		LST_NO VARCHAR2(40)  NOT NULL
	);

	CREATE UNIQUE INDEX PK_M_NUM ON M_NUM(NUM_TP, BAS_YMD);

	ALTER TABLE M_NUM
		ADD CONSTRAINT  PK_M_NUM PRIMARY KEY (NUM_TP, BAS_YMD) USING INDEX;


	
-- ************************************************
-- PART III - 8.3.5 SQL4
-- ************************************************

	-- ���յ� ������ ä���Լ�
	CREATE OR REPLACE FUNCTION UFN_GET_NUM
	(    v_NUM_TP IN VARCHAR2
		,v_BAS_YMD IN VARCHAR2 )
	RETURN VARCHAR2 IS PRAGMA AUTONOMOUS_TRANSACTION;
		v_NEW_NO VARCHAR2(40);
		v_PREFIX VARCHAR2(40);
		v_LENGTH INT;
	BEGIN
		SELECT  CASE  WHEN v_NUM_TP = 'PO' THEN 'PO'
					  WHEN v_NUM_TP = 'SO' THEN 'SO'
					  WHEN v_NUM_TP = 'CS' THEN 'CS'
				END
				,CASE WHEN v_NUM_TP = 'PO' THEN 8
					  WHEN v_NUM_TP = 'SO' THEN 8
					  WHEN v_NUM_TP = 'CS' THEN 4
				END
		INTO    v_PREFIX
				,v_LENGTH
		FROM    DUAL;

		--ä�� ����.
		UPDATE  M_NUM T1
		SET     T1.LST_NO = v_PREFIX || v_BAS_YMD || 
					LPAD(TO_CHAR(TO_NUMBER(
							NVL(SUBSTR(T1.LST_NO,(-1*v_LENGTH)),'0')
				) + 1),v_LENGTH,'0') 
		WHERE   T1.NUM_TP = v_NUM_TP
		AND     T1.BAS_YMD = v_BAS_YMD;
		
		--������Ʈ �����Ͱ� ������, ���� ä���̹Ƿ� INSERT����.
		IF SQL%ROWCOUNT=0 THEN
			INSERT INTO M_NUM (NUM_TP ,BAS_YMD ,LST_NO)
			VALUES  (v_NUM_TP ,v_BAS_YMD ,v_PREFIX||v_BAS_YMD||LPAD('1',v_LENGTH,'0'));
		END IF;
		
		--ä���� GET(ä�� �������� ������ ���)
		SELECT  T1.LST_NO
		INTO    v_NEW_NO
		FROM    M_NUM T1
		WHERE   T1.NUM_TP = v_NUM_TP
		AND     T1.BAS_YMD = v_BAS_YMD;
		
		COMMIT; --Ʈ����� COMMITó��.
		
		RETURN v_NEW_NO;
	END;





-- ************************************************
-- PART III - 8.3.5 SQL5
-- ************************************************

	-- ���� ä���Լ� ���
	SELECT  UFN_GET_NUM('PO','20170501') PO_NO
			,UFN_GET_NUM('SO','20170501') SO_NO
			,UFN_GET_NUM('CS','20170501') CS_ID
	FROM    DUAL;




-- ************************************************
-- PART III - 8.4.1 SQL1
-- ************************************************

	-- ������ü ���̺� ����
	CREATE TABLE T_ACC_TRN
	(
		ACC_TRN_SEQ           NUMBER(18)  NOT NULL,
		FR_ACC_NO             VARCHAR2(40)  NULL,
		TO_ACC_NO             VARCHAR2(40)  NULL,
		TRN_AMT               NUMBER(18,3)  NULL,
		TRN_HND_ST            VARCHAR2(40)  NULL,
		TRN_ERR_CD            VARCHAR2(40)  NULL,
		TRN_REQ_DT            TIMESTAMP  NULL,
		TRN_CMP_DT            TIMESTAMP  NULL 
	);

	ALTER TABLE T_ACC_TRN 
		ADD CONSTRAINT T_ACC_TRN PRIMARY KEY (ACC_TRN_SEQ) USING INDEX;

	ALTER TABLE T_ACC_TRN
		ADD (CONSTRAINT  FK_T_ACC_TRN_1 FOREIGN KEY (FR_ACC_NO) REFERENCES M_ACC(ACC_NO));

	ALTER TABLE T_ACC_TRN
		ADD (CONSTRAINT  FK_T_ACC_TRN_2 FOREIGN KEY (TO_ACC_NO) REFERENCES M_ACC(ACC_NO));



-- ************************************************
-- PART III - 8.4.1 SQL2
-- ************************************************

	-- ������ü ������ ����
	CREATE SEQUENCE SQ_T_ACC_TRN
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 99999999999999999999999999
	NOCYCLE
	CACHE 20
	NOORDER;



-- ************************************************
-- PART III - 8.4.1 SQL3
-- ************************************************

	-- �������� �̿��� ������ü ó��
	DECLARE
	  v_NEW_ACC_TRN_SEQ NUMBER(18);
	BEGIN
	  
	  v_NEW_ACC_TRN_SEQ := SQ_T_ACC_TRN.NEXTVAL();
	  
	  INSERT INTO T_ACC_TRN
			(ACC_TRN_SEQ ,FR_ACC_NO ,TO_ACC_NO ,TRN_AMT ,TRN_HND_ST ,TRN_ERR_CD ,TRN_REQ_DT ,TRN_CMP_DT)
	  VALUES(v_NEW_ACC_TRN_SEQ ,'ACC1' ,'ACC3' ,500 ,'REQ' ,NULL ,SYSDATE ,NULL);

	  COMMIT;
	END;



-- ************************************************
-- PART III - 8.4.2 SQL1
-- ************************************************

	-- �������� �̿��� ������ü ó�� ? �߸��� ���
	DECLARE
	  v_NEW_ACC_TRN_SEQ NUMBER(18);
	BEGIN
	  
	  INSERT INTO T_ACC_TRN
			(ACC_TRN_SEQ ,FR_ACC_NO ,TO_ACC_NO ,TRN_AMT ,TRN_HND_ST ,TRN_ERR_CD ,TRN_REQ_DT ,TRN_CMP_DT)
	  VALUES(SQ_T_ACC_TRN.NEXTVAL ,'ACC1' ,'ACC3' ,500 ,'REQ' ,NULL ,SYSDATE ,NULL);

	  SELECT  MAX(ACC_TRN_SEQ)
	  INTO    v_NEW_ACC_TRN_SEQ
	  FROM    T_ACC_TRN;
	  
	  COMMIT;
	END;



-- ************************************************
-- PART III - 8.4.2 SQL2
-- ************************************************

	-- �������� �̿��� ������ü ó�� ? CURRVAL �̿�
	DECLARE
	  v_NEW_ACC_TRN_SEQ NUMBER(18);
	BEGIN
	  
	  INSERT INTO T_ACC_TRN
			(ACC_TRN_SEQ ,FR_ACC_NO ,TO_ACC_NO ,TRN_AMT ,TRN_HND_ST ,TRN_ERR_CD ,TRN_REQ_DT ,TRN_CMP_DT)
	  VALUES(SQ_T_ACC_TRN.NEXTVAL ,'ACC1' ,'ACC3' ,500 ,'REQ' ,NULL ,SYSDATE ,NULL);

	  v_NEW_ACC_TRN_SEQ := SQ_T_ACC_TRN.CURRVAL();
	  
	  DBMS_OUTPUT.PUT_LINE('NEW SEQ:'||TO_CHAR(v_NEW_ACC_TRN_SEQ));
	  
	  COMMIT;
	END;


-- ************************************************
-- PART III - 8.4.3 SQL1
-- ************************************************

	-- T_CUS_LGN ���̺� ���� �� �׽�Ʈ ������ �Է�
	CREATE TABLE T_CUS_LGN
	(   
		CUS_ID VARCHAR2(40) NOT NULL,
		LGN_DT DATE NOT NULL,
		SUC_YN VARCHAR2(40) NULL,
		LGN_FAL_CD VARCHAR2(40) NULL
	);

	CREATE UNIQUE INDEX PK_T_CUS_LGN ON T_CUS_LGN(CUS_ID, LGN_DT);

	ALTER TABLE T_CUS_LGN 
		ADD CONSTRAINT PK_T_CUS_LGN PRIMARY KEY(CUS_ID, LGN_DT) USING INDEX;
	
	
	INSERT INTO T_CUS_LGN (CUS_ID ,LGN_DT ,SUC_YN ,LGN_FAL_CD)
	SELECT  T1.CUS_ID ,T2.LGN_DT
			,CASE WHEN T1.CUS_ID = 'CUS_0001' AND RNO >= 4998 THEN 'N' ELSE 'Y' END SUC_YN
			,CASE WHEN T1.CUS_ID = 'CUS_0001' AND RNO >= 4998 THEN 'PW.WRONG' ELSE NULL END LGN_FAL_CD
	FROM    M_CUS T1
			,(    SELECT TO_DATE('20170301','YYYYMMDD') + (ROWNUM / 24 / 60 / 30) LGN_DT
						,ROWNUM  RNO
				  FROM  DUAL A CONNECT BY ROWNUM <= 5000
			) T2;

		

-- ************************************************
-- PART III - 8.4.3 SQL2
-- ************************************************

	-- �α��� ���� ���� ī��Ʈ ? ���� ���� ���
	SELECT  COUNT(*)
	FROM    T_CUS_LGN T1
	WHERE   T1.LGN_DT > (
					SELECT  MAX(T1.LGN_DT) LAST_SUC_DT
					FROM    T_CUS_LGN T1
					WHERE   T1.CUS_ID = 'CUS_0001'
					AND     T1.SUC_YN = 'Y')
	AND     T1.CUS_ID = 'CUS_0001'
	AND     T1.SUC_YN = 'N';

-- ************************************************
-- PART III - 8.4.3 SQL3
-- ************************************************
			
	-- �α��� ���� ���� ī��Ʈ ? ROWNUM�� �ε����� Ȱ���� ȿ������ ���
	SELECT  COUNT(*)
	FROM    (
			SELECT  *
			FROM    (
					SELECT  *
					FROM    T_CUS_LGN T1
					WHERE   T1.CUS_ID = 'CUS_0001'
					ORDER BY T1.LGN_DT DESC
					) T2
			WHERE   ROWNUM <= 3
			) T3
	WHERE   T3.SUC_YN = 'N';


-- ************************************************
-- PART III - 8.4.3 SQL4
-- ************************************************
	-- �α��� ���� ���� ī��Ʈ ? ROWNUM�� �ε����� �� �� ����� ���
	SELECT  *
	FROM    (
			SELECT  *
			FROM    T_CUS_LGN T1
			WHERE   T1.CUS_ID = 'CUS_0001'
			ORDER BY T1.LGN_DT DESC
			) T2
	WHERE   ROWNUM <= 3
	AND     T2.SUC_YN = 'N'







