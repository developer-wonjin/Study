DROP TABLE T1 PURGE;

CREATE TABLE T1 (C1 VARCHAR2(1), C2 NUMBER);

INSERT INTO T1 (C1, C2) VALUES ('A', 1000);
INSERT INTO T1 (C1, C2) VALUES ('A', 2000);
INSERT INTO T1 (C1, C2) VALUES ('B', 1000);
INSERT INTO T1 (C1, C2) VALUES ('B', NULL);
INSERT INTO T1 (C1, C2) VALUES ('B', 2000);
INSERT INTO T1 (C1, C2) VALUES ('C', NULL);

COMMIT;

SELECT C1
     , NVL (AVG (C2), 0) AS AVG1
     , AVG (NVL (C2, 0)) AS AVG2
  FROM T1
 GROUP BY C1;
