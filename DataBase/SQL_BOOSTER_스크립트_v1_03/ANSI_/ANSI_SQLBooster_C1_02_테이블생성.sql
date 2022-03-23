-- ************************************************
-- PART I - 1.2.1 SQL1, ���⼭���ʹ� ORA_SQL_TEST ����ڸ� ����մϴ�.
-- ���̺� ����.
-- ************************************************
	------------------------------------------------------------
	-- �����ڵ�(�����ڵ�, �����ڵ�, �׷��ڵ� ������ �Ҹ���)
	------------------------------------------------------------
	CREATE TABLE C_BAS_CD
	(
		BAS_CD_DV             VARCHAR2(40)  NOT NULL,
		LNG_CD                VARCHAR2(40)  NOT NULL,
		BAS_CD                VARCHAR2(40)  NOT NULL,
		BAS_CD_NM             VARCHAR2(100)  NULL,
		SRT_OD                NUMBER(18)  NULL 
	);

	CREATE UNIQUE INDEX PK_C_BAS_CD ON C_BAS_CD(BAS_CD_DV  ASC,LNG_CD  ASC,BAS_CD  ASC);

	ALTER TABLE C_BAS_CD
		ADD CONSTRAINT  PK_C_BAS_CD PRIMARY KEY (BAS_CD_DV,LNG_CD,BAS_CD);


	------------------------------------------------------------
	-- �����ڵ屸��
	------------------------------------------------------------
	CREATE TABLE C_BAS_CD_DV
	(
		BAS_CD_DV             VARCHAR2(40)  NOT NULL,
		BAS_CD_DV_NM          VARCHAR2(100)  NULL 
	);

	CREATE UNIQUE INDEX PK_C_BAS_CD_DV ON C_BAS_CD_DV(BAS_CD_DV  ASC);

	ALTER TABLE C_BAS_CD_DV
		ADD CONSTRAINT  PK_C_BAS_CD_DV PRIMARY KEY (BAS_CD_DV);


	------------------------------------------------------------
	-- ������ ���̺�.
	-- ������ = ���� �ǸŰ� �߻��ϰų� ��� ������ �Ǵ� ��ǰ ����.
	------------------------------------------------------------
	CREATE TABLE M_ITM
	(
		ITM_ID                VARCHAR2(40)  NOT NULL,
		ITM_NM                VARCHAR2(100)  NULL,
		ITM_TP                VARCHAR2(40)  NULL,
		UNT_PRC               NUMBER(18,3)  NULL 
	);

	CREATE UNIQUE INDEX PK_M_ITM ON M_ITM(ITM_ID  ASC);

	ALTER TABLE M_ITM
		ADD CONSTRAINT  PK_M_ITM PRIMARY KEY (ITM_ID);


	------------------------------------------------------------
	-- ������ �ܰ� �̷� ���̺�.
	------------------------------------------------------------
	CREATE TABLE M_ITM_PRC_HIS
	(
		ITM_ID                VARCHAR2(40)  NOT NULL,
		TO_YMD                VARCHAR2(8)  NOT NULL,
		FR_YMD                VARCHAR2(8)  NULL,
		UNT_PRC               NUMBER(18,3)  NULL 
	);

	CREATE UNIQUE INDEX PK_M_ITM_PRC_HIS ON M_ITM_PRC_HIS(ITM_ID  ASC,TO_YMD  ASC);

	ALTER TABLE M_ITM_PRC_HIS
		ADD CONSTRAINT  PK_M_ITM_PRC_HIS PRIMARY KEY (ITM_ID,TO_YMD);


	------------------------------------------------------------
	-- ���� ������ ���̺�
	------------------------------------------------------------
	CREATE TABLE M_RGN
	(
		RGN_ID                VARCHAR2(40)  NOT NULL,
		RGN_NM                VARCHAR2(100)  NULL,
		SRT_OD                NUMBER(18)  NULL 
	);

	CREATE UNIQUE INDEX PK_M_RGN ON M_RGN(RGN_ID  ASC);

	ALTER TABLE M_RGN
		ADD CONSTRAINT  PK_M_RGN PRIMARY KEY (RGN_ID);


	------------------------------------------------------------
	-- �� ������ ���̺�
	------------------------------------------------------------
	CREATE TABLE M_CUS
	(
		CUS_ID                VARCHAR2(40)  NOT NULL,
		CUS_NM                VARCHAR2(100)  NULL,
		MBL_NO                VARCHAR2(100)  NULL,
		EML_AD                VARCHAR2(100)  NULL,
		PWD                   VARCHAR2(200)  NULL,
		RGN_ID                VARCHAR2(40)  NULL,
		ADR_TXT               VARCHAR2(200)  NULL,
		GND_TP                VARCHAR2(40)  NULL,
		BTH_YMD               VARCHAR2(8)  NULL,
		CUS_GD                VARCHAR2(40)  NULL 
	);

	CREATE UNIQUE INDEX PK_M_CUS ON M_CUS(CUS_ID  ASC);

	ALTER TABLE M_CUS
		ADD CONSTRAINT  PK_M_CUS PRIMARY KEY (CUS_ID);


	------------------------------------------------------------
	-- ������ ��
	-- ���� �����ۿ� �򰡸� ������ ���.
	------------------------------------------------------------
	CREATE TABLE T_ITM_EVL
	(
		ITM_ID                VARCHAR2(40)  NOT NULL,
		EVL_LST_NO            NUMBER(18)  NOT NULL,
		CUS_ID                VARCHAR2(40)  NOT NULL,
		EVL_DSC               VARCHAR2(1000)  NULL,
		EVL_DT                DATE  NULL,
		EVL_PT                NUMBER(18,2)  NULL 
	);

	CREATE UNIQUE INDEX PK_T_ITM_EVL ON T_ITM_EVL(ITM_ID  ASC,EVL_LST_NO  ASC);

	ALTER TABLE T_ITM_EVL
		ADD CONSTRAINT  PK_T_ITM_EVL PRIMARY KEY (ITM_ID,EVL_LST_NO);

	------------------------------------------------------------
	-- �ֹ�
	------------------------------------------------------------
	CREATE TABLE T_ORD
	(
		ORD_SEQ               NUMBER(18)  NOT NULL,
		CUS_ID                VARCHAR2(40)  NOT NULL,
		ORD_DT                DATE  NULL,
		ORD_ST                VARCHAR2(40)  NULL,
		PAY_DT                DATE  NULL,
		PAY_TP                VARCHAR2(40)  NULL,
		ORD_AMT               NUMBER(18,3)  NULL,
		PAY_AMT               NUMBER(18,3)  NULL 
	);

	CREATE UNIQUE INDEX PK_T_ORD ON T_ORD(ORD_SEQ  ASC);

	ALTER TABLE T_ORD
		ADD CONSTRAINT  PK_T_ORD PRIMARY KEY (ORD_SEQ);


	------------------------------------------------------------
	-- �ֹ���
	------------------------------------------------------------
	CREATE TABLE T_ORD_DET
	(
		ORD_SEQ               NUMBER(18)  NOT NULL,
		ORD_DET_NO            NUMBER(18)  NOT NULL,
		ITM_ID                VARCHAR2(40)  NOT NULL,
		ORD_QTY               NUMBER(18)  NULL,
		UNT_PRC               NUMBER(18,3)  NULL 
	);

	CREATE UNIQUE INDEX PK_T_ORD_DET ON T_ORD_DET(ORD_SEQ  ASC,ORD_DET_NO  ASC);

	ALTER TABLE T_ORD_DET
		ADD CONSTRAINT  PK_T_ORD_DET PRIMARY KEY (ORD_SEQ,ORD_DET_NO);


	------------------------------------------------------------
	-- FOREIGN KEY������.
	------------------------------------------------------------
	ALTER TABLE C_BAS_CD
		ADD (CONSTRAINT  FK_C_BAS_CD_DV_1 FOREIGN KEY (BAS_CD_DV) REFERENCES C_BAS_CD_DV(BAS_CD_DV));

	ALTER TABLE M_ITM_PRC_HIS
		ADD (CONSTRAINT FK_M_ITM_PRC_HIS FOREIGN KEY (ITM_ID) REFERENCES M_ITM(ITM_ID));

	ALTER TABLE M_CUS
		ADD (CONSTRAINT FK_CUS_1 FOREIGN KEY (RGN_ID) REFERENCES M_RGN(RGN_ID));

	ALTER TABLE T_ITM_EVL
		ADD (CONSTRAINT FK_T_ITM_EVL_1 FOREIGN KEY (CUS_ID) REFERENCES M_CUS(CUS_ID));

	ALTER TABLE T_ITM_EVL
		ADD (CONSTRAINT FK_T_ITM_EVL_2 FOREIGN KEY (ITM_ID) REFERENCES M_ITM(ITM_ID));

	ALTER TABLE T_ORD
		ADD (CONSTRAINT FK_T_ORD_1 FOREIGN KEY (CUS_ID) REFERENCES M_CUS(CUS_ID));

	ALTER TABLE T_ORD_DET
		ADD (CONSTRAINT FK_T_ORD_DET_1 FOREIGN KEY (ORD_SEQ) REFERENCES T_ORD(ORD_SEQ));