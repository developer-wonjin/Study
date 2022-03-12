-- ************************************************
-- PART I - 1.1.1 SQL1, SYS USER 사용 - 테이블스페이스 생성
-- ************************************************
	CREATE TABLESPACE ORA_SQL_TEST_TS DATAFILE 'E:\ORA_SQL_TEST\ORA_SQL_TEST.DBA' SIZE 10G EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;


-- ************************************************
-- PART I - 1.1.2 SQL1, SYS USER 사용 - 사용자 생성
-- ************************************************
	CREATE USER ORA_SQL_TEST IDENTIFIED BY "1qaz2wsx" DEFAULT TABLESPACE ORA_SQL_TEST_TS;



-- ************************************************
-- PART I - 1.1.2 SQL2, SYS USER 사용 - 사용자 접속 권한 설정
-- ************************************************
	ALTER USER ORA_SQL_TEST ACCOUNT UNLOCK;
	GRANT CONNECT, RESOURCE TO ORA_SQL_TEST;


-- ************************************************
-- PART I - 1.1.2 SQL3, SYS USER 사용 - 사용자 성능 뷰 권한 설정
-- ************************************************
	GRANT ALTER SYSTEM TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SQL TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SQL_PLAN_STATISTICS_ALL TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SQL_PLAN TO ORA_SQL_TEST;
	GRANT SELECT ON V_$SESSION TO ORA_SQL_TEST;
	GRANT EXECUTE ON DBMS_STATS TO ORA_SQL_TEST;
	GRANT SELECT ON DBA_SEGMENTS TO ORA_SQL_TEST;



-- ************************************************
-- PART I - 1.1.2 SQL4, SYS USER 사용 - TEMP 크기 확인
-- ************************************************
	SELECT  T1.FILE_NAME
			,(T1.BYTES / 1024 / 1024) TMP_MB
	FROM    DBA_TEMP_FILES T1;


-- ************************************************
-- PART I - 1.1.2 SQL5, SYS USER 사용 - TEMP 크기 변경
-- ************************************************
	ALTER DATABASE TEMPFILE 'E:\ORACLEXE\APP\ORACLE\ORADATA\XE\TEMP.DBF' RESIZE 5000M;

