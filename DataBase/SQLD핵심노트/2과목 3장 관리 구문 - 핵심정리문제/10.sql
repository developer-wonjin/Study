-- SYS
DROP USER U1 CASCADE;
DROP USER U2 CASCADE;

CREATE USER U1 IDENTIFIED BY U1;
CREATE USER U2 IDENTIFIED BY U2;

GRANT CREATE SESSION TO U1, U2;
GRANT CREATE ROLE TO U2;

-- U2
CREATE TABLE T1 (C1 NUMBER);

CREATE ROLE R1;
GRANT ALL ON T1 TO R1;
GRANT R1 TO U1;

REVOKE R1 FROM U1;
REVOKE ALL ON T1 FROM R1;
DROP ROLE R1;
