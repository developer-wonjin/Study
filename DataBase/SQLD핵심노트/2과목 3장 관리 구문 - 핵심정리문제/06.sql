DROP TABLE T1 PURGE;

CREATE TABLE T1 (C1 NUMBER, CONSTRAINT T1_PK PRIMARY KEY (C1));

-- S1
INSERT INTO T1 VALUES (1);
-- S2
INSERT INTO T1 VALUES (1);
-- S1
COMMIT;
-- S2
INSERT INTO T1 VALUES (2);
-- S1
INSERT INTO T1 VALUES (2);
-- S2
ROLLBACK;
-- S1
COMMIT;
