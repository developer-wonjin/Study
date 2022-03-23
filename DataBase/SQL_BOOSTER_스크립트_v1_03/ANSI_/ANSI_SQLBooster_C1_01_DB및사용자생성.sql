-- ************************************************
-- PART I - 1.1.1 SQL1, SYS USER ��� - ���̺����̽� ����
-- ************************************************
	CREATE TABLESPACE ORA_SQL_TEST_TS DATAFILE 'E:\ORA_SQL_TEST\ORA_SQL_TEST.DBA' SIZE 10G EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;


-- ************************************************
-- PART I - 1.1.2 SQL1, SYS USER ��� - ����� ����
-- ************************************************
	CREATE USER ORA_SQL_TEST IDENTIFIED BY "1qaz2wsx" DEFAULT TABLESPACE ORA_SQL_TEST_TS;



-- ************************************************
-- PART I - 1.1.2 SQL2, SYS USER ��� - ����� ���� ���� ����
-- ************************************************
	ALTER USER ORA_SQL_TEST ACCOUNT UNLOCK;
	GRANT CONNECT, RESOURCE TO ORA_SQL_TEST;


-- ************************************************
-- PART I - 1.1.2 SQL3, SYS USER ��� - ����� ���� �� ���� ����
-- ************************************************
	GRANT ALTER SYSTEM TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SQL TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SQL_PLAN_STATISTICS_ALL TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SQL_PLAN TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SESSION TO ORA_SQL_TEST;
	GRANT EXECUTE ON DBMS_STATS TO ORA_SQL_TEST;
	GRANT SELECT ON DBA_SEGMENTS TO ORA_SQL_TEST;



-- ************************************************
-- PART I - 1.1.2 SQL4, SYS USER ��� - TEMP ũ�� Ȯ��
-- ************************************************
	SELECT  T1.FILE_NAME
			,(T1.BYTES / 1024 / 1024) TMP_MB
	FROM    DBA_TEMP_FILES T1;


-- ************************************************
-- PART I - 1.1.2 SQL5, SYS USER ��� - TEMP ũ�� ����
-- ************************************************
	ALTER DATABASE TEMPFILE 'E:\ORACLEXE\APP\ORACLE\ORADATA\XE\TEMP.DBF' RESIZE 5000M;

