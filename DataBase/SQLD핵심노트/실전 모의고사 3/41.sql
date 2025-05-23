DROP TABLE T1 CASCADE CONSTRAINTS PURGE;
DROP TABLE T2 CASCADE CONSTRAINTS PURGE;
DROP TABLE T3 CASCADE CONSTRAINTS PURGE;

CREATE TABLE T1 (C1 NUMBER, CONSTRAINT T1_PK PRIMARY KEY (C1));

CREATE TABLE T2 (C1 NUMBER NOT NULL
               , C2 NUMBER
               , CONSTRAINT T2_PK PRIMARY KEY (C1, C2)
               , CONSTRAINT T2_F1 FOREIGN KEY (C1) REFERENCES T1 (C1)
               , CONSTRAINT T2_C1 CHECK (C2 > 0));

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'T2';

CREATE TABLE T3 AS SELECT * FROM T2;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'T3';