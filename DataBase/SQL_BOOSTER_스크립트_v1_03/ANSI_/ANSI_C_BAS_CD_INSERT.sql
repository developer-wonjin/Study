-- ************************************************
-- PART I - 1.2.2 SQL10
-- ************************************************
	-- �����ڵ� ������ ����
	INSERT INTO C_BAS_CD (BAS_CD_DV ,LNG_CD ,BAS_CD ,BAS_CD_NM ,SRT_OD)
	SELECT  'LNG_CD' BAS_CD_DV ,'KO' LNG_CD ,'KO' BAS_CD ,'�ѱ���' BAS_CD_NM ,10 SRT_OD FROM DUAL UNION ALL        
	SELECT  'LNG_CD' ,'KO' ,'EN' ,'����' ,20 FROM DUAL UNION ALL        
	SELECT  'LNG_CD' ,'KO' ,'CN' ,'�߱���' ,30 FROM DUAL UNION ALL    
	SELECT  'ITM_TP' ,'KO' ,'ELEC' ,'������ǰ' ,10 FROM DUAL UNION ALL
	SELECT  'ITM_TP' ,'KO' ,'PC' ,'��ǻ��' ,20 FROM DUAL UNION ALL
	SELECT  'ITM_TP' ,'KO' ,'COOK' ,'�ֹ浵��' ,30 FROM DUAL UNION ALL
	SELECT  'ITM_TP' ,'KO' ,'CLOTHES' ,'��' ,40 FROM DUAL UNION ALL
	SELECT  'ORD_ST' ,'KO' ,'WAIT' ,'���' ,10 FROM DUAL UNION ALL
	SELECT  'ORD_ST' ,'KO' ,'COMP' ,'�Ϸ�' ,20 FROM DUAL UNION ALL
	SELECT  'PAY_TP' ,'KO' ,'BANK' ,'������ü' ,10 FROM DUAL UNION ALL
	SELECT  'PAY_TP' ,'KO' ,'CARD' ,'ī��' ,20 FROM DUAL UNION ALL
	SELECT  'GND_TP' ,'KO' ,'FEMLE' ,'����' ,10 FROM DUAL UNION ALL
	SELECT  'GND_TP' ,'KO' ,'MALE' ,'����' ,20 FROM DUAL UNION ALL
	SELECT  'CUS_GD' ,'KO' ,'A' ,'A' ,10 FROM DUAL UNION ALL
	SELECT  'CUS_GD' ,'KO' ,'B' ,'B' ,20 FROM DUAL;
	COMMIT;