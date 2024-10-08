DROP TABLE T1 PURGE;

CREATE TABLE T1 (C1 NUMBER, C2 NUMBER, C3 NUMBER);

INSERT INTO T1 (C1, C2, C3) VALUES (1,  100, NULL);
INSERT INTO T1 (C1, C2, C3) VALUES (1,  150, NULL);
INSERT INTO T1 (C1, C2, C3) VALUES (2, NULL,  100);
INSERT INTO T1 (C1, C2, C3) VALUES (2,   50,  200);
INSERT INTO T1 (C1, C2, C3) VALUES (3, NULL,  300);

COMMIT;

SELECT C1, MIN (C2) + NVL (MAX (C3), 0) AS R1
  FROM T1
 GROUP BY C1;
