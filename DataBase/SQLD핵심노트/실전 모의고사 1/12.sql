DROP TABLE T1 PURGE;

CREATE TABLE T1 (C1 VARCHAR2(1), C2 VARCHAR2(1));

INSERT INTO T1 (C1, C2) VALUES ('A', 'B');
INSERT INTO T1 (C1, C2) VALUES ('A', 'D');
INSERT INTO T1 (C1, C2) VALUES ('B', 'D');
INSERT INTO T1 (C1, C2) VALUES ('B', 'D');
INSERT INTO T1 (C1, C2) VALUES ('B', 'E');

COMMIT;

SELECT DISTINCT C1 FROM T1;

SELECT C2 FROM T1;

SELECT DISTINCT C1, C2 FROM T1;
