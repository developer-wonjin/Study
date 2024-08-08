DROP TABLE T1;

CREATE TABLE T1 (C1 NUMBER, C2 NUMBER);

INSERT INTO T1 (C1, C2) VALUES (1, 1);
INSERT INTO T1 (C1, C2) VALUES (2, 2);
INSERT INTO T1 (C1, C2) VALUES (3, 3);
INSERT INTO T1 (C1, C2) VALUES (4, 1);
INSERT INTO T1 (C1, C2) VALUES (5, 2);

COMMIT;

SELECT 6 - A.C1 AS C1
     , CASE
           WHEN A.C1 >= 4      THEN 'A'
           WHEN A.C2 IN (1, 3) THEN 'B'
           ELSE 'C'
       END AS C2
  FROM T1 A
 ORDER BY A.C2 DESC, A.C1 DESC;

SELECT 6 - A.C1 AS C1
     , CASE
           WHEN A.C1 >= 4      THEN 'A'
           WHEN A.C2 IN (1, 3) THEN 'B'
           ELSE 'C'
       END AS C2
  FROM T1 A
 ORDER BY C2 DESC, A.C1;

SELECT 6 - A.C1 AS C1
     , CASE
           WHEN A.C1 >= 4      THEN 'A'
           WHEN A.C2 IN (1, 3) THEN 'B'
           ELSE 'C'
       END AS C2
  FROM T1 A
 ORDER BY A.C2 DESC, C1 DESC;

SELECT 6 - A.C1 AS C1
     , CASE
           WHEN A.C1 >= 4      THEN 'A'
           WHEN A.C2 IN (1, 3) THEN 'B'
           ELSE 'C'
       END AS C2
  FROM T1 A
 ORDER BY C2 DESC, C1;
