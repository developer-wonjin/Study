-- SYS
DROP USER U1 CASCADE;
CREATE USER U1 IDENTIFIED BY U1;

-- U1 사용자로 로그인
SQLPLUS U1/U1

-- SYS
GRANT CREATE SESSION TO U1;

-- U1 사용자로 로그인
SQLPLUS U1/U1
