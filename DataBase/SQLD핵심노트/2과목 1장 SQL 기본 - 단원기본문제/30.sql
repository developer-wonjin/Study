DROP TABLE T1 PURGE;
DROP TABLE T2 PURGE;

CREATE TABLE T1 (C1 NUMBER, C2 VARCHAR2(1));
CREATE TABLE T2 (C1 NUMBER, C3 VARCHAR2(1));

INSERT INTO T1 (C1, C2) VALUES (1, 'A');
INSERT INTO T1 (C1, C2) VALUES (2, 'B');
INSERT INTO T1 (C1, C2) VALUES (3, 'C');

INSERT INTO T2 (C1, C3) VALUES (1, 'A');
INSERT INTO T2 (C1, C3) VALUES (1, 'B');
INSERT INTO T2 (C1, C3) VALUES (2, 'B');
INSERT INTO T2 (C1, C3) VALUES (3, 'C');
INSERT INTO T2 (C1, C3) VALUES (3, 'A');
INSERT INTO T2 (C1, C3) VALUES (4, 'B');

COMMIT;

SELECT SUM (C1) AS R1
  FROM T1 A NATURAL JOIN T2 B;
