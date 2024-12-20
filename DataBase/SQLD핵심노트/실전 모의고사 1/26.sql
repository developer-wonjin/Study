DROP TABLE T1 PURGE;

CREATE TABLE T1 (C1 NUMBER, C2 NUMBER);

INSERT INTO T1 VALUES (1, 1);
INSERT INTO T1 VALUES (1, 2);
INSERT INTO T1 VALUES (2, 1);
INSERT INTO T1 VALUES (2, 2);

COMMIT;

SELECT * FROM T1 WHERE (C1 = 1 OR C2 = 1);

SELECT * FROM T1 WHERE C1 = 1
UNION
SELECT * FROM T1 WHERE C2 = 1;
