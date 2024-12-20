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
INSERT INTO T2 (C1, C3) VALUES (2, 'B');
INSERT INTO T2 (C1, C3) VALUES (3, 'C');

COMMIT;

SELECT *
  FROM T1 A LEFT OUTER JOIN T2 B
    ON B.C1 = A.C1
   AND B.C3 = 'B'
 WHERE A.C2 IN ('B', 'C');

SELECT *
  FROM T1 A, T2 B
 WHERE A.C2 IN ('B', 'C')
   AND B.C1 = A.C1
   AND B.C3 = 'B';

SELECT *
  FROM T1 A, T2 B
 WHERE A.C2 IN ('B', 'C')
   AND B.C1(+) = A.C1
   AND B.C3(+) = 'B';

SELECT *
  FROM T1 A, T2 B
 WHERE A.C2(+) IN ('B', 'C')
   AND B.C1 = A.C1(+)
   AND B.C3 = 'B';

SELECT *
  FROM T1 A, T2 B
 WHERE A.C2 IN ('B', 'C')
   AND B.C1(+) = A.C1
   AND B.C3 = 'B';
