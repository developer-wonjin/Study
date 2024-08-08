-- ************************************************
-- PART I - 1.1.1 SQL1, SYS USER 사용 - 테이블스페이스 생성
-- ************************************************
CREATE TABLESPACE SQL_POWERUP_TS DATAFILE 'C:\ORA_SQL_TEST\SQL_POWERUP.DBA' SIZE 10G EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;


-- ************************************************
-- PART I - 1.1.2 SQL1, SYS USER 사용 - 사용자 생성
-- ************************************************
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER SQL_POWERUP  IDENTIFIED BY "1234" DEFAULT TABLESPACE SQL_POWERUP_TS;


-- ************************************************
-- PART I - 1.1.2 SQL2, SYS USER 사용 - 사용자 접속 권한 설정
-- ************************************************
ALTER USER SQL_POWERUP ACCOUNT UNLOCK;
GRANT CONNECT, RESOURCE TO SQL_POWERUP;

-- ************************************************
-- PART I - 1.1.2 SQL3, SYS USER 사용 - 사용자 성능 뷰 권한 설정
-- ************************************************
GRANT ALTER SYSTEM TO SQL_POWERUP;
GRANT SELECT ON V_$SQL TO SQL_POWERUP;
GRANT SELECT ON V_$SQL_PLAN_STATISTICS_ALL TO SQL_POWERUP;
GRANT SELECT ON V_$SQL_PLAN TO SQL_POWERUP;
GRANT SELECT ON V_$SESSION TO SQL_POWERUP;
GRANT EXECUTE ON DBMS_STATS TO SQL_POWERUP;
GRANT SELECT ON DBA_SEGMENTS TO SQL_POWERUP;

-- ************************************************
-- PART I - 1.1.2 SQL4, SYS USER 사용 - TEMP 크기 확인
-- ************************************************
SELECT  T1.FILE_NAME
		,(T1.BYTES / 1024 / 1024) TMP_MB
FROM    DBA_TEMP_FILES T1;


-- ************************************************
-- PART I - 1.1.2 SQL5, SYS USER 사용 - TEMP 크기 변경
-- ************************************************
ALTER DATABASE TEMPFILE 'C:\app\ora19c\oradata\ORCL\TEMP01.DBF' RESIZE 5000M;

