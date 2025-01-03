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

SELECT A.JOB
     , DECODE (B.LV, 1, 10, 2, 20, 3, 30) AS DEPTNO
     , DECODE (B.LV, 1, A.D10_SAL, 2, A.D20_SAL, 3, A.D30_SAL) AS SAL
  FROM T1 A
     , (SELECT LEVEL AS LV FROM DUAL CONNECT BY LEVEL <= 3) B
 WHERE A.JOB = 'CLERK'
 ORDER BY JOB, DEPTNO;
