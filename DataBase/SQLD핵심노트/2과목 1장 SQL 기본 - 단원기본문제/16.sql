DROP TABLE T1;

CREATE TABLE T1 (C1 NUMBER);

INSERT INTO T1 (C1) VALUES (1000);
INSERT INTO T1 (C1) VALUES (2000);
INSERT INTO T1 (C1) VALUES (NULL);
INSERT INTO T1 (C1) VALUES (1500);

COMMIT;

SELECT *
  FROM T1
 WHERE NOT (C1 <= 1000);
