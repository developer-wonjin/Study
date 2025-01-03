DROP TABLE T1 PURGE;

CREATE TABLE T1 (
    JOB     VARCHAR2(10)
  , D10_SAL NUMBER, D20_SAL NUMBER, D30_SAL NUMBER
  , D10_CNT NUMBER, D20_CNT NUMBER, D30_CNT NUMBER);

INSERT INTO T1 VALUES ('ANALYST'  , NULL, 6000, NULL, 0, 2, 0);
INSERT INTO T1 VALUES ('CLERK'    , 1300, 1900,  950, 1, 2, 1);
INSERT INTO T1 VALUES ('MANAGER'  , 2450, 2975, 2850, 1, 1, 1);
INSERT INTO T1 VALUES ('PRESIDENT', 5000, NULL, NULL, 1, 0, 0);
INSERT INTO T1 VALUES ('SALESMAN' , NULL, NULL, 5600, 0, 0, 4);

COMMIT;

 SELECT *
   FROM T1
UNPIVOT ((SAL, CNT)
         FOR (DEPTNO, DNAME) IN ((D10_SAL, D10_CNT) AS (10, 'ACCOUNTING')
                               , (D20_SAL, D20_CNT) AS (20, 'DALLAS')
                               , (D30_SAL, D30_CNT) AS (30, 'CHICAGO')))
  WHERE JOB = 'CLERK'
  ORDER BY JOB, DEPTNO;
